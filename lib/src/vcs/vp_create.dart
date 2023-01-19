import 'dart:convert';
import 'package:dart_bbs/src/bls_signature/bls_create_proof.dart';
import 'package:dart_bbs/src/models/vc.dart';
import 'package:dart_bbs/src/models/vp.dart';
import 'package:dart_bbs/src/rsa_signature/rsa_sign.dart';
import 'package:dart_bbs/src/utils/get_date.dart';
import 'package:dart_bbs/src/vcs/vp_selective_disclosed.dart';

import 'package:nonce/nonce.dart';

// input  : VC        String
//          revealed  List<???>
//
// output : proof value

Future<String> vpCreate(
    signedVC, revealedIndices, publicKey, holderPrivateKey) async {
  var selectiveDislosedVC =
      await vpSelectiveDisclosed(signedVC, revealedIndices, publicKey);

  var VP = VerifiablePresentation(selectiveDislosedVC);
  return VP.export(holderPrivateKey);
}
