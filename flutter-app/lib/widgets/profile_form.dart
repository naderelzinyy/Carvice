import 'package:carvice_frontend/widgets/text_field.dart';
import 'package:flutter/material.dart';

import '../utils/main.colors.dart';
import 'button.dart';

class ProfileForm extends StatefulWidget {
  final String image;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String phoneNumber;
  final VoidCallback onTap;

  const ProfileForm({
    Key? key,
    required this.image,
    required this.onTap,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _userNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;

  String _firstName = "";
  String _lastName = "";
  String _userName = "";
  String _email = "";
  String _phoneNumber = "";

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _userNameController = TextEditingController(text: widget.userName);
    _emailController = TextEditingController(text: widget.email);
    _phoneNumberController = TextEditingController(text: widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
                top: 80,
                left: 35,
                right: 35
            ),
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
                          widget.image,
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
                        onPressed: widget.onTap,
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
              controller: _firstNameController,
              hintText: 'First Name',
              textInputType: TextInputType.text,
              obscureText: false,
              onChanged: (value) => _firstName = value,
              ),
              const SizedBox(height: 10),
                CustomTextFiled(
              controller: _lastNameController,
              hintText: 'Last Name',
              textInputType: TextInputType.text,
              obscureText: false,
              onChanged: (value) => _lastName = value,
              ),
              const SizedBox(height: 10),
                CustomTextFiled(
              controller: _userNameController,
              hintText: 'Username',
              textInputType: TextInputType.text,
              obscureText: false,
              onChanged: (value) => _userName = value,
              ),
                const SizedBox(height: 10),
                CustomTextFiled(
                  controller: _emailController,
                  hintText: 'Email Address',
                  textInputType: TextInputType.emailAddress,
                  obscureText: false,
                  onChanged: (value) => _email = value,
                ),
                const SizedBox(height: 10),
                CustomTextFiled(
                  controller: _phoneNumberController,
                  hintText: 'Phone Number',
                  textInputType: TextInputType.phone,
                  obscureText: false,
                  onChanged: (value) => _phoneNumber = value,
                ),
                const SizedBox(height: 50),
                CustomButton(
                  btnText: 'Update',
                  onTap: () {
                    // Save updated values and update the textfield hints
                    setState(() {
                      _firstNameController.text = _firstName;
                      _lastNameController.text = _lastName;
                      _userNameController.text = _userName;
                      _emailController.text = _email;
                      _phoneNumberController.text = _phoneNumber;
                    });
        },
      ),
    ],
    ),
        ),
        ),
    );
  }
}