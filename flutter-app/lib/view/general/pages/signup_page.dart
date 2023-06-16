import 'package:carvice_frontend/services/authentication.dart';
import 'package:carvice_frontend/widgets/button.dart';
import 'package:carvice_frontend/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../../widgets/custom_app_footer.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required this.roleEndpoint}) : super(key: key);
  final String roleEndpoint;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool is_signed_up = false;
  String errorMessage = '';
  bool isDisabled = true;
  late String roleEndpoint = widget.roleEndpoint;

  @override
  void initState() {
    super.initState();
    // Add listener to update button state whenever text changes
    usernameController.addListener(updateButtonState);
    firstNameController.addListener(updateButtonState);
    lastNameController.addListener(updateButtonState);
    passwordController.addListener(updateButtonState);
    confPasswordController.addListener(updateButtonState);
    emailController.addListener(updateButtonState);
    phoneController.addListener(updateButtonState);
  }

  void updateButtonState() {
    // Enable button if all fields are not empty, disable otherwise
    setState(() {
      isDisabled = (usernameController.text.isEmpty ||
          firstNameController.text.isEmpty ||
          lastNameController.text.isEmpty ||
          passwordController.text.isEmpty ||
          confPasswordController.text.isEmpty ||
          emailController.text.isEmpty ||
          phoneController.text.isEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/transparent_logo.png',
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.width * 0.45,
                  fit: BoxFit.contain,
                ),
              ),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 20),
               Text(
                'createNewAccount'.tr,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFiled(
                  controller: firstNameController,
                  hintText: 'firstName'.tr,
                  textInputType: TextInputType.name,
                  obscureText: false),
              const SizedBox(height: 10),
              CustomTextFiled(
                  controller: lastNameController,
                  hintText:'lastName'.tr,
                  textInputType: TextInputType.name,
                  obscureText: false),
              const SizedBox(height: 10),
              CustomTextFiled(
                  controller: usernameController,
                  hintText: 'username'.tr,
                  textInputType: TextInputType.name,
                  obscureText: false),
              const SizedBox(height: 10),
              CustomTextFiled(
                  controller: emailController,
                  hintText: 'email'.tr,
                  textInputType: TextInputType.emailAddress,
                  obscureText: false),
              const SizedBox(height: 10),
              CustomTextFiled(
                  controller: phoneController,
                  hintText: 'phoneNumber'.tr,
                  textInputType: TextInputType.phone,
                  obscureText: false),
              const SizedBox(height: 10),
              CustomTextFiled(
                  controller: passwordController,
                  hintText: 'password'.tr,
                  textInputType: TextInputType.text,
                  obscureText: true),
              const SizedBox(height: 10),
              CustomTextFiled(
                  controller: confPasswordController,
                  hintText: 'passwordConfirmation'.tr,
                  textInputType: TextInputType.text,
                  obscureText: true),
              const SizedBox(height: 25),
              CustomButton(
                btnText: 'signUp'.tr,
                onTap: () async {
                  // Check for first and last name validity
                  if (firstNameController.text.length < 3 ||
                      lastNameController.text.length < 3 ||
                      firstNameController.text.contains(RegExp(r'[0-9]')) ||
                      lastNameController.text.contains(RegExp(r'[0-9]'))) {
                    errorMessage = 'invalidName'.tr;
                    setState(() {});
                    return;
                  }

                  // Check for email validity
                  if (!emailController.text.contains('@')) {
                    errorMessage = 'invalidEmail'.tr;
                    setState(() {});
                    return;
                  }

                  // Check for phone number validity
                  if (phoneController.text.contains(RegExp('[^0-9-]'))) {
                    errorMessage = 'invalidPhoneNumber'.tr;
                    setState(() {});
                    return;
                  }

                  // Check for password and confirmation password match
                  if (passwordController.text != confPasswordController.text) {
                    errorMessage = 'passwordsDoNotMatch'.tr;
                    setState(() {});
                    return;
                  }

                  // Check for password length
                  if (passwordController.text.length < 3) {
                    errorMessage = 'passwordTooShort'.tr;
                    setState(() {});
                    return;
                  }

                  is_signed_up = await AccountManager().register({
                    "first_name": firstNameController.text,
                    "last_name": lastNameController.text,
                    "username": usernameController.text,
                    "email": emailController.text,
                    "password": passwordController.text,
                    "phone_number": "+90${phoneController.text}",
                    "is_client": roleEndpoint == "client" ? "1" : "0",
                    "is_mechanic": roleEndpoint == "mechanic" ? "1" : "0",
                  }, roleEndpoint);

                  // If there are no errors, clear the error message and show a success message
                  errorMessage = '';
                  setState(() {});
                  if (is_signed_up) {
                    Get.offAllNamed(Routers.getLoginPageRoute(roleEndpoint));
                    // Add your logic for showing a success message here
                  } else {
                    // clear fields
                    firstNameController.clear();
                    lastNameController.clear();
                    usernameController.clear();
                    emailController.clear();
                    passwordController.clear();
                    confPasswordController.clear();
                    // Display error message if user registration failed
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title:  Text('dialogErrorTitle'.tr),
                          content: Text('dialogErrorMessage'.tr),
                          actions: <Widget>[
                            TextButton(
                              child: Text('dialogTryAgain'.tr),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                isDisabled: isDisabled,
              ),
            ],
          ),
        )),
      ),
      bottomNavigationBar: const CustomFooterWidget()
    );
  }
}
