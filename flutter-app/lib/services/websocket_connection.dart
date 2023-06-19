import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../widgets/request_stream_widget.dart';

class StreamConnection {
  final BuildContext context;
  final String role;
  final String url;
  late WebSocketChannel _channel;
  Stream<dynamic>? _stream;
  StreamSubscription<dynamic>? _subscription;

  StreamConnection(this.url, this.context, this.role);

  Future<void> connect() async {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    _stream = _channel.stream;
    _subscription = _stream?.listen(_handleData);
  }

  void _handleClientSocket(dynamic receivedData) {
    if (receivedData != null) {
      var message = receivedData["message"];
      var type = receivedData["type"];
      // Show dialog or perform any desired action
      if (type == "show_offer") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomRequestStreamAlertDialog(
              title: 'Server message',
              content: Text(message),
            );
          },
        );
      }
    }
  }

  void _handleMechanicSocket(dynamic receivedData) {
    if (receivedData != null) {
      var message = receivedData["message"];
      var type = receivedData["type"];
      // Show dialog or perform any desired action

      if (type == "show_request") {
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
                  Text(receivedData["description"] as String),
                ],
              ),
            );
          },
        );
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

  void send(Map<String, dynamic> message) {
    _channel.sink.add(jsonEncode(message));
  }

  void close() {
    _subscription?.cancel();
    _channel.sink.close();
  }
}
