import 'package:dart_bbs/src/models/jws.dart';
import 'package:dart_bbs/src/jws_create/get_proof_value.dart';

// input  : JWS Payload
//
// output : result JWS Compact Serialization

Future<String> jwsCreate(
  String payload,
  String secretKey,
  String publicKey,
) async {
  JsonWebSignature jws; {
    var proofValue = await getProofValue(publicKey, secretKey, payload);
    jws = JsonWebSignature.fromContents(
      payloadString: payload, signature: proofValue,
    );
  }
  return jws.toCompactSerialization();
}
