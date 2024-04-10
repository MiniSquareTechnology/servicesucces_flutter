import 'package:http/http.dart' as http;

class CheckInternetService {
  Future<bool> checkInternet() async {
    try {
      final response = await http.head(Uri.parse('https://www.google.com'));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
