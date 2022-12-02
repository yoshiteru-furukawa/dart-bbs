import 'package:dart_bbs/src/create_proof_value.dart';

// input  : signature
//        : publickey
//        : VC(disclosed message)
//
// output : proof

Future<Map> createBbsProof(signature, publicKey, VC) async {
  var proofValue = await createProofValue(signature, publicKey, VC);
  var proof = {
    "type": "BbsBlsSignatureProof2020",
    //update
    "created": "2020-04-25",
    //update
    "verificationMethod": "did:example:489398593#test",
    "proofPurpose": "assertionMethod",
    "proofValue": proofValue,
    //update
    "nonce":
        "6i3dTz5yFfWJ8zgsamuyZa4yAHPm75tUOOXddR6krCvCYk77sbCOuEVcdBCDd/l6tIY="
  };
  return proof;
}
