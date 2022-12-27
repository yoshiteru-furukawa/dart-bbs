import 'dart:convert';

import 'package:dart_bbs/src/models/vc.dart';

class VerifiablePresentation extends VerifiableCredential {
  VerifiablePresentation(String _rawVP) : super(_rawVP);

  String getNonce() {
    return json.decode(rawVC)["proof"]["nonce"];
  }
}
