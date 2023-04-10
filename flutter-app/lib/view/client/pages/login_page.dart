import 'package:carvice_frontend/services/authentication.dart';
import 'package:carvice_frontend/widgets/button.dart';
import 'package:carvice_frontend/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool response = false;
  String text = "";

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
      response = usernameController.text.isNotEmpty && passwordController.text.isNotEmpty;
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
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/transparent_logo.png',
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.6,
                  fit: BoxFit.contain,
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
              const Text(
                'Please Login To Your Account',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFiled(
                  controller: usernameController,
                  hintText: "username",
                  textInputType: TextInputType.name,
                  obscureText: false),
              const SizedBox(height: 10),
              CustomTextFiled(
                  controller: passwordController,
                  hintText: "password",
                  textInputType: TextInputType.text,
                  obscureText: true),
              const SizedBox(height: 20),
              CustomButton(
                btnText: "Sign In",
                onTap: () async {
                  response = await Authenticator().authenticate({
                    "username": usernameController.text,
                    "password": passwordController.text
                  });
                  if (response) {
                    setState(() {
                      text = "Logged in";
                    });
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
                isDisabled:  !response,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Forget your password?"),
                  InkWell(
                    onTap: () {
                      print("reset");
                    },
                    child: const Text(" Reset Password"),
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
              const Text("Don't have an account?"),
              InkWell(
                onTap: () {
                  Get.offAllNamed(Routers.getSignupPageRoute());
                },
                child: const Text(" Sign Up"),
              ),
            ],
          )),
    );
  }
}
