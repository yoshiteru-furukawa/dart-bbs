import 'dart:convert';
import 'package:dart_bbs/src/models/merge_fields.dart';
import 'package:dart_bbs/src/vp_create/get_proof_value.dart';
import 'package:dart_bbs/src/models/vc.dart';
import 'package:dart_bbs/src/utils/get_date.dart';

import 'package:nonce/nonce.dart';

// input  : VC        String
//          revealed  List<???>
//
// output : proof value

Future<String> vpCreate(signedVC, revealed, publicKey) async {
  VerifiableCredential VC_ = VerifiableCredential(signedVC);

  /* getProofValue */
  String signature = VC_.getSignature();

  // should be obtained from VDR
  // String publicKey = "feghtwjyet";

  List<String> messages = VC_.messages;

  // convert from List<String> to List<Int>
  List<int> revealedIndices = revealed;

  String nonce = Nonce.generate(64);

  String proofValue = await getProofValue(
      signature, publicKey, messages, revealedIndices, nonce);

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
  Map VP = json.decode(mergeFields(VC_.messagesWithMeta, revealed));
  VP["proof"] = proof;
  return json.encode(VP);
}
