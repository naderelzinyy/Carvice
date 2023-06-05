import 'package:carvice_frontend/services/authentication.dart';
import 'package:carvice_frontend/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carvice_frontend/routes/routes.dart';

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
  final String roleEndpoint;

  const ProfileForm({
    Key? key,
    required this.image,
    required this.onTap,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.roleEndpoint,
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
  bool _isFormChanged = false;
  String _warningMessage = "";

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _userNameController = TextEditingController(text: widget.userName);
    _emailController = TextEditingController(text: widget.email);
    _phoneNumberController = TextEditingController(text: widget.phoneNumber);
  }

  bool _isFieldChanged(String currentValue, String previousValue) {
    return currentValue.isNotEmpty && currentValue != previousValue;
  }

  bool _isAnyFiledChanged() {
    return _isFieldChanged(_firstName, widget.firstName) ||
        _isFieldChanged(_lastName, widget.lastName) ||
        _isFieldChanged(_userName, widget.userName) ||
        _isFieldChanged(_email, widget.email) ||
        _isFieldChanged(_phoneNumber, widget.phoneNumber);
  }

  bool _isFirstNameValid(String firstName) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(firstName);
  }

  bool _isLastNameValid(String lastName) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(lastName);
  }

  bool _isPhoneNumberValid(String phoneNumber) {
    // Check if the phone number matches the Turkish phone number format
    // Example pattern: r'^\+?9[0-9]{10}$'
    return RegExp(r'^\+?9[0-9]{10}$').hasMatch(phoneNumber);
  }


  bool _isEmailValid(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(email);
  }


  void _showWarningMessage(String message) {
    setState(() {
      _warningMessage = message;
    });
  }

  Future<void> _showSuccessAlert() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success', style: TextStyle(color: Colors.green)),
          content: const Text('User information updated successfully.'),
          actions: <Widget>[
            CustomButton(
              btnText: 'OK',
              onTap: () {
                if (widget.roleEndpoint == "client"){
                  Get.offAllNamed(Routers.getUserProfileRoute());
                }
                else if  (widget.roleEndpoint == "mechanic"){
                  Get.offAllNamed(Routers.getMechanicUserProfileRoute());
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showFailureAlert() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Failed to Update',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text('Sorry, an error occurred while updating user information.'),
          actions: <Widget>[
            CustomButton(
              btnText: 'OK',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
              if (_warningMessage.isNotEmpty)
                Container(
                  width: double.infinity,
                  color: Colors.orangeAccent,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    _warningMessage,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              CustomTextFiled(
                controller: _firstNameController,
                hintText: 'firstName'.tr,
                textInputType: TextInputType.text,
                obscureText: false,
                onChanged: (value) {
                  setState(() {
                    _firstName = value;
                    _isFormChanged = _isAnyFiledChanged();
                    _warningMessage = "";
                  });
                },
              ),
              const SizedBox(height: 10),
              CustomTextFiled(
                controller: _lastNameController,
                hintText: 'lastName'.tr,
                textInputType: TextInputType.text,
                obscureText: false,
                onChanged: (value) {
                  setState(() {
                    _lastName = value;
                    _isFormChanged = _isAnyFiledChanged();
                    _warningMessage = "";
                  });
                },
              ),
              const SizedBox(height: 10),
              CustomTextFiled(
                controller: _userNameController,
                hintText: 'username'.tr,
                textInputType: TextInputType.text,
                obscureText: false,
                onChanged: (value) {
                  setState(() {
                    _userName = value;
                    _isFormChanged = _isAnyFiledChanged();
                    _warningMessage = "";
                  });
                },
              ),
              const SizedBox(height: 10),
              CustomTextFiled(
                controller: _emailController,
                hintText: 'email'.tr,
                textInputType: TextInputType.emailAddress,
                obscureText: false,
                onChanged: (value) {
                  setState(() {
                    _email = value;
                    _isFormChanged = _isAnyFiledChanged();
                    _warningMessage = "";
                  });
                },
              ),
              const SizedBox(height: 10),
              CustomTextFiled(
                controller: _phoneNumberController,
                hintText: 'phoneNumber'.tr,
                textInputType: TextInputType.phone,
                obscureText: false,
                onChanged: (value) {
                  setState(() {
                    _phoneNumber = value;
                    _isFormChanged = _isAnyFiledChanged();
                    _warningMessage = "";
                  });
                },
              ),
              const SizedBox(height: 50),
              CustomButton(
                btnText: 'update'.tr,
                isDisabled: !_isFormChanged, // disable the button if form is not changed
                onTap: () async {
                  if (_isFormChanged) {
                    if (!_isFirstNameValid(_firstName) && _isFieldChanged(_firstName, widget.firstName)) {
                      _showWarningMessage('Please enter a valid first name');
                      return;
                    }

                    if (!_isLastNameValid(_lastName) && _isFieldChanged(_lastName, widget.lastName)) {
                      _showWarningMessage('Please enter a valid last name');
                      return;
                    }

                    if (!_isPhoneNumberValid(_phoneNumber)&& _isFieldChanged(_phoneNumber, widget.phoneNumber)) {
                      _showWarningMessage('Please enter a valid phone number');
                      return;
                    }

                    if (!_isEmailValid(_email)&& _isFieldChanged(_email, widget.email)) {
                      _showWarningMessage('Please enter a valid email address');
                      return;
                    }

                    final updateData = {
                      "id": token!['id'].toString(),
                      "first_name": _isFieldChanged(_firstName, widget.firstName)
                          ? _firstName
                          : widget.firstName,
                      "last_name": _isFieldChanged(_lastName, widget.lastName)
                          ? _lastName
                          : widget.lastName,
                      "username": _isFieldChanged(_userName, widget.userName)
                          ? _userName
                          : widget.userName,
                      "phone_number": _isFieldChanged(_phoneNumber, widget.phoneNumber)
                          ? _phoneNumber
                          : widget.phoneNumber,
                      "email": _isFieldChanged(_email, widget.email)
                          ? _email
                          : widget.email,
                    };

                    if (await AccountManager().updateInfo(updateData) && _isFormChanged) {
                      setState(() {
                        _firstNameController.text = _isFieldChanged(_firstName, widget.firstName)
                            ? _firstName
                            : widget.firstName;
                        _lastNameController.text = _isFieldChanged(_lastName, widget.lastName)
                            ? _lastName
                            : widget.lastName;
                        _userNameController.text = _isFieldChanged(_userName, widget.userName)
                            ? _userName
                            : widget.userName;
                        _emailController.text = _isFieldChanged(_email, widget.email)
                            ? _email
                            : widget.email;
                        _phoneNumberController.text = _isFieldChanged(_phoneNumber, widget.phoneNumber)
                            ? _phoneNumber
                            : widget.phoneNumber;
                        _isFormChanged = false;
                      });

                      // Show success alert
                      await _showSuccessAlert();
                    } else {
                      // Show failure alert
                      await _showFailureAlert();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
