import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../widgets/alerts_text_button.dart';
import '../widgets/request_stream_widget.dart';
import '../widgets/text_field.dart';

class StreamConnection {
  final BuildContext context;
  final String role;
  final String url;
  late WebSocketChannel _channel;
  final TextEditingController priceController = TextEditingController();

  Stream<dynamic>? _stream;
  StreamSubscription<dynamic>? _subscription;

  StreamConnection(this.url, this.context, this.role);

  Future<void> connect() async {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    _stream = _channel.stream;
    _subscription = _stream?.listen(_handleData);
  }

  void send(Map<String, dynamic> message) {
    _channel.sink.add(jsonEncode(message));
  }

  void close() {
    _subscription?.cancel();
    _channel.sink.close();
  }

  void _showOfferDialog(dynamic receivedData) {
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
              Text(receivedData["client_name"] as String),
              Text(receivedData["car_brand"] as String),
              Text(receivedData["car_model"] as String),
              Text(receivedData["description"] as String),
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
