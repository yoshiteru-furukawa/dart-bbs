import 'dart:convert';
import 'package:dart_bbs/src/bls_signature/bls_create_proof.dart';
import 'package:dart_bbs/src/models/vc.dart';
import 'package:dart_bbs/src/utils/get_date.dart';

import 'package:nonce/nonce.dart';

// input  : VC        String
//          revealed  List<???>
//
// output : proof value

Future<String> vpCreate(signedVC, revealedIndices, publicKey) async {
  VerifiableCredential VC_ = VerifiableCredential(signedVC);

  /* getProofValue */
  String signature = VC_.getSignature();

  // should be obtained from VDR
  // String publicKey = "feghtwjyet";

  List<String> messages = VC_.messages;

  // convert from List<String> to List<Int>
  List<int> revealed = VC_.getRevealedIndices(revealedIndices);

  String nonce = Nonce.generate(64);

  String proofValue =
      await blsCreateProof(signature, publicKey, messages, revealed, nonce);

  /* createProof */
  var proof = {
    "type": "BbsBlsSignatureProof2020",
    "created": getDate(),
    "verificationMethod": VC_.getVerificationMethod(),
    "proofPurpose": "assertionMethod",
    "proofValue": proofValue,
    "nonce": nonce
  };

  /* composeVP */
  // selectively disclosed
  Map VP = VC_.createVPWithSelectiveDisclosure(revealed);
  VP["proof"] = proof;
  return json.encode(VP);
}
