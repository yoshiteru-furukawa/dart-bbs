import 'package:dart_bbs/dart_bbs.dart';
import 'package:dart_bbs/src/create_proof_value.dart';
import 'package:nonce/nonce.dart';

// https://github.com/mattrglobal/bbs-signatures/blob/master/tests/bbsSignature/createProof.bbsSignature.spec.ts
// L309~
// "should create proof revealing multiple messages from multi-message signature"

void main() async {
  const signature =
      "jU9tKKvDDqoSUTMPDGfw/1GlnOnRD56wEM2iftL7NPBlT3JxP2YY5SnR32nra0bmR//r8JH7fvgYuqpXHJB+vsYj7xoeyQtvoPZArti0YiYML2utQmsV4zN1W0sWH7+myPL/7H/m6PgxL/CjYzAaRg==";

  const bbsPublicKey =
      "qJgttTOthlZHltz+c0PE07hx3worb/cy7QY5iwRegQ9BfwvGahdqCO9Q9xuOnF5nD/Tq6t8zm9z26EAFCiaEJnL5b50D1cHDgNxBUPEEae+4bUb3JRsHaxBdZWDOo3pb";

  const messages = ["uiSKIfNoO2rMrA==", "lMoHHrFx0LxwAw==", "wdwqLVm9chMMnA=="];

  List<int> revealed = [0, 2];

  String nonce = Nonce.generate(64);

  String proofValue = await createProofValue(
      signature, bbsPublicKey, messages, revealed, nonce);
  print(proofValue);
}
