import 'dart:convert';
import 'package:dart_bbs/src/models/vc.dart';
import 'package:dart_bbs/src/utils/get_date.dart';
import 'package:dart_bbs/src/vc_create/get_proof_value.dart';

// input  : VC        String
//
// output : signedVC

Future<String> blsSign(VC, secretKey, publicKey) async {
  Map VC1 = json.decode(VC);
  VC1["issuanceDate"] = getDate();

  // should be obtained from VDR
  // String secretKey = "feghtwjyet";
  // String publicKey = "feghtwjyet";

  List<String> messages = [json.encode(VC1)];

  String proofValue = await getProofValue(publicKey, secretKey, messages);

  /* createProof */
  var proof = {
    "type": "BbsBlsSignatureProof2020",
    "created": getDate(),

    // should be updated (how to obtain veriMethod)
    "verificationMethod": "test",
    "proofPurpose": "assertionMethod",
    "proofValue": proofValue,
  };

  /* createVC */
  VC1["proof"] = proof;

  return json.encode(VC1);
}
