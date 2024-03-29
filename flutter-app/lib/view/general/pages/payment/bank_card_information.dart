import 'package:carvice_frontend/utils/main.colors.dart';
import 'package:carvice_frontend/view/general/pages/payment/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

import '../../../../services/authentication.dart';
import '../../../../widgets/app_navigation.dart';
import '../../../../widgets/custom_app_footer.dart';

class CardInformation extends StatefulWidget {
  final bool isDeposit;
  final double amount;

  const CardInformation({
    Key? key,
    this.isDeposit = true,
    required this.amount,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CardInformationState();
}

class CardInformationState extends State<CardInformation> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppNavigation(
          title: 'Payment'.tr,
          automaticallyCallBack: true,
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                bankName: 'Debit/Credit Card'.tr,
                frontCardBorder: Border.all(color: Colors.black45),
                backCardBorder: Border.all(color: Colors.black45),
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: MainColors.mainColor,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: Colors.blue,
                        textColor: Colors.black,
                        cardNumberDecoration: InputDecoration(
                          labelText: 'Card Number'.tr,
                          hintText: 'XXXX XXXX XXXX XXXX',
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelStyle: const TextStyle(color: Colors.grey),
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        expiryDateDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelStyle: const TextStyle(color: Colors.grey),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Expired Date'.tr,
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelStyle: const TextStyle(color: Colors.grey),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelStyle: const TextStyle(color: Colors.grey),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Card Holder'.tr,
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: _onValidate,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: <Color>[
                                Color(0xFFF2B133),
                                Color(0xFFF2B133),
                                Colors.orange,
                                Colors.deepOrange,
                              ],
                              begin: Alignment(-1, -4),
                              end: Alignment(1, 4),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            'Validate'.tr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomFooterWidget());
  }

  void _onValidate() {
    if (formKey.currentState!.validate()) {
      print('valid bank card!');

      Map<String, dynamic> data = {
        'id': token!['id'],
        'amount': widget.amount,
      };

      if (widget.isDeposit) {
        AccountManager().deposit(data).then((success) {
          if (success) {
            print('Deposit successful');
            //TODO: Add a popup to success message with close button to go back to wallet
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const WalletPage()));
          } else {
            print('Deposit failed');
          }
        });
      } else {
        AccountManager().withdraw(data).then((success) {
          if (success) {
            print('Withdrawal successful');
            //TODO: Add a popup to success message with close button to go back to wallet
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const WalletPage()));
          } else {
            print('Withdrawal failed');
          }
        });
      }
    } else {
      print('invalid bank card!');
    }
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
