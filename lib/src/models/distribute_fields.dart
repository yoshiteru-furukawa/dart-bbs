import 'dart:convert';

List<String> distributeFields(body, requiredFieldsMap, {baseIndex = 1}) {
  Map requiredMessage = {"required": true};
  List<String> nonRequiredMessages = [];

  for (String field in json.decode(body).keys) {
    if (field == "proof") {
      continue;
    }

    if (requiredFieldsMap["root"].contains(field)) {
      requiredMessage[field] = json.decode(body)[field];
      continue;
    }

    if (json.decode(body)[field].runtimeType.toString() ==
        "_InternalLinkedHashMap<String, dynamic>") {
      List<String> childMessages = distributeFields(
          json.encode(json.decode(body)[field]), requiredFieldsMap[field],
          baseIndex: nonRequiredMessages.length + baseIndex + 1);

      requiredMessage["ch:$field"] = [nonRequiredMessages.length + baseIndex];
      nonRequiredMessages.addAll(childMessages);
      continue;
    }

    if (json.decode(body)[field].runtimeType == List) {
      if (json.decode(body)[field][0].runtimeType.toString() ==
          "_InternalLinkedHashMap<String, dynamic>") {
        requiredMessage["list:$field"] = [];
        for (var child in json.decode(body)[field]) {
          List<String> childMessages = distributeFields(
              json.encode(child), requiredFieldsMap[field],
              baseIndex: nonRequiredMessages.length + baseIndex + 1);
          requiredMessage["list:$field"]
              .add(nonRequiredMessages.length + baseIndex);
          nonRequiredMessages.addAll(childMessages);
        }
        continue;
      }
    }

    requiredMessage["bro:$field"] = [nonRequiredMessages.length + baseIndex];
    nonRequiredMessages
        .add(json.encode({"required": false, field: json.decode(body)[field]}));
  }

  return [json.encode(requiredMessage)] + nonRequiredMessages;
}
