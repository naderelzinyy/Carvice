import 'package:carvice_frontend/services/api_requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

Map<Object, dynamic>? token;
Map<Object, dynamic>? mechanicAddressInfo;
List<dynamic>? carsData;

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
    if (data.containsKey("owner")) {
      return true;
    }
    return false;
  }

  Future<List<dynamic>> getCars() async {
    RequestHandler requestHandler = RequestHandler(
        'http://localhost:8000/api/getCars',
        {"user_id": token!["id"].toString()});
    print(token!["id"].toString());
    var data = await requestHandler.getData();
    if (data.containsKey("cars")) {
      carsData = data["cars"];
      print("cars data :: $carsData");
      return data["cars"] as List<dynamic>;
    }
    return [];
  }

  Future<bool> deleteCar(Map<String, String> body) async {
    RequestHandler requestHandler =
        RequestHandler('http://localhost:8000/api/deleteCar', body);
    print(token!["id"].toString());
    var data = await requestHandler.getData();
    if (data.containsKey("message")) {
      if (data["message"] == "success") {
        print("Deleted");
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> updateCar(Map<String, String> body) async {
    RequestHandler requestHandler =
        RequestHandler('http://localhost:8000/api/updateCar', body);
    var data = await requestHandler.getData();
    if (data.containsKey("message")) {
      if (data["message"] == "success") {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> addMechanicLocation(Map<String, dynamic> body) async {
    RequestHandler requestHandler = RequestHandler(
        'http://localhost:8000/api/geoRequest/addMechanicLocation', body);
    var data = await requestHandler.getData();
    if (data.containsKey("success_message")) {
      return true;
    }
    return false;
  }

  Future<bool> getMechanicAddressInfo(Map<String, dynamic> body) async {
    RequestHandler requestHandler = RequestHandler(
        'http://localhost:8000/api/geoRequest/getMechanicAddressInfo', body);
    var data = await requestHandler.getData();
    if (data.containsKey("mechanic_info")) {
      mechanicAddressInfo = data["mechanic_info"];
      print("$mechanicAddressInfo");
      return true;
    }
    return false;
  }

  Future<bool> updateMechanicAddressInfo(Map<String, dynamic> body) async {
    print("update request :: $body");
    RequestHandler requestHandler = RequestHandler(
        'http://localhost:8000/api/geoRequest/updateMechanicInfo', body);
    var data = await requestHandler.getData();
    if (data.containsKey("message")) {
      return true;
    }
    return false;
  }

  Future<List<dynamic>> getAvailableMechanics(Map<String, dynamic> body) async {
    print("coordinates request :: $body");
    RequestHandler requestHandler = RequestHandler(
        'http://localhost:8000/api/geoRequest/getNearMechanics', body);
    var data = await requestHandler.getData();
    if (data.containsKey("available_mechanics")) {
      print(data['available_mechanics']);
      return data["available_mechanics"] as List<dynamic>;
    }
    return [];
  }

  Future<bool> deposit(Map<String, dynamic> body) async {
    RequestHandler requestHandler =
        RequestHandler('http://$ip:8000/api/deposit', body);
    var data = await requestHandler.getData();
    return data.containsKey("message") && data["message"] == "success";
  }

  Future<bool> withdraw(Map<String, dynamic> body) async {
    RequestHandler requestHandler =
        RequestHandler('http://$ip:8000/api/withdraw', body);
    var data = await requestHandler.getData();
    return data.containsKey("message") && data["message"] == "success";
  }

  Future<bool> transfer(Map<String, dynamic> body) async {
    RequestHandler requestHandler =
        RequestHandler('http://$ip:8000/api/transfer', body);
    var data = await requestHandler.getData();
    return data.containsKey("message") && data["message"] == "success";
  }

  Future<double> fetchBalance(int userId) async {
    RequestHandler requestHandler =
        RequestHandler('http://$ip:8000/api/balance/$userId');
    var data = await requestHandler.getDataWithGet();
    if (data.containsKey("balance")) {
      return data["balance"];
    } else {
      throw Exception('Failed to fetch balance');
    }
  }
}
