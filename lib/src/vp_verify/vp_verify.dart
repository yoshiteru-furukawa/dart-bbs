import 'dart:convert';

import 'package:dart_bbs/src/models/vp.dart';
import 'package:http/http.dart' as http;

// input  : VP String
//
// output : result Bool

Future<String> vpVerify(VP) async {
  var url = Uri.parse(
    'http://localhost:3000/verify_vp', //HTTP request
  );
  var VP_ = VerifiablePresentation(VP);

  // should be obtained from VDR
  var publicKey = "vovnemt";

  var response = await http.post(url,
      body: json.encode({
        "proof": VP_.getSignature(),
        "publicKey": publicKey,
        "messages": VP_.getMessages(),
        "nonce": VP_.getNonce()
      }),
      headers: {"Content-Type": "application/json"});

  return json.decode(response.body)["isProofVerified"];
}
