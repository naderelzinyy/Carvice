import 'package:flutter/material.dart';
import 'package:carvice_frontend/utils/main.colors.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onTap;
  const CustomButton({Key? key, required this.btnText, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
            color: MainColors.mainColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow:  [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10
              )

            ]
        ),
        child:  Text(
          btnText,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}
