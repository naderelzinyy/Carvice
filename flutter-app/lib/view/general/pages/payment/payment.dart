import 'package:carvice_frontend/utils/main.colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/authentication.dart';
import '../../../../widgets/app_navigation.dart';
import 'bank_card_information.dart';

class PaymentPage extends StatefulWidget {
  final bool isDeposit;
  const PaymentPage({Key? key, this.isDeposit = true}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _controller = TextEditingController();
  String _paymentMessage = '';
  double currentBalance = token!['balance'];
  List<double> predefinedAmounts = [250, 500, 1000, 5000];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_hideSuccessMessage);
    _updateBalance();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateBalance();
  }

  _updateBalance() async {
    var userId =
        token!['id'];
    currentBalance = await AccountManager().fetchBalance(userId);
    setState(() {});
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
        title: widget.isDeposit ? 'Deposit' : 'Withdrawal',
        automaticallyCallBack: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: widget.isDeposit
                        ? 'Enter deposit amount'
                        : 'Enter withdrawal amount',
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFF2B133), width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
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
                child: Text(widget.isDeposit ? 'Deposit' : 'Withdraw'),
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
    // TODO: Implement payment logic here
    String operation = widget.isDeposit ? 'Deposit' : 'Withdrawal';

    if (amount <= 0) {
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
      if (!widget.isDeposit && amount > currentBalance) {
        setState(() {
          _paymentMessage =
              'Invalid amount.\nYou can\'t withdraw more than your balance.';
        });
        return;
      }
      print('$operation $amount');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CardInformation(
                isDeposit: widget.isDeposit,
                amount: amount,
              )));
    }
  }

  void _makeCustomPayment() {
    double amount = double.tryParse(_controller.text) ?? 0;
    _makePayment(amount);
  }
}
