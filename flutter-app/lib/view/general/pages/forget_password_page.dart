import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../../widgets/app_navigation.dart';
import '../../../widgets/button.dart';
import '../../../widgets/text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key, required this.roleEndpoint}) : super(key: key);

  final String roleEndpoint;

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isButtonDisabled = true;
  String errorMessage = '';
  late String roleEndpoint = widget.roleEndpoint;

  @override
  void initState() {
    super.initState();

    newPasswordController.addListener(updateButtonState);
    confirmPasswordController.addListener(updateButtonState);
  }

  void updateButtonState() {
    // Enable button if all fields are not empty, disable otherwise
    setState(() {
      isButtonDisabled = (newPasswordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty);
    });
  }

  void resetPassword() {
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

    // TODO: Add your logic for resetting the password here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavigation(title: 'reset_password'.tr),
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
                resetPassword();
              },
            ),
            const SizedBox(height: 10.0),
            CustomButton(
              btnText: 'cancel'.tr,
              onTap: () {
                Get.offAllNamed(Routers.getLoginPageRoute(roleEndpoint));
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
