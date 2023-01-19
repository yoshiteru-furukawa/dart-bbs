import 'package:dart_bbs/src/models/vc.dart';

class VerifiablePresentation extends VerifiableCredential {
  VerifiablePresentation(strVP) : super(strVP);

  String getProofValue() {
    return proof![1]["proofValue"];
  }

  String getNonce() {
    return proof![1]["nonce"];
  }
}
