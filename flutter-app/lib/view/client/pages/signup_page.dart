import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carvice_frontend/widgets/text_field.dart';
import 'package:carvice_frontend/widgets/button.dart';
import 'package:carvice_frontend/view/client/pages/login_page.dart';


class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();


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
                  const SizedBox(height: 20),
                  const Text(
                    'Create New Account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomTextFiled(controller: fullNameController,
                      hintText: "full name", textInputType: TextInputType.name,
                      obscureText: false),
                  const SizedBox(height: 10),
                  CustomTextFiled(controller: usernameController,
                      hintText: "username", textInputType: TextInputType.name,
                      obscureText: false),
                  const SizedBox(height: 10),
                  CustomTextFiled(controller: emailController,
                      hintText: "email", textInputType: TextInputType.emailAddress,
                      obscureText: false),
                  const SizedBox(height: 10),
                  CustomTextFiled(controller: phoneController,
                      hintText: "phone number", textInputType: TextInputType.phone,
                      obscureText: false),
                  const SizedBox(height: 10),
                  CustomTextFiled(controller: passwordController,
                      hintText: "password", textInputType: TextInputType.text,
                      obscureText: true),
                  const SizedBox(height: 10),
                  CustomTextFiled(controller: confPasswordController,
                      hintText: "password conformation", textInputType: TextInputType.text,
                      obscureText: true),
                  const SizedBox(height: 25),
                    CustomButton(btnText: "Sign Up",
                       onTap: () {
            print('sign up button tapped');
            // Add your custom logic here
            },),
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
                  "Already have an account?"
              ),
              InkWell( onTap: (){
                Get.to(() => LoginPage(), transition: Transition.fade,
                    duration: const Duration(seconds: 1));
              },

                child: const Text(
                    " Sign In"
                ),
              )
            ],
          )
      ),
    );
  }
}
