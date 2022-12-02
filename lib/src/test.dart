import 'package:dart_bbs/src/create_vp.dart';

void main() async {
  var VC = {
    "@context": [
      "http://schema.org/",
      "https://w3id.org/security/v2",
      "https://w3id.org/security/bbs/v1"
    ],
    "@type": "Person",
    "firstName": "Jane",
    "lastName": "Does",
    "jobTitle": "Professor",
    "telephone": "(425) 123-4567",
    "email": "jane.doe@example.com",
    "proof": {
      "type": "BbsBlsSignature2020",
      "created": "2020-04-25",
      "verificationMethod": "did:example:489398593#test",
      "proofPurpose": "assertionMethod",
      "proofValue":
          "F9uMuJzNBqj4j+HPTvWjUN/MNoe6KRH0818WkvDn2Sf7kg1P17YpNyzSB+CH57AWDFunU13tL8oTBDpBhODckelTxHIaEfG0rNmqmjK6DOs0/ObksTZh7W3OTbqfD2h4C/wqqMQHSWdXXnojwyFDEg==",
      "requiredRevealStatements": [4, 5]
    }
  };
  String signature =
      "kTTbA3pmDa6Qia/JkOnIXDLmoBz3vsi7L5t3DWySI/VLmBqleJ/Tbus5RoyiDERDBEh5rnACXlnOqJ/U8yFQFtcp/mBCc2FtKNPHae9jKIv1dm9K9QK1F3GI1AwyGoUfjLWrkGDObO1ouNAhpEd0+et+qiOf2j8p3MTTtRRx4Hgjcl0jXCq7C7R5/nLpgimHAAAAdAx4ouhMk7v9dXijCIMaG0deicn6fLoq3GcNHuH5X1j22LU/hDu7vvPnk/6JLkZ1xQAAAAIPd1tu598L/K3NSy0zOy6obaojEnaqc1R5Ih/6ZZgfEln2a6tuUp4wePExI1DGHqwj3j2lKg31a/6bSs7SMecHBQdgIYHnBmCYGNQnu/LZ9TFV56tBXY6YOWZgFzgLDrApnrFpixEACM9rwrJ5ORtxAAAAAgE4gUIIC9aHyJNa5TBklMOh6lvQkMVLXa/vEl+3NCLXblxjgpM7UEMqBkE9/QcoD3Tgmy+z0hN+4eky1RnJsEg=";

  String publicKey =
      "oqpWYKaZD9M1Kbe94BVXpr8WTdFBNZyKv48cziTiQUeuhm7sBhCABMyYG4kcMrseC68YTFFgyhiNeBKjzdKk9MiRWuLv5H4FFujQsQK2KTAtzU8qTBiZqBHMmnLF4PL7Ytu";
  String vp = await createVP(signature, publicKey, VC);
  print(vp);
}
