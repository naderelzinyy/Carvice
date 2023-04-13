import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestHandler {
  RequestHandler(this.url, this.body);
  var url;
  var body;

  Future getData() async {
    url = Uri.parse(url);

    http.Response response = await http.post(url, body: body);
    return jsonDecode(response.body);
  }
}
