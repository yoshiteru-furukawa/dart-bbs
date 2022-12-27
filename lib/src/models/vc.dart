import 'dart:convert';

class VerifiableCredential {
  String rawVC;

  VerifiableCredential(this.rawVC);

  // proofない時にエラー
  String getSignature() {
    return json.decode(rawVC)["proof"]["proofValue"];
  }

  String getVerificationMethod() {
    return json.decode(rawVC)["proof"]["verificationMethod"];
  }

  // VC -> messages(divided into minimum unit)
  List<String> getMessages() {
    return [rawVC];
  }

  List<String> getSelectiveAttributes() {
    return getMessages();
  }

  // revealedの橋渡し
  List<int> getRevealedIndices(revealed) {
    return revealed;
  }
}
