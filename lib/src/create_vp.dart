import 'dart:convert';
import 'package:dart_bbs/dart_bbs.dart';
// input  : signature String
//        : publickey String
//        : messages String[]
//        : revealed Number[]
//        : nonce string
//
// output : proof value

String createVP(messages, revealed, proof) {
  Map VP = {...json.decode(messages[0]), ...json.decode(messages[1])};
  for (var i = 2; i < messages.length; i++) {
    if (revealed.contains(i)) {
      var message = json.decode(messages[i]);
      VP[message["type"]] = message["subject"];
    }
  }
  VP["proof"] = proof;
  return json.encode(VP);
}
