import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carvice_frontend/widgets/button.dart';
import 'package:carvice_frontend/widgets/text_field.dart';

import '../routes/routes.dart';

class ResetPasswordAlert extends StatefulWidget {
  const ResetPasswordAlert({Key? key, required this.roleEndpoint}) : super(key: key);
  final String roleEndpoint;

  @override
  _ResetPasswordAlertState createState() => _ResetPasswordAlertState();
}

class _ResetPasswordAlertState extends State<ResetPasswordAlert> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmationCodeController = TextEditingController();
  bool emailExists = false;
  bool codeVerified = false;
  bool showEmailErrorMessage = false;
  bool showCodeErrorMessage = false;
  late String roleEndpoint = widget.roleEndpoint;

  bool isEmailFieldEmpty() {
    return emailController.text.isEmpty;
  }

  bool isConfirmationCodeFieldEmpty() {
    return confirmationCodeController.text.isEmpty;
  }

  void checkEmailExists() {
    // Simulating email existence check in the database
    // Replace this with your actual database logic
    if (emailController.text == 'example@example.com') {
      setState(() {
        emailExists = true;
      });
    } else {
      setState(() {
        emailExists = false;
      });
    }
  }

  void verifyConfirmationCode() {
    // Simulating confirmation code verification
    // Replace this with your actual verification logic
    if (confirmationCodeController.text == '123456') {
      Get.offAllNamed(Routers.getSetNewPasswordRoute(roleEndpoint));
    } else {
      setState(() {
        codeVerified = false;
        showErrorMessages(); // Show error messages based on email and confirmation code validity
        if (!codeVerified) {
          confirmationCodeController.clear(); // Clear the confirmation code text field using the controller
        }
      });
    }
  }

  void showErrorMessages() {
    setState(() {
      showEmailErrorMessage = !emailExists;
      showCodeErrorMessage = emailExists && confirmationCodeController.text.isNotEmpty && !codeVerified;
    });
  }

  @override
  void dispose() {
    // Clean up the TextEditingController instances
    emailController.dispose();
    confirmationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(emailExists ? 'confirmation_code'.tr : 'reset_password'.tr),
      content: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 30, 5, 10), // Adjust the padding as needed
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (showEmailErrorMessage) // Display email error message if showEmailErrorMessage is true
                const Text(
                  'email_does_not_exist',
                  style: TextStyle(color: Colors.red),
                ),
              if (!emailExists)
                CustomTextFiled(
                  controller: emailController,
                  onChanged: (value) {
                    setState(() {
                      showEmailErrorMessage = false; // Hide the email error message when email is changed
                    });
                  },
                  hintText: 'Email',
                  textInputType: TextInputType.text,
                  obscureText: false,
                ),
              if (showCodeErrorMessage) // Display confirmation code error message if showCodeErrorMessage is true
                 Text(
                  'invalid_confirmation_code'.tr,
                  style: const TextStyle(color: Colors.red),
                ),
              if (emailExists)
                CustomTextFiled(
                  controller: confirmationCodeController,
                  onChanged: (value) {
                    setState(() {
                      showCodeErrorMessage = false; // Hide the confirmation code error message when confirmation code is changed
                    });
                  },
                  hintText: 'confirmation_code'.tr,
                  textInputType: TextInputType.text,
                  obscureText: false,
                ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          children: [
            if (!emailExists)
              Expanded(
                child: CustomButton(
                  onTap: () {
                    checkEmailExists();
                    showErrorMessages(); // Show error messages based on email and confirmation code validity
                    if (!emailExists) {
                      emailController.clear(); // Clear the email text field using the controller
                    }
                  },
                  isDisabled: isEmailFieldEmpty(),
                  btnText: 'find_account'.tr,
                ),
              ),
            if (emailExists && !codeVerified)
              Expanded(
                child: CustomButton(
                  btnText: 'next'.tr,
                  onTap: () {
                    verifyConfirmationCode();

                  },
                  isDisabled: isConfirmationCodeFieldEmpty(),
                ),
              ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomButton(
                onTap: () {
                  emailController.clear(); // Clear the email text field using the controller
                  confirmationCodeController.clear(); // Clear the confirmation code text field using the controller
                  setState(() {
                    showEmailErrorMessage = false; // Hide the email error message
                    showCodeErrorMessage = false; // Hide the confirmation code error message
                  });
                  Navigator.of(context).pop();
                },
                btnText: 'cancel'.tr,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
