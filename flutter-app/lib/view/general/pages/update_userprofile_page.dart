import 'package:flutter/material.dart';

import '../../../utils/main.colors.dart';
import '../../../widgets/app_navigation.dart';
import '../../../widgets/button.dart';
import '../../../widgets/text_field.dart';
class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final userNameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneNumberController = TextEditingController();

    return Scaffold(
      appBar: const AppNavigation(
        title: "Update Profile",
        automaticallyCallBack: true,
      ),
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
                          'assets/images/profile.png',
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
                            onPressed: () {
                              print("edit picture icon pressed");
                            },
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
                hintText: 'First Name',
                textInputType: TextInputType.text,
                obscureText: false,
              ),
              const SizedBox(height: 10),
              CustomTextFiled(
                controller: lastNameController,
                hintText: 'Last Name',
                textInputType: TextInputType.text,
                obscureText: false,
              ),
              const SizedBox(height: 10),
              CustomTextFiled(
                controller: userNameController,
                hintText: 'Username',
                textInputType: TextInputType.text,
                obscureText: false,
              ),
              const SizedBox(height: 10),
              CustomTextFiled(
                controller: emailController,
                hintText: 'Email',
                textInputType: TextInputType.emailAddress,
                obscureText: false,
              ),
              const SizedBox(height: 10),
              CustomTextFiled(
                controller: phoneNumberController,
                hintText: 'Phone Number',
                textInputType: TextInputType.phone,
                obscureText: false,
              ),
              const SizedBox(height: 20),
              CustomButton(
                btnText: 'Save Changes',
                onTap: () {
                  // TODO: Add save functionality here
                  print("save updates btn pressed");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
