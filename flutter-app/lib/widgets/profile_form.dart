import 'package:flutter/material.dart';

import '../utils/main.colors.dart';
import 'button.dart';
import 'text_field.dart';

class ProfileForm extends StatelessWidget {
  final String image;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String phoneNumber;
  final VoidCallback onPressed;
  final VoidCallback onTap;

   ProfileForm({
    Key? key,
    required this.image,
    required this.onPressed,
    required this.onTap,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
  }) : super(key: key);

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 80, left: 35, right: 35),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          image,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.width * 0.8,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MainColors.mainColor,
                          ),
                          child: IconButton(
                            onPressed: onTap,
                            icon: const Icon(Icons.edit),
                            color: Colors.white,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              CustomTextFiled(
                controller: firstNameController,
                hintText: firstName,
                textInputType: TextInputType.text,
                obscureText: false,
              ),
              const SizedBox(height: 10),
              CustomTextFiled(
                controller: lastNameController,
                hintText: lastName,
                textInputType: TextInputType.text,
                obscureText: false,
              ),
              const SizedBox(height: 10),
              CustomTextFiled(
                controller: userNameController,
                hintText: userName,
                textInputType: TextInputType.text,
                obscureText: false,
              ),
              const SizedBox(height: 10),
              CustomTextFiled(
                controller: emailController,
                hintText: email,
                textInputType: TextInputType.emailAddress,
                obscureText: false,
              ),
              const SizedBox(height: 10),
              CustomTextFiled(
                controller: phoneNumberController,
                hintText: phoneNumber,
                textInputType: TextInputType.phone,
                obscureText: false,
              ),
              const SizedBox(height: 20),
              CustomButton(
                btnText: 'Save Changes',
                onTap: onPressed,
              )
            ],
          ),
        ),
      ),
    );
  }
}
