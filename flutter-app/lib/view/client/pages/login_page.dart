import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carvice_frontend/widgets/text_field.dart';
import 'package:carvice_frontend/widgets/button.dart';
import 'package:carvice_frontend/view/client/pages/signup_page.dart';


class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


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
                    const Text(
                    'Please Login To Your Account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 15),
                   CustomTextFiled(controller: usernameController,
                     hintText: "username", textInputType: TextInputType.name,
                       obscureText: false),
                  const SizedBox(height: 10),
                  CustomTextFiled(controller: passwordController,
                      hintText: "password", textInputType: TextInputType.text,
                      obscureText: true),
                  const SizedBox(height: 20),
                   CustomButton(btnText: "Sign In",
                    onTap: () {
                      print('Login button tapped');
                      // Add your custom logic here
                    }),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  [
                      const Text(
                          "Forget your password?"
                      ),
                      InkWell(
                        onTap: (){
                          print("reset");
                        },
                        child: const Text(
                            " Reset Password"
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Text(
                  "Don't have an account?"
              ),
              InkWell( onTap: (){
                Get.to(() => SignUp(), transition: Transition.fade,
                    duration: const Duration(seconds: 1));
              },

                child: const Text(
                    " Sign Up"

                ),
              )
            ],
          )
      ),
    );
  }
}
