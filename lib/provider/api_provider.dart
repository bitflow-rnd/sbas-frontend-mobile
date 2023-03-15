import 'dart:convert';

final json = {'Content-Type': 'application/json'};

String toJson(Map<String, dynamic> map) {
  return jsonEncode(map);
}

Map<String, dynamic> fromJson(String body) {
  return jsonDecode(body);
}
