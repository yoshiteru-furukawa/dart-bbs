import 'dart:convert';
import 'package:dart_bbs/src/models/distribute_fields.dart';
import 'package:dart_bbs/src/models/merge_fields.dart';

void main() async {
  String VC = json.encode({
    "a": 1,
    "b": [1, 2, 3],
    "c": [
      {"d": 1, "e": 1},
      {
        "d": 1,
        "e": 1,
        "f": {"g": 3, "h": 4}
      }
    ]
  });
  Map requiredFieldsMap = {
    "root": ["a"],
    "c": {
      "root": ["d"],
      "f": {
        "root": ["h"]
      }
    }
  };

  List<String> messageWithMeta = distributeFields(VC, requiredFieldsMap);
  for (var i = 0; i < messageWithMeta.length; i++) {
    print(i);
    print(messageWithMeta[i]);
    print("\n\n");
  }

  String VC2 = mergeFields(messageWithMeta, [0, 1, 2, 3, 4, 5, 6, 7]);
  print(VC);
  print(VC2);
}
