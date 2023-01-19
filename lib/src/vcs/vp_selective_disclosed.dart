import 'dart:convert';
import 'package:dart_bbs/src/bls_signature/bls_create_proof.dart';
import 'package:dart_bbs/src/models/vc.dart';
import 'package:dart_bbs/src/rsa_signature/rsa_sign.dart';
import 'package:dart_bbs/src/utils/get_date.dart';

import 'package:nonce/nonce.dart';

// input  : VC        String
//          revealed  List<???>
//
// output : proof value

Future<Map> vpSelectiveDisclosed(signedVC, revealedIndices, publicKey) async {
  VerifiableCredential signedVC_ = VerifiableCredential(signedVC);

  /* getProofValue */
  String signature = signedVC_.getSignature();

  // should be obtained from VDR
  // String publicKey = "feghtwjyet";

  List<String> messages = signedVC_.messages;

  // convert from List<String> to List<Int>
  List<int> revealed = signedVC_.getRevealedIndices(revealedIndices);

  String nonce = Nonce.generate(64);

  String proofValue =
      await blsCreateProof(signature, publicKey, messages, revealed, nonce);

  /* createProof 
     by issuer's publicKey
  */
  var blsProof = {
    "type": "BbsBlsSignatureProof2020",
    "created": getDate(),
    "verificationMethod": signedVC_.getVerificationMethod(),
    "proofPurpose": "assertionMethod",
    "proofValue": proofValue,
    "nonce": nonce
  };

  /* composeVP */
  // selectively disclosed
  Map selectiveDisclosedVC =
      signedVC_.createVPWithSelectiveDisclosure(revealed);

  selectiveDisclosedVC["proof"] = blsProof;
  return selectiveDisclosedVC;
}
