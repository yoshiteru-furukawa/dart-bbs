import 'dart:convert';
import 'package:dart_bbs/dart_bbs.dart';
// input  : signature String
//        : publickey String
//        : messages String[]
//        : revealed Number[]
//        : nonce string
//
// output : proof value

Future<String> createVP(signature, publicKey, messages, revealed, nonce) async {
  var proof =
      await createBbsProof(signature, publicKey, messages, revealed, nonce);
  Map VP = messages[0];
  for (var i = 1; i < messages.length; i++) {
    if (revealed.includes(i)) {
      VP = {...VP, ...messages[i]};
    }
  }
  VP["proof"] = proof;
  return json.encode(VP);
}
