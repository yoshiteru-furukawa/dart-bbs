import 'dart:convert';
import 'package:dart_bbs/src/create_bbs_proof.dart';
import 'package:dart_bbs/src/create_proof_value.dart';
import 'package:dart_bbs/src/create_vp.dart';
import 'package:nonce/nonce.dart';

void main() async {
  /*　発行するVCの各要素を各messageに対応づける
  ->claimに対応するmessage 2〜 message nは、想定するVCのスキーマによって設定する必要があります
  */
  String message0 = json.encode({
    "context": [
      "https://www.w3.org/2018/credentials/v1",
      "https://www.w3.org/2018/credentials/examples/v1"
    ],
    "id": "http://localhost:9000/vc/1",
    "type": ["VerifiableCredential"],
    "issuer": "did:issuer:0001",
    "issuanceDate": "2022-10-09T10:15:55.382Z"
  });

  String message1 = json.encode({"id": "did:holder:0001"});

  String message2 = json.encode({"type": "Name", "subject": "Michael Ding"});

  String message3 =
      json.encode({"type": "BirthDate", "subject": "January 1st, 1991"});

  String message4 =
      json.encode({"type": "Institute", "subject": "The University of Tokyo"});

  List<String> messages = [
    message0,
    message1,
    message2,
    message3,
    message4
  ]; //message0, message1は常に開示。message2以降をholderが選択可能

  String signature =
      "kTTbA3pmDa6Qia/JkOnIXDLmoBz3vsi7L5t3DWySI/VLmBqleJ/Tbus5RoyiDERDBEh5rnACXlnOqJ/U8yFQFtcp/mBCc2FtKNPHae9jKIv1dm9K9QK1F3GI1AwyGoUfjLWrkGDObO1ouNAhpEd0+et+qiOf2j8p3MTTtRRx4Hgjcl0jXCq7C7R5/nLpgimHAAAAdAx4ouhMk7v9dXijCIMaG0deicn6fLoq3GcNHuH5X1j22LU/hDu7vvPnk/6JLkZ1xQAAAAIPd1tu598L/K3NSy0zOy6obaojEnaqc1R5Ih/6ZZgfEln2a6tuUp4wePExI1DGHqwj3j2lKg31a/6bSs7SMecHBQdgIYHnBmCYGNQnu/LZ9TFV56tBXY6YOWZgFzgLDrApnrFpixEACM9rwrJ5ORtxAAAAAgE4gUIIC9aHyJNa5TBklMOh6lvQkMVLXa/vEl+3NCLXblxjgpM7UEMqBkE9/QcoD3Tgmy+z0hN+4eky1RnJsEg=";
  String publicKey =
      "oqpWYKaZD9M1Kbe94BVXpr8WTdFBNZyKv48cziTiQUeuhm7sBhCABMyYG4kcMrseC68YTFFgyhiNeBKjzdKk9MiRWuLv5H4FFujQsQK2KTAtzU8qTBiZqBHMmnLF4PL7Ytu";
  List<int> revealed = [0, 1, 2, 4];
  String nonce = Nonce.generate(64);

  // please check values of signature and publicKey
  // they should be converted base64

  // String proofValue =
  //    await createProofValue(signature, publicKey, messages, revealed, nonce);

  String proofValue = "testValue";
  print(proofValue);

  Map proof = createBbsProof(nonce, proofValue);
  print(proof);

  String VP = createVP(messages, revealed, proof);
  print(VP);
}
