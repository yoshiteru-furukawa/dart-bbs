import 'dart:convert';
import 'package:dart_bbs/src/models/vc.dart';
import 'package:dart_bbs/src/utils/get_date.dart';
import 'package:dart_bbs/src/vc_create/get_proof_value.dart';

// input  : VC        String
//          revealed  List<???>
//
// output : proof value

Future<String> vcCreate(VC, secretKey, publicKey) async {
  Map VC1 = json.decode(VC);
  VC1["issuanceDate"] = getDate();

  VerifiableCredential VC_ = VerifiableCredential(json.encode(VC1));

  // should be obtained from VDR
  // String secretKey = "feghtwjyet";
  // String publicKey = "feghtwjyet";

  List<String> messages = VC_.messages;

  String proofValue = await getProofValue(publicKey, secretKey, messages);

  /* createProof */
  var proof = {
    "type": "BbsBlsSignatureProof2020",
    "created": getDate(),

    // should be updated (how to obtain veriMethod)
    "verificationMethod": VC_.getVerificationMethod(),
    "proofPurpose": "assertionMethod",
    "proofValue": proofValue,
  };

  /* createVC */
  Map signedVC = VC_.mapVC;
  signedVC["proof"] = proof;

  return json.encode(signedVC);
}
