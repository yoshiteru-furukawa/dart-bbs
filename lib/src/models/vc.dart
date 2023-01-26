import 'dart:convert';

class VerifiableCredential {
  String strVC;
  late Map mapVC = json.decode(strVC);
  late List<String> messages = getMessages();
  late Map? proof = mapVC["proof"];

  VerifiableCredential(this.strVC);

  // proofない時にエラー
  String getSignature() {
    return proof!["proofValue"];
  }

  String getNonce() {
    return proof!["nonce"];
  }

  String getVerificationMethod() {
    return proof!["verificationMethod"];
  }

  List<String> getHolderMessages() {
    List<String> ret = [];
    Map holderInfo = mapVC["holder"];
    Map requiredInfo = {"id": holderInfo["id"], "type": holderInfo["type"]};
    for (String key in holderInfo.keys) {
      if (requiredInfo.keys.contains(key)) {
        continue;
      }
      ret.add(json.encode({}
        ..addAll(requiredInfo)
        ..addAll({
          key: holderInfo[key],
          "required": false,
          "parentName": "holder"
        })));
    }

    if (ret.isEmpty) {
      ret.add(json.encode({}
        ..addAll(requiredInfo)
        ..addAll({"required": true, "parentName": "holder"})));
    }
    return ret;
  }

  List<String> getCredentialSubjectMessgaes() {
    List<String> ret = [];

    if (mapVC["credentialSubject"].runtimeType != List) {
      ret.add(json.encode({}
        ..addAll(mapVC["credentialSubject"])
        ..addAll({"required": false, "parentName": "credentialSubject"})));
      return ret;
    }

    for (Map credentialSubject in mapVC["credentialSubject"]) {
      ret.add(json.encode({}
        ..addAll(credentialSubject)
        ..addAll({"required": false, "parentName": "credentialSubject"})));
    }
    return ret;
  }

  List<String> getMessages() {
    List<String> ret = [];

    /* requiredField */
    Map requiredFields = {};
    for (String key in mapVC.keys) {
      if (["holder", "proof", "credentialSubject"].contains(key)) {
        continue;
      }
      requiredFields[key] = mapVC[key];
    }
    ret.add(json.encode({}
      ..addAll(requiredFields)
      ..addAll({"required": true, "parentName": "root"})));

    /* holder */
    ret.addAll(getHolderMessages());

    /* credentialSubject */
    ret.addAll(getCredentialSubjectMessgaes());

    return ret;
  }

  List<String> getSelectiveFields() {
    List<String> selectiveFields = [];
    for (var i = 0; i < messages.length; i++) {
      if (json.decode(messages[i])["required"] == false) {
        selectiveFields.add(json.encode({}
          ..addAll(json.decode(messages[i]))
          ..addAll({"revealedIndex": i})));
      }
    }
    return selectiveFields;
  }

  // revealedの橋渡し
  List<int> getRevealedIndices(List<int> revealedIndices) {
    List<int> ret = [];
    for (var i = 0; i < messages.length; i++) {
      if (json.decode(messages[i])["required"] || revealedIndices.contains(i)) {
        ret.add(i);
      }
    }
    return ret;
  }

  Map createVPWithSelectiveDisclosure(List<int> revealed) {
    Map removedMetaMap(String m) {
      Map ret = json.decode(m);
      ret.remove("required");
      ret.remove("parentName");
      return ret;
    }

    /*  */
    Map VP = removedMetaMap(messages[0]);
    VP["holder"] = {};
    VP["credentialSubject"] = [];
    for (var index in revealed) {
      /* root message == required */
      if (index == 0) continue;

      if (json.decode(messages[index])["parentName"] == "holder") {
        VP["holder"].addAll(removedMetaMap(messages[index]));
      }

      if (json.decode(messages[index])["parentName"] == "credentialSubject") {
        VP["credentialSubject"].add(removedMetaMap(messages[index]));
      }
    }
    return VP;
  }
}
