import 'package:carvice_frontend/utils/main.colors.dart';
import 'package:carvice_frontend/view/general/pages/payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../../../services/authentication.dart';
import '../../../../widgets/app_navigation.dart';
import '../../../../widgets/custom_app_footer.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  double currentBalance = token!['balance'];
  String currentBalanceText = "Current Balance:".tr;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _updateBalance();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateBalance();
  }

  _updateBalance() async {
    var userId = token!['id'];
    double oldBalance = currentBalance;
    currentBalance = await AccountManager().fetchBalance(userId);
    if (oldBalance != currentBalance) {
      String operation = oldBalance < currentBalance ? 'deposited' : 'withdrawn';
      double change = (currentBalance - oldBalance).abs();
      _showNotification(operation, change);
    }
    setState(() {});
  }

  _showNotification(String operation, double change) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'balance_change_channel', 'Balance Change',
        importance: Importance.max, priority: Priority.high, showWhen: false
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(); // Here is the change
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics
    );
    await flutterLocalNotificationsPlugin.show(
        0, 'Balance Updated',
        '$change has been $operation to your account', platformChannelSpecifics
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppNavigation(
          title: 'Wallet'.tr,
          automaticallyCallBack: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: Text(
                  '$currentBalanceText ${currentBalance.toStringAsFixed(currentBalance.truncateToDouble() == currentBalance ? 0 : 2)}TL',
                  style: TextStyle(
                    fontSize: 20,
                    color: MainColors.mainColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MainColors.mainColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const PaymentPage(isDeposit: true),
                        maintainState: false),
                  ).then((_) => _updateBalance());
                },
                child: Text(
                  'Deposit'.tr,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MainColors.mainColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const PaymentPage(isDeposit: false),
                        maintainState: false),
                  ).then((_) => _updateBalance());
                },
                child: Text(
                  'Withdraw'.tr,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomFooterWidget());
  }
}
