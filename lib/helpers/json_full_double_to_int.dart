/// Converts all double values that end with .0 to int in the json object, but without modifying strings that contain '.0'
dynamic jsonFullDoubleToInt(dynamic jsonValue) {
  // Primitive type or null
  if (jsonValue == null || (jsonValue is! Map && jsonValue is! List)) {
    if (jsonValue is double && jsonValue.toString().endsWith(".0")) {
      return jsonValue.toInt(); //Replaces doubles that end with .0 to int, to remove the .0 at the end
    } else {
      return jsonValue;
    }
  }

  // Array
  if (jsonValue is List) {
    return jsonValue.map((item) => jsonFullDoubleToInt(item)).toList();
  }

  // Object
  Map<String, dynamic> sortedMap = Map.fromEntries((jsonValue as Map<String, dynamic>).entries.toList()..sort((a, b) => a.key.compareTo(b.key)));

  return Map.fromEntries(
    sortedMap.entries.map(
      (entry) => MapEntry(entry.key, jsonFullDoubleToInt(entry.value)),
    ),
  );
}
