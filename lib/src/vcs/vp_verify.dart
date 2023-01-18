import 'dart:convert';

import 'package:dart_bbs/src/bls_signature/bls_verify_proof.dart';
import 'package:dart_bbs/src/models/vp.dart';
import 'package:http/http.dart' as http;

// input  : VP String
//        : publicKey String
//
// output : result Bool

Future<bool> vpVerify(VP, publicKey) async {
  var VP_ = VerifiablePresentation(VP);

  // should be obtained from VDR
  // var publicKey = "vovnemt";

  return await blsVerifyProof(
      VP_.getSignature(), publicKey, VP_.messages, VP_.getNonce());
}
