<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

## Getting started
in pubspec.yaml...

after cloning this repository

```
dependencies:
  dart_bbs:
    path: ../dart_bbs # path for this repository
```
## Usage(simple BLS signature and verification)
```dart
import 'dart:convert';
import 'package:dart_bbs/dart_bbs.dart';

String message = json.encode({
  "field A": [
    "test",
    "test"
  ],
  "field B": "test",
  "field C": ["test"],
  "field D": "test",
  "field E": "test"
});


/* keyPair */
var keyPair = await genBlsKeyPair();
String publicKey = keyPair["publicKey"];
String secretKey = keyPair["secretKey"];

/* blsSign
 input  : publickey String
        : secretkey String
        : messages String[]

 output : proofValue(Signature) String 
*/
String signature = await blsSign(publicKey, secretKey, [message]);

/* blsVerify
 input  : publickey String
        : messages String[]
        : signature(proofValue) String

 output : verifiedResult Bool 
*/
bool result = await blsVerify(publicKey, [message], signature);

```
## Usage(VCS)

```dart
import 'dart:convert';
import 'package:dart_bbs/dart_bbs.dart';

void main() async {
  String VC = json.encode({
    "context": [
      "https://www.w3.org/2018/credentials/v1",
      "https://www.w3.org/2018/credentials/examples/v1"
    ],
    "id": "http://localhost:9000/vc/1",
    "type": ["VerifiableCredential"],
    "issuer": "did:issuer:0001",
    "issuanceDate": "2022-10-09T10:15:55.382Z" // overridden
  });

   /* Issuer's keyPair 
  keyPair(publicKey) should be obtained from VDR */
  var keyPair = await genBlsKeyPair();
  String publicKey = keyPair["publicKey"];
  String secretKey = keyPair["secretKey"];


  /* signed VC 
    For selective disclosure */
  String signedVC = await vcCreate(VC, secretKey, //publicKey);
  print(signedVC); // String signedVC

  /* get Options 
   user selects property from options in PLR app */
  List<String> options = getOptions(signedVC);
  print(options); // List<String> selective messages

  /* create VP */
  List<int> revealed = [0, 1, 2, 4];
  String VP = await vpCreate(signedVC, revealed, publicKey, holderPrivateKey);
  print(VP); // String VP

  /* verify VP */
  String result = await vpVerify(VP, publicKey, holderPublicKey);
  print(result); // bool result
}
```
