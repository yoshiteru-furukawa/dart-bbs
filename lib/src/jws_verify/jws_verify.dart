import 'dart:convert';

import 'package:dart_bbs/src/models/jws.dart';
import 'package:http/http.dart' as http;

const _jwsHeaderTypeKey = "typ";
const _jwsTypeJWT = "JWT";

const _jwtExpirationTimeKey = "exp";
const _jwtNotBeforeKey = "nbf";

final blsVerifyUri = Uri.parse("http://35.86.230.210:8000/bls_verify");

// input  : JWS Compact Serialization String
//          publicKey String
//
// output : result Bool

Future<bool> jwsVerify(String compactSerialization, String publicKey) async {
  var jws = JsonWebSignature.fromCompactSerialization(compactSerialization);
  if (!_checkJWTValidity(jws)) return false;

  var response = await http.post(
    blsVerifyUri,
    body: json.encode({
        "signature": jws.signature,
        "publicKey": publicKey,
        "messages": [ jws.payloadDecoded ],
    }),
    headers: {"Content-Type": "application/json"},
  );
  return json.decode(response.body)["is_verified"]["verified"];
}

bool _checkJWTValidity(JsonWebSignature jws) {
  var jwt = _mayExtractJWT(jws);
  if (jwt == null) return true;

  var now = DateTime.now();

  var dt = _getJWTDateTime(jwt, _jwtExpirationTimeKey);
  if ((dt != null) && now.isAfter(dt)) return false;

  dt = _getJWTDateTime(jwt, _jwtNotBeforeKey);
  if ((dt != null) && now.isBefore(dt)) return false;

  return true;
}

DateTime? _getJWTDateTime(Map<String, dynamic> jwt, String key) {
  var v = jwt[key];
  if (v is! num) return null;

  return DateTime.fromMillisecondsSinceEpoch(v.round() * 1000);
}

Map<String, dynamic>? _mayExtractJWT(JsonWebSignature jws) {
  var type = jws.protectedHeaderJson[_jwsHeaderTypeKey];
  if ((type != null) && (type != _jwsTypeJWT)) return null;

  return jws.payloadJson;
}

