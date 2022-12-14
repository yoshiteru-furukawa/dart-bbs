import 'dart:convert';

import 'package:dart_bbs/src/models/vp.dart';
import 'package:http/http.dart' as http;

// input  : VP String
//
// output : result Bool

Future<bool> vpVerify(VP, publicKey) async {
  var url = Uri.parse(
    'http://35.86.230.210:9000/verify_vp', //HTTP request
  );
  var VP_ = VerifiablePresentation(VP);

  // should be obtained from VDR
  // var publicKey = "vovnemt";

  var response = await http.post(url,
      body: json.encode({
        "proof": VP_.getSignature(),
        "publicKey": publicKey,
        "messages": VP_.messages,
        "nonce": VP_.getNonce()
      }),
      headers: {"Content-Type": "application/json"});

  return json.decode(json.decode(response.body)["isProofVerified"])["verified"];
}
