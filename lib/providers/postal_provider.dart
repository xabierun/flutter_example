import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:example_app/data/entity/postal/postal_code.dart';

final postalCodeProvider = StateProvider<String>((ref) {
  return '';
});

AutoDisposeFutureProviderFamily<PostalCode, String> apiFamilyProvider =
    FutureProvider.autoDispose
        .family<PostalCode, String>((ref, postalCode) async {
  if (postalCode.length != 7) {
    throw Exception('Postal Code must be 7 characters');
  }

  // 123-4567
  final upper = postalCode.substring(0, 3); // 123
  final lower = postalCode.substring(3); // 4567

  // https://madefor.github.io/postal-code-api/api/v1/100/0014.json
  final apiUrl =
      'https://madefor.github.io/postal-code-api/api/v1/$upper/$lower.json';
  final apiUri = Uri.parse(apiUrl);

  final response = await http.get(apiUri);

  if (response.statusCode != 200) {
    throw Exception('No postal code: $postalCode');
  }

  // ここの解決方法
  // final jsonData = json.decode(response.body);
  final jsonData = json.decode(response.body) as Map<String, dynamic>;

  return PostalCode.fromJson(jsonData);
});
