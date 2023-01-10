import 'dart:convert';

import 'package:dart_bbs/src/models/distribute_fields.dart';

class VerifiableCredential {
  String strVC;
  late Map mapVC = json.decode(strVC);
  late List<String> messagesWithMeta = getMessagesWithMeta();
  late List<String> messages = getMessages();
  late Map? proof = mapVC["proof"];

  Map requiredFieldsMap = {
    "root": [
      "@context",
      "id",
      "type",
      "issuer",
      "issuanceDate",
      "name",
    ],
    "holder": {
      "root": ["id", "type"]
    },
    "credentialSubject": {
      "root": ["id", "type", "identifier", "achievement", "Result"],
    }
  };

  VerifiableCredential(this.strVC);

  // proofない時にエラー
  String getSignature() {
    return proof!["proofValue"];
  }

  String getVerificationMethod() {
    // return proof!["verificationMethod"];
    return "test";
  }

  List<String> getMessagesWithMeta() {
    return distributeFields(strVC, requiredFieldsMap);
  }

  // VC -> messages(divided into minimum unit)
  List<String> getMessages() {
    List<String> messages = messagesWithMeta;

    List<String> ret = [];
    for (var i = 0; i < messages.length; i++) {
      Map messageMap = json.decode(messages[i]);
      Map newMessageMap = {};
      for (String key in messageMap.keys) {
        if (key.startsWith("ch:") ||
            key.startsWith("bro:") ||
            key.startsWith("list:")) {
          continue;
        }
        newMessageMap[key] = messageMap[key];
      }
      ret.add(json.encode(newMessageMap));
    }
    return ret;
  }

  List<String> getSelectiveFields() {
    List<String> selectiveFields = [];
    for (String message in messages) {
      if (json.decode(message)["required"] == false) {
        selectiveFields.add(message);
      }
    }
    return selectiveFields;
  }

  // revealedの橋渡し
  List<int> getRevealedIndices(revealed) {
    return revealed;
  }
}
