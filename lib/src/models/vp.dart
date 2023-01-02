import 'package:dart_bbs/src/models/vc.dart';

class VerifiablePresentation extends VerifiableCredential {
  VerifiablePresentation(String strVP) : super(strVP);

  String getNonce() {
    return proof!["nonce"];
  }
}
