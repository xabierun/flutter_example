import 'dart:convert';

import 'package:example_app/data/entity/postal/postal_code.dart';
import 'package:example_app/functions/api.dart';

class PostalCodeLogic {
  Future<PostalCode> getPostalCode(String postalCode) async {
    if (postalCode.length != 7) {
      throw Exception('Postal Code must be 7 characters');
    }

    // 123-4567
    final upper = postalCode.substring(0, 3); // 123
    final lower = postalCode.substring(3); // 4567

    final apiUrl =
        'https://madefor.github.io/postal-code-api/api/v1/$upper/$lower.json';

    final response2 = await getApi(apiUrl, {});

    final apiUri = Uri.parse(apiUrl);

    final response = await getApi(apiUrl, {});

    if (response.statusCode != 200) {
      throw Exception('No postal code: $postalCode');
    }

    // ここの解決方法
    // final jsonData = json.decode(response.body);
    final jsonData = json.decode(response.body) as Map<String, dynamic>;

    return PostalCode.fromJson(jsonData);
  }

  bool willProceed(String postalCode) {
    return postalCode.length == 7;
  }
}
