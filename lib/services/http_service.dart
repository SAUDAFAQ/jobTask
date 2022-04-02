import 'package:http/http.dart' as http;

class HttpService {
  static const baseUrl = "https://jsonplaceholder.typicode.com/posts";

  static Future<http.Response> getRequest(userName) async {
    http.Response response;
    final url = Uri.parse(baseUrl);
    try {
      response = await http.post(url, body: {"name": userName});
    } on Exception catch (e) {
      rethrow;
    }
    return response;
  }
}
