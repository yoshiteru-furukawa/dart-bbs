import 'package:dart_bbs/src/create_proof_value.dart';
import 'package:intl/intl.dart';
import 'package:nonce/nonce.dart';

String getDate() {
  DateTime now = DateTime.now();
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  String date = outputFormat.format(now);
  return date;
}

// input  : nonce, proofValue, veriMethod
//
// output : proof

Map createBbsProof(nonce, proofValue, veriMethod) {
  var proof = {
    "type": "BbsBlsSignatureProof2020",
    "created": getDate(),
    "verificationMethod": veriMethod, 
    "proofPurpose": "assertionMethod",
    "proofValue": proofValue,
    "nonce": nonce
  };
  return proof;
}
