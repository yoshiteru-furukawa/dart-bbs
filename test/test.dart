import 'dart:convert';
import 'package:dart_bbs/dart_bbs.dart';
import 'package:dart_bbs/src/models/vc.dart';
import 'package:dart_bbs/src/utils/get_key_pair.dart';
import 'package:dart_bbs/src/utils/pprint.dart';
import 'package:dart_bbs/src/vc_create/get_proof_value.dart';
import 'package:dart_bbs/src/vp_verify/bls_verify.dart';

void main() async {
  String VC = json.encode({
    "@context": [
      "https://www.w3.org/2018/credentials/v1",
      "https://purl.imsglobal.org/spec/ob/v3p0/context.json",
      "https://www.u-tokyo.ac.jp/oid/context.json"
    ],
    "id": "http://credentials.u-tokyo.ac.jp/degree/phd/science/12345",
    "type": ["VerifiableCredential", "OpenBadgeCredential"],
    "issuer": {
      "id": "did:xxx:issuersid1234567890",
      "type": "Profile",
      "name": "The University of Tokyo"
    },
    "issuanceDate": "2010-01-01T00:00:00Z",
    "name": "PhD Degree Certificate",
    "holer": {
      "id": "did:xxx:holderid1234567890",
      "type": "Profile",
      "name": "SATO, Hiroyuki",
      "birthday": "0000-00-00",
      "sex": "male"
    },
    "creentialSubject": {
      "id": "http://credentials.u-tokyo.ac.jp/degree/phd/science/12345",
      "type": "AchievementSubject",
      "identifier": {
        "type": "IdentityObject",
        "identityType": "Profile",
        "hashed": "false",
        "identityHash": "SATO Hiroyuki"
      },
      "achievement": {
        "id": "http://credentials.u-tokyo.ac.jp/degree/phd/science/12345",
        "type": "DoctoralDegree",
        "criteria": "abc",
        "description": "abc",
        "name": "Doctor of Philosophy in Computer Science"
      }
    },
  });

  /* Issuer's keyPair 
  keyPair(publicKey) should be obtained from VDR */
  var keyPair = await getKeyPair();
  String publicKey = keyPair["publicKey"];
  String secretKey = keyPair["secretKey"];

  var test = await getProofValue(publicKey, secretKey, [VC]);
  print(test);

  var result = await blsVerify(test, publicKey, [VC]);
  print(result);

  print("----------------------------------------");
  print("1. keyPair should be obtained from VDR");
  print("publicKey");
  print(publicKey);
  print("");
  print("secretKey");
  print(secretKey);
  print("\n\n");

  VerifiableCredential VC_ = VerifiableCredential(VC);
  //print(VC_.getMessages());
  print("----------------------------------------");
  print("2. VC will be divided into some parts");
  for (var i = 0; i < VC_.messages.length; i++) {
    print(i);
    pprint(json.decode(VC_.messages[i]));
    print("\n\n");
  }

  /* signed VC */
  String signedVC = await vcCreate(VC, secretKey, publicKey);
  print("----------------------------------------");
  print("3. VC will be signed by Issuer (VC create)");
  pprint(json.decode(signedVC));
  print("\n\n");

  /* get Options 
   user selects property from options in PLR app */
  List<String> options = getOptions(signedVC);
  print("----------------------------------------");
  print("4. PLR can get selective fields.");
  print(options);
  print("\n\n");

  /* create VP */
  List<int> revealed = [0, 1, 4, 5];
  String VP = await vpCreate(signedVC, revealed, publicKey);
  print("----------------------------------------");
  print("5. VP will be created with selective disclosure by Holder");
  pprint(json.decode(VP));
  print("\n\n");

  /* verify VP */
  bool result1 = await vpVerify(VP, publicKey);
  print("----------------------------------------");
  print("6. VP will be verified by Verifier");
  print(result1);
}
