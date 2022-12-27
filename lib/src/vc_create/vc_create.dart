import 'dart:convert';
import 'package:dart_bbs/src/models/vc.dart';
import 'package:dart_bbs/src/utils/get_date.dart';
import 'package:dart_bbs/src/vc_create/get_proof_value.dart';

import 'package:nonce/nonce.dart';

// input  : VC        String
//          revealed  List<???>
//
// output : proof value

Future<String> vcCreate(VC) async {
  VerifiableCredential VC_ = VerifiableCredential(VC);

  // should be obtained from VDR
  String secretKey = "feghtwjyet";
  String publicKey = "feghtwjyet";

  List<String> messages = VC_.getMessages();

  String proofValue = await getProofValue(publicKey, secretKey, messages);

  /* createProof */
  var proof = {
    "type": "BbsBlsSignatureProof2020",
    "created": getDate(),
    "verificationMethod": VC_.getVerificationMethod(),
    "proofPurpose": "assertionMethod",
    "proofValue": proofValue,
  };

  /* createVC */
  Map signedVC = json.decode(VC_.rawVC);
  signedVC["proof"] = proof;
  signedVC["issuanceDate"] = getDate();

  return json.encode(signedVC);
}
