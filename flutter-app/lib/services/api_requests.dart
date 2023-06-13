import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestHandler {
  RequestHandler(this.url, this.body);
  var url;
  var body;

  Future getData() async {
    url = Uri.parse(url);
    try {
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: {
        'content-type': 'application/json',
        'Accept': 'application/json',
      });
      return jsonDecode(response.body);
    } on Exception {
      return {"message": "can't reach server"};
    }
  }

  Future getDataWithGet() async {
    url = Uri.parse(url);
    try {
      http.Response response = await http.get(url, headers: {
        'Accept': 'application/json',
      });
      return jsonDecode(response.body);
    } on Exception {
      return {"message": "can't reach server"};
    }
  }
}
