import 'package:dart_bbs/src/create_proof_value.dart';
import 'package:intl/intl.dart';
import 'package:nonce/nonce.dart';

String getDate() {
  DateTime now = DateTime.now();
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  String date = outputFormat.format(now);
  return date;
}

// input  : signature String
//        : publickey String
//        : messages String[]
//        : revealed Number[]
//        : nonce string
//
// output : proof

Future<Map> createBbsProof(
    signature, publicKey, messages, revealed, nonce) async {
  var proofValue =
      await createProofValue(signature, publicKey, messages, revealed, nonce);
  var proof = {
    "type": "BbsBlsSignatureProof2020",
    "created": getDate(),

    // where can "verificationMethod" be obtained
    "verificationMethod": messages[0]["proof"]["verificationMethod"], // issuer

    "proofPurpose": "assertionMethod",
    "proofValue": proofValue,
    "nonce": Nonce.generate(64)
  };
  return proof;
}
