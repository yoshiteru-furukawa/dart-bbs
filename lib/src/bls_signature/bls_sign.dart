import 'dart:convert';

import 'package:http/http.dart' as http;

/* Interface
 input  : publickey String
        : secretkey String
        : messages String[]

 output : proofValue(Signature) String 
*/

Future<String> blsSign(pk, sk, messages) async {
  var url = Uri.parse(
    'http://35.86.230.210:3000/bls_sign', //HTTP request
  );
  var response = await http.post(url,
      body: json.encode({
        "pk": pk,
        "sk": sk,
        "messages": messages,
      }),
      headers: {"Content-Type": "application/json"});

  return json.decode(response.body)["proof"];
}
