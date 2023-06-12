import 'package:carvice_frontend/utils/main.colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/app_navigation.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _controller = TextEditingController();
  String _paymentMessage = '';
  List<double> predefinedAmounts = [250, 500, 1000, 5000];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_hideSuccessMessage);
  }

  @override
  void dispose() {
    _controller.removeListener(_hideSuccessMessage);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavigation(
        title: 'Payment'.tr,
        automaticallyCallBack: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter deposit amount',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFF2B133), width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFF2B133), width: 2.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: predefinedAmounts.map((amount) {
                  return ElevatedButton(
                    onPressed: () => _makePayment(amount),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MainColors.mainColor,
                    ),
                    child: Text(
                        '${amount.toStringAsFixed(amount.truncateToDouble() == amount ? 0 : 2)}TL'),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MainColors.mainColor,
                ),
                onPressed: _makeCustomPayment,
                child: const Text('Deposit'),
              ),
              const SizedBox(height: 10),
              if (_paymentMessage.isNotEmpty)
                Text(
                  _paymentMessage,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                )
            ],
          ),
        ],
      ),
    );
  }

  void _hideSuccessMessage() {
    setState(() {
      _paymentMessage = '';
    });
  }

  void _makePayment(double amount) {
    if (amount <= 20) {
      setState(() {
        _paymentMessage =
            'Invalid amount.\nPlease enter an amount greater than 0.';
      });
    } else if (amount > 25000) {
      setState(() {
        _paymentMessage =
            'Invalid amount.\nPlease enter an amount less than 25000.';
      });
    } else {
      // TODO: Implement payment logic here
      print('Deposited $amount');

      setState(() {
        _paymentMessage = 'Payment Succeeded!';
      });
    }
  }

  void _makeCustomPayment() {
    double amount = double.tryParse(_controller.text) ?? 0;
    _makePayment(amount);
  }
}
