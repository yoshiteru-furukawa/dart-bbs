import 'package:dart_bbs/src/create_proof_value.dart';
import 'package:intl/intl.dart';
import 'package:nonce/nonce.dart';

String getDate() {
  DateTime now = DateTime.now();
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  String date = outputFormat.format(now);
  return date;
}

// input  : signature
//        : publickey
//        : VC(disclosed message)
//
// output : proof

Future<Map> createBbsProof(signature, publicKey, VC) async {
  var proofValue = await createProofValue(signature, publicKey, VC);
  var proof = {
    "type": "BbsBlsSignatureProof2020",
    "created": getDate(),
    "verificationMethod": VC["proof"]["verificationMethod"], // issuer
    "proofPurpose": "assertionMethod",
    "proofValue": proofValue,
    "nonce": Nonce.generate(64)
  };
  return proof;
}
