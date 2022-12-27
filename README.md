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

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
import 'dart:convert';

import 'package:dart_bbs/dart_bbs.dart';
import 'package:nonce/nonce.dart';

void main() async {
  String VC = json.encode({
    "context": [
      "https://www.w3.org/2018/credentials/v1",
      "https://www.w3.org/2018/credentials/examples/v1"
    ],
    "id": "http://localhost:9000/vc/1",
    "type": ["VerifiableCredential"],
    "issuer": "did:issuer:0001",
    "issuanceDate": "2022-10-09T10:15:55.382Z" // overrided
  });

  /* signed VC */
  String signedVC = await vcCreate(VC);
  print(signedVC);

  /* get Options 
   user selects property from options in PLR app */
  List<String> options = getOptions(signedVC);
  print(options);

  /* create VP */
  List<int> revealed = [0, 1, 2, 4];
  String VP = await vpCreate(signedVC, revealed);
  print(VP);

  /* verify VP */
  String result = await vpVerify(VP);
  print(result);
}
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
