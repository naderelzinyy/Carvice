import 'dart:async';
import 'dart:convert';

import 'package:carvice_frontend/services/authentication.dart';
import 'package:carvice_frontend/widgets/mechanic_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../routes/routes.dart';
import '../widgets/alerts_text_button.dart';
import '../widgets/request_stream_widget.dart';
import '../widgets/text_field.dart';

bool isSessionStarted = false;
bool isRatingSessionStarted = false;

class StreamConnection {
  final BuildContext context;
  final String role;
  final String url;
  late WebSocketChannel _channel;
  bool isConnected = false; // Track the connection status

  final TextEditingController priceController = TextEditingController();
  Stream<dynamic>? _stream;
  StreamSubscription<dynamic>? _subscription;
  // Private static instance variable
  static StreamConnection? _instance;

  // Private constructor
  StreamConnection._internal(this.url, this.context, this.role);

  // Factory method to get the singleton instance
  factory StreamConnection(String url, BuildContext context, String role) {
    _instance ??= StreamConnection._internal(url, context, role);
    return _instance!;
  }
  double amount = 0;
  Future<void> connect() async {
    if (!isConnected) {
      print("Connected");
      _channel = WebSocketChannel.connect(Uri.parse(url));
      _stream = _channel.stream;
      _subscription = _stream?.listen(_handleData);
      isConnected = true;
    }
  }

  void send(Map<String, dynamic> message) {
    _channel.sink.add(jsonEncode(message));
  }

  void close() {
    isConnected = false;
    _subscription?.cancel();
    _channel.sink.close();
  }

  Future<void> _showOfferDialog(dynamic receivedData) async {
    amount = double.parse(receivedData['price']);
    var currentBalance = await AccountManager().fetchBalance(token!["id"]);
    if (currentBalance < amount) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomRequestStreamAlertDialog(
            title: 'Insufficient balance',
            content: Text("You will need to deposit money."),
            actions: <Widget>[],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomRequestStreamAlertDialog(
            title: 'Server message',
            content: Text("The price is ${receivedData['price']} TL"),
            actions: <Widget>[
              CustomAlertButton(
                text: 'Refuse',
                onPressed: () {
                  send({"type": "refuse_offer", "message": "Offer refused"});
                  Navigator.of(context).pop();
                },
              ),
              CustomAlertButton(
                text: 'Accept',
                onPressed: () {
                  send({"type": "start_session", "message": "Session started"});
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _showRequestRefuseDialog(dynamic receivedData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomRequestStreamAlertDialog(
          title: 'Request Refused',
          content:
              const Text("The mechanic can't accept your request right now."),
          actions: <Widget>[
            CustomAlertButton(
              text: 'Ok',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showStartSessionDialogForMechanic(dynamic receivedData) {
    isSessionStarted = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomRequestStreamAlertDialog(
          title: 'Session Starts',
          content: const Text(
              "Client accepted your offer. You can go to the client's location."),
          actions: <Widget>[
            CustomAlertButton(
              text: 'Ok',
              onPressed: () {
                Get.offAllNamed(Routers.getMechanicHomePageRoute());
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showStartSessionDialogForClient(dynamic receivedData) async {
    var response = await AccountManager().transfer({
      "sender_id": token!["id"],
      "receiver_id": mechanicId,
      "amount": amount
    });
    isSessionStarted = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomRequestStreamAlertDialog(
          title: 'Session Starts',
          content: const Text("The mechanic is on the way!"),
          actions: <Widget>[
            CustomAlertButton(
              text: 'Ok',
              onPressed: () {
                Get.offAllNamed(Routers.getClientHomePageSessionRoute());
              },
            ),
          ],
        );
      },
    );
  }

  void _showEndSessionDialogForClient(dynamic receivedData) {
    print("End Session data :: $receivedData");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomRequestStreamAlertDialog(
          title: 'Session Ends',
          content: const Text(
              "The session ended. The payment will be done automatically."),
          actions: <Widget>[
            CustomAlertButton(
              text: 'Ok',
              onPressed: () {
                Get.offAllNamed(Routers.getClientHomePageSessionRoute());
              },
            ),
          ],
        );
      },
    );
  }

  void _showOfferRefuseDialog(dynamic receivedData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomRequestStreamAlertDialog(
          title: 'Offer Refused',
          content: const Text("The client refused the offer."),
          actions: <Widget>[
            CustomAlertButton(
              text: 'Ok',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleClientSocket(dynamic receivedData) {
    if (receivedData != null) {
      var message = receivedData["message"];
      var type = receivedData["type"];
      // Show dialog or perform any desired action
      if (type == "show_offer") {
        _showOfferDialog(receivedData);
      } else if (type == "refuse_request") {
        _showRequestRefuseDialog(receivedData);
      } else if (type == "start_session") {
        _showStartSessionDialogForClient(receivedData);
      } else if (type == "end_session") {
        print("End Session");
        _showOfferRefuseDialog(receivedData);
      }
    }
  }

  void _showRequestDialog(dynamic receivedData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomRequestStreamAlertDialog(
          title: 'Server message',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Name: ${receivedData["client_name"] as String}',
              ),
              Text('Brand: ${receivedData["car_brand"] as String}'),
              Text('Car Model: ${receivedData["car_model"] as String}'),
              Text('Location: ${receivedData["location"] as String}'),
              Text('Description: ${receivedData["description"] as String}'),
            ],
          ),
          actions: <Widget>[
            CustomTextFiled(
                controller: priceController,
                hintText: 'Enter price',
                textInputType: TextInputType.number,
                obscureText: false),
            CustomAlertButton(
              text: 'Refuse',
              onPressed: () {
                send({"type": "refuse_request", "message": "Request refused"});
                Navigator.of(context).pop();
              },
            ),
            CustomAlertButton(
              text: 'Offer',
              onPressed: () {
                send({"type": "receive_offer", "price": priceController.text});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleMechanicSocket(dynamic receivedData) {
    if (receivedData != null) {
      var type = receivedData["type"];
      if (type == "show_request") {
        _showRequestDialog(receivedData);
      } else if (type == "refuse_offer") {
        _showOfferRefuseDialog(receivedData);
      } else if (type == "start_session") {
        _showStartSessionDialogForMechanic(receivedData);
      }
    }
  }

  void _handleData(dynamic data) {
    print("handleData :: data = $data");
    var receivedData = jsonDecode(data);
    if (role == "client") {
      _handleClientSocket(receivedData);
    } else {
      _handleMechanicSocket(receivedData);
    }
  }
}
