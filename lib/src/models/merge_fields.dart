import 'dart:convert';

Map mergeField(Map message0, List<String> messages, List<int> revealed) {
  Map ret = {};
  for (String key in message0.keys) {
    if (key.startsWith("bro:")) {
      for (var index in message0[key]) {
        if (!(revealed.contains(index))) {
          continue;
        }
        ret.addAll(
            mergeField(json.decode(messages[index]), messages, revealed));
      }
      continue;
    }

    if (key.startsWith("ch:")) {
      for (var index in message0[key]) {
        if (!(revealed.contains(index))) {
          continue;
        }
        ret[key.substring(3)] =
            mergeField(json.decode(messages[index]), messages, revealed);
      }
      continue;
    }

    if (key.startsWith("list:")) {
      for (var index in message0[key]) {
        if (!(revealed.contains(index))) {
          continue;
        }
        if (ret.keys.contains(key.substring(5))) {
          ret[key.substring(5)].add(
              mergeField(json.decode(messages[index]), messages, revealed));
        } else {
          ret[key.substring(5)] = [
            mergeField(json.decode(messages[index]), messages, revealed)
          ];
        }
      }
      continue;
    }

    if (key != "required") {
      ret[key] = message0[key];
    }
  }
  return ret;
}

String mergeFields(List<String> messages, List<int> revealed) {
  return json.encode(mergeField(json.decode(messages[0]), messages, revealed));
}
