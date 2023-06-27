import 'package:http/http.dart' as http;

import 'notification_config.dart';

class Http {
  // Send GET request to [url] with [headers].
  static Future<http.Response> get(
      String url, Map<String, String> headers) async {
    http.Response response = await http
        .get(Uri.parse(url), headers: headers)
        .timeout(const Duration(seconds: pushNotificationsRequestTimeout));
    return response;
  }
}
