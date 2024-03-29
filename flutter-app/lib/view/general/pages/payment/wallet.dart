import 'package:carvice_frontend/utils/main.colors.dart';
import 'package:carvice_frontend/view/general/pages/payment/payment.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _updateBalance();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateBalance();
  }

  _updateBalance() async {
    var userId = token!['id'];
    currentBalance = await AccountManager().fetchBalance(userId);
    setState(() {});
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
                  );
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
                  );
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
