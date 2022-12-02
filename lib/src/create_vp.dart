import 'dart:convert';
import 'package:dart_bbs/dart_bbs.dart';
// input  : signature
//        : publickey
//        : VC(disclosed message)
//
// output : VP

Future<String> createVP(signature, publicKey, VC) async {
  var proof = await createBbsProof(signature, publicKey, VC);
  VC["proof"] = proof;

  return json.encode(VC);
}
