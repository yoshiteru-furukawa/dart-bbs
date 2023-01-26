import 'dart:convert';

import 'package:dart_bbs/src/models/vp.dart';

import 'package:dart_bbs/src/vcs/vp_selective_disclosed.dart';

// input  : VC        String
//          revealed  List<int>
//
// output : proof value

Future<String> vpCreate(signedVC, revealedIndices, holderPrivateKey) async {
  var selectiveDislosedVC =
      await vpSelectiveDisclosed(signedVC, revealedIndices);

  var VP = VerifiablePresentation(selectiveDislosedVC);
  return VP.export(holderPrivateKey);
}
