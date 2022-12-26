import 'dart:convert';
import 'package:dart_bbs/src/create_bbs_proof.dart';
import 'package:dart_bbs/src/create_proof_value.dart';
import 'package:dart_bbs/src/create_vp.dart';
import 'package:nonce/nonce.dart';

void main() async {
  /*　To add the fuction of selective disclosure, it is required to map each element to be selected to each message.
  -> In the example case below, message 2 〜 message n are located in "claim" in a VC, and selected depending on a holder's choice. 
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
  ];

  /* Set signature and publicKey 
   ->"signature" is obtained from the proofValue of the targeted VC 
   ->"publicKey" is assumed to be obtained from the Verifiable Data Registry 
   ->"revealed" indicates the order index of the messages to be revealed*/
  String signature = "hcRz0EFezSoMLYDNncuOtpnIVpoXhDz6q/eyTHxr5Rc6OqXT46EnEF/6nQM6GdlMLQNOTh6KIPu4inSRuvdPbLMY05ArYPqtaTSAYiX9flskAwV7N1t2MoRzTz9cHPX5EtcySPlOeatb0/FADPBF3A==";
  String publicKey = "plAUct6Jg1DYHw3Q8H91LICj6X0heemlzy6glNGwTejIaXq3B5SGUOkWZ8bYTFgJBAhUbf9s56erXYX3IFjAKsJh8gl1zdEIVMpERPLEMEWwBUS5MoCE/oAKn/rSH5zQ";
  List<int> revealed = [0, 1, 2, 4]; //The number indicates the order index of the messages to be revealed
  String nonce = Nonce.generate(64);

  /* Obtain the proofValue */
  String proofValue = await createProofValue(signature, publicKey, messages, revealed, nonce);
  print(proofValue);

  /* Format the proof */
  String veriMethod = "did:issuer:0001"; //verificationMethod is retrieved from the proof in the targeted VC
  Map proof = createBbsProof(nonce, proofValue, veriMethod);
  print(proof);

  /* Format the VP */
  String VP = createVP(messages, revealed, proof);
  print(VP);
}
