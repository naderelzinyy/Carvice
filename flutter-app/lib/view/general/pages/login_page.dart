import 'package:carvice_frontend/services/authentication.dart';
import 'package:carvice_frontend/widgets/button.dart';
import 'package:carvice_frontend/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../../utils/main.colors.dart';
import '../../../widgets/forget_password_enter_email_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.roleEndpoint}) : super(key: key);
  final String roleEndpoint;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool response = false;
  String text = "";
  late String roleEndpoint = widget.roleEndpoint;
  late String role = roleEndpoint == "mechanic" ? 'mechanic'.tr : 'client'.tr;

  @override
  void initState() {
    super.initState();
    // Add listener to update button state whenever text changes
    usernameController.addListener(updateButtonState);
    passwordController.addListener(updateButtonState);
  }

  void updateButtonState() {
    // Enable button if both text fields are not empty, disable otherwise
    setState(() {
      response = usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    });
  }

  void showPasswordResetAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResetPasswordAlert(roleEndpoint: roleEndpoint,);
      },
    );
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
              const SizedBox(height: 5),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/transparent_logo.png',
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.width * 0.6,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      role,
                      style:  TextStyle(
                        color: MainColors.mainColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 20),
               Text(
                'loginToYourAccount'.tr,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFiled(
                  controller: usernameController,
                  hintText: 'username'.tr,
                  textInputType: TextInputType.name,
                  obscureText: false),
              const SizedBox(height: 10),
              CustomTextFiled(
                  controller: passwordController,
                  hintText:'password'.tr,
                  textInputType: TextInputType.text,
                  obscureText: true),
              const SizedBox(height: 20),
              CustomButton(
                btnText: 'signIn'.tr,
                onTap: () async {
                  response = await AccountManager().authenticate({
                    "username": usernameController.text,
                    "password": passwordController.text
                  }, roleEndpoint);
                  if (response) {
                    if (roleEndpoint == "client") {
                      Get.offAllNamed(Routers.getClientHomePageRoute());
                    }
                    // make this more flexible to add new roles.
                    else if (roleEndpoint == "mechanic") {
                      Get.offAllNamed(Routers.getMechanicHomePageRoute());
                    }
                  } else {
                    setState(() {
                      text = "Username or password is not correct";
                      usernameController.clear(); // Clear the username field
                      passwordController.clear(); // Clear the password field
                    });
                  }
                  print(response);
                  print(text);
                },
                isDisabled: !response,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   Text('forgotPassword'.tr),
                  InkWell(
                    onTap: () {
                      showPasswordResetAlert(context);
                    },
                    child:Text('resetPassword'.tr),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Wrong Page? '),
                  InkWell(
                    onTap: () {
                      Get.offAllNamed(Routers.getStartingPageRoute());
                    },
                    child:const Text('Go back'),
                  )
                ],
              ),
            ],
          ),
        )),
      ),
      bottomNavigationBar: Container(
          height: 100,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text('noAccount'.tr),
              InkWell(
                onTap: () {
                  Get.offAllNamed(Routers.getSignupPageRoute(roleEndpoint));
                },
                child: Text('signUp'.tr),
              ),
            ],
          )),
    );
  }
}
