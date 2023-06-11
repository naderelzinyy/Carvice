import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_navigation.dart';
import '../../../widgets/button.dart';
import '../../../widgets/text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isButtonDisabled = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();

    oldPasswordController.addListener(updateButtonState);
    newPasswordController.addListener(updateButtonState);
    confirmPasswordController.addListener(updateButtonState);
  }

  void updateButtonState() {
    // Enable button if all fields are not empty, disable otherwise
    setState(() {
      isButtonDisabled = (oldPasswordController.text.isEmpty ||
          newPasswordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty);
    });
  }

  void changePassword() {

    // Validate the new password length
    if (newPasswordController.text.length < 5) {
      setState(() {
        errorMessage = 'error_message_password_must_be_5_char'.tr;
      });
      return;
    }

    // Validate that the confirmation password matches the new password
    if (newPasswordController.text != confirmPasswordController.text) {
      setState(() {
        errorMessage = 'error_message_new_password_conf_not_match'.tr;
      });
      return;
    }

    // Clear the error message and show a success message
    setState(() {
      errorMessage = '';
    });

    // TODO: Add your logic for changing the password here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavigation(title: 'change_password'.tr, automaticallyCallBack: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (errorMessage.isNotEmpty)
              Container(
                color: Colors.red.shade100,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 16.0),
            CustomTextFiled(
              controller: oldPasswordController,
               hintText: 'old_password'.tr,
                textInputType: TextInputType.text,
                obscureText: true
            ),
            const SizedBox(height: 16.0),
            CustomTextFiled(
              controller: newPasswordController,
              obscureText: true,
              textInputType: TextInputType.text,
              hintText: 'new_password'.tr,
            ),
            const SizedBox(height: 16.0),
            CustomTextFiled(
              controller: confirmPasswordController,
              obscureText: true,
              textInputType: TextInputType.text,
              hintText: 'conf_new_password'.tr,
            ),
            const SizedBox(height: 16.0),
            CustomButton(
              isDisabled: isButtonDisabled,
              btnText: 'save'.tr,
              onTap: () {
                changePassword();

              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Made with ♥ by Carvice team",
            ),
          ],
        ),
      ),
    );

  }
}
