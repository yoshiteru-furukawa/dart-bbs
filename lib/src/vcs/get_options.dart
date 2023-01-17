import 'package:dart_bbs/src/models/vc.dart';

List<String> getOptions(signedVC) {
  VerifiableCredential signedVC_ = VerifiableCredential(signedVC);
  return signedVC_.getSelectiveFields();
}
