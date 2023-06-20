import 'package:carvice_frontend/widgets/app_navigation.dart';
import 'package:carvice_frontend/widgets/bottom_navigation.dart';
import 'package:carvice_frontend/widgets/mechanic_list.dart';
import 'package:carvice_frontend/widgets/side_bar.dart';
import 'package:flutter/material.dart';

import '../../../services/websocket_connection.dart';
import '../../../widgets/map_widget/map_page.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({Key? key, this.isSessionBegin = false})
      : super(key: key);

  final bool isSessionBegin;

  @override
  _ClientHomePageState createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  bool isClient = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (widget.isSessionBegin) {
        await StreamConnection(
                'ws://127.0.0.1:8000/ws/socket/geospatial-server/${mechanicId}/',
                context,
                "mechanic")
            .connect();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavigation(
        title: "Carvice",
      ),
      endDrawer: SideBarGlobal(isClient: true),
      body: Center(
        child: MapTrackingPage(isClient),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: 1,
        roleEndpoint: "client",
      ),
    );
  }
}
