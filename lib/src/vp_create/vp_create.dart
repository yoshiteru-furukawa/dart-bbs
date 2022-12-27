import 'dart:convert';
import 'package:dart_bbs/src/vp_create/get_proof_value.dart';
import 'package:dart_bbs/src/models/vc.dart';
import 'package:dart_bbs/src/utils/get_date.dart';

import 'package:nonce/nonce.dart';

// input  : VC        String
//          revealed  List<???>
//
// output : proof value

Future<String> vpCreate(signedVC, revealed) async {
  VerifiableCredential VC_ = VerifiableCredential(signedVC);

  /* getProofValue */
  String signature = VC_.getSignature();

  // should be obtained from VDR
  String publicKey = "feghtwjyet";

  List<String> messages = VC_.getMessages();

  // convert from List<String> to List<Int>
  List<int> revealedIndices = [0, 1];

  String nonce = Nonce.generate(64);

  String proofValue = await getProofValue(
      signature, publicKey, messages, revealedIndices, nonce);

  /* createProof */
  var proof = {
    "type": "BbsBlsSignatureProof2020",
    "created": getDate(),
    "verificationMethod": VC_.getVerificationMethod(),
    "proofPurpose": "assertionMethod",
    "proofValue": proofValue,
    "nonce": nonce
  };

  /* composeVP */
  // selectively disclosed
  Map VP = {...json.decode(messages[0]), ...json.decode(messages[1])};
  for (var i = 2; i < messages.length; i++) {
    if (revealed.contains(i)) {
      var message = json.decode(messages[i]);
      VP[message["type"]] = message["subject"];
    }
  }
  VP["proof"] = proof;
  return json.encode(VP);
}
