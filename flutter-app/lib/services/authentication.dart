import 'package:carvice_frontend/services/api_requests.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

Map<Object, dynamic>? token;

class AccountManager {
  Future<bool> authenticate(
      Map<String, String> body, String roleEndpoint) async {
    print("Request body: $body");
    print("role : $roleEndpoint");
    RequestHandler requestHandler = RequestHandler(
        'http://localhost:8000/api/${roleEndpoint}/signin', body);
    var data = await requestHandler.getData();
    if (data.containsKey("jwt")) {
      token = JwtDecoder.decode(data['jwt']);
      print("jwt = $token");
      return true;
    }
    return false;
  }

  Future<bool> register(Map<String, String> body, String roleEndpoint) async {
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

  Future<bool> logout(Map<String, String> body) async {
    print(body);
    RequestHandler requestHandler =
        RequestHandler('http://localhost:8000/api/signout', body);
    var data = await requestHandler.getData();
    print(data);
    if (data!["message"] == "success") {
      print("jwt: $token");
      return true;
    }
    return false;
  }

  Future<bool> updateInfo(Map<String, String> body) async {
    print(body);
    RequestHandler requestHandler =
        RequestHandler('http://localhost:8000/api/updateInfo', body);
    var data = await requestHandler.getData();
    print(data);
    if (data.containsKey("first_name")) {
      token = data;
      return true;
    }
    return false;
  }
}
