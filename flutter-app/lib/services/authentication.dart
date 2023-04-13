import 'package:carvice_frontend/services/api_requests.dart';

class Authenticator {
  Future<bool> authenticate(Map<String, String> body, String roleEndpoint) async {
    print(body);
    print(roleEndpoint);
    RequestHandler requestHandler =
        RequestHandler('http://localhost:8000/api/${roleEndpoint}/signin', body);
    var data = await requestHandler.getData();
    print("data = ");
    print(data);
    if (data.containsKey("jwt")) {
      return true;
    }
    return false;
  }

  Future<bool> register(Map<String, String> body,  String roleEndpoint) async {
    print(body);
    RequestHandler requestHandler =
        RequestHandler('http://localhost:8000/api/signup', body);
    var data = await requestHandler.getData();
    print(data);
    if (data.containsKey("first_name")) {
      return true;
    }
    return false;
  }
}
