import 'package:carvice_frontend/services/api_requests.dart';

class Authenticator {
  Future<bool> authenticate(Map<String, String> body) async {
    print(body);
    RequestHandler requestHandler =
        RequestHandler('http://localhost:8000/api/signin', body);
    var data = await requestHandler.getData();
    print("data = ");
    print(data);
    if (data.containsKey("jwt")) {
      return true;
    }
    return false;
  }
}
