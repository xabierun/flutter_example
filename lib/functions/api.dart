// TODO(tano): postも今後実装予定
import 'package:http/http.dart' as http;

Future<http.Response> getApi(String url, Map<String, String>? header) async {
  final apiUri = Uri.parse(url);
  final response = await http.get(apiUri, headers: header);

  return response;
}
