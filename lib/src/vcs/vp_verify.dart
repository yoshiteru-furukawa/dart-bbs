import 'dart:convert';

import 'package:dart_bbs/src/bls_signature/bls_verify_proof.dart';
import 'package:dart_bbs/src/models/vc.dart';
import 'package:dart_bbs/src/models/vp.dart';
import 'package:dart_bbs/src/rsa_signature/rsa_verify.dart';
import 'package:dart_bbs/src/vdr/retrieve_key_value.dart';
import 'package:http/http.dart' as http;

// input  : VP String
//        : publicKey String
//
// output : result Bool

Future<bool> vpVerify(VP, holderPublicKey) async {
  Map signedData = json.decode(VP);
  String signature = signedData["proof"]["proofValue"];
  signedData.remove("proof");

  /* rsa signature */
  bool resultSignature =
      rsaVerify(holderPublicKey, json.encode(signedData), signature);

  bool resultProof = true;
  for (var VC in signedData["verifiableCredential"]) {
    var VC_ = VerifiableCredential(json.encode(VC));
    String issuerPublicKey =
        await retrieveKeyValue(VC_.getVerificationMethod());
    bool result = await blsVerifyProof(
        VC_.getSignature(), issuerPublicKey, VC_.messages, VC_.getNonce());
    resultProof = resultProof && result;
  }

  print("resultProof");
  print(resultProof);
  print("resultSignature");
  print(resultSignature);
  return resultProof && resultSignature;
}
