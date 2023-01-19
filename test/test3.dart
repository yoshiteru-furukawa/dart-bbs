import 'package:dart_bbs/src/rsa_signature/gen_rsa_key_pair.dart';
import 'package:dart_bbs/src/rsa_signature/rsa_sign.dart';
import 'package:dart_bbs/src/rsa_signature/rsa_verify.dart';

void main() {
  String test = "nfibevwiohrvwnv";
  var sig = rsaSign(rsaPrivateKey, test);
  print(sig);
  var result = rsaVerify(rsaPublicKey, test, sig);
  print(result);
}
