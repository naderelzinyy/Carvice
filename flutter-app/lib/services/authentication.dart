import 'package:carvice_frontend/services/api_requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

Map<Object, dynamic>? token;
List<Map<Object, dynamic>>? carsToken;

String ip = "localhost"; // Enter your IP here to allow multiple emulators

class AccountManager {
  Future<bool> authenticate(
      Map<String, String> body, String roleEndpoint) async {
    print("Request body: $body");
    print("role : $roleEndpoint");
    RequestHandler requestHandler =
        RequestHandler('http://$ip:8000/api/${roleEndpoint}/signin', body);
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
        RequestHandler('http://$ip:8000/api/signup', body);
    var data = await requestHandler.getData();
    print(data);
    if (data.containsKey("first_name")) {
      try {
        if (data != null) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(data["id"].toString())
              .set({'username': data["username"]});
          return true;
        }
      } on Exception catch (e) {
        print(e);
        return false;
      }
    }
    return false;
  }

  Future<bool> logout(Map<String, String> body) async {
    print(body);
    RequestHandler requestHandler =
        RequestHandler('http://$ip:8000/api/signout', body);
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
    print("updated token :: ${data["jwt"]}");
    if (data.containsKey("jwt")) {
      token = JwtDecoder.decode(data['jwt']);
      return true;
    }
    return false;
  }

  Future<bool> addCar(Map<String, String> body) async {
    print(body);
    RequestHandler requestHandler =
        RequestHandler('http://localhost:8000/api/addCar', body);
    var data = await requestHandler.getData();
    print("car data :: $data");
    return true;
  }

  Future<bool> getCars() async {
    RequestHandler requestHandler = RequestHandler(
        'http://localhost:8000/api/getCars',
        {"user_id": token!["id"].toString()});
    var data = await requestHandler.getData();
    print("cars :: $data");
    if (data.containsKey("cars")) {
      carsToken = data!["cars"];
      return true;
    }
    return false;
  }
}
