import 'dart:convert';

import 'package:dart_bbs/src/bls_signature/bls_verify_proof.dart';
import 'package:dart_bbs/src/models/vp.dart';
import 'package:dart_bbs/src/rsa_signature/rsa_verify.dart';
import 'package:http/http.dart' as http;

// input  : VP String
//        : publicKey String
//
// output : result Bool

Future<bool> vpVerify(VP, publicKey, holderPublicKey) async {
  var VP_ = VerifiablePresentation(VP);

  // should be obtained from VDR
  // var publicKey = "vovnemt";

  bool resultProof = await blsVerifyProof(
      VP_.getProofValue(), publicKey, VP_.messages, VP_.getNonce());

  Map signedData = VP_.mapVC;
  signedData.remove("proof");

  bool resultSignature =
      rsaVerify(holderPublicKey, json.encode(signedData), VP_.getSignature());
  print("resultProof");
  print(resultProof);
  print("resultSignature");
  print(resultSignature);
  return resultProof && resultSignature;
}
