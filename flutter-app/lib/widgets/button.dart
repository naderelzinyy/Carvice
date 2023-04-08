import 'package:flutter/material.dart';
import 'package:carvice_frontend/utils/main.colors.dart';
class CustomButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onTap;
  final bool isDisabled; // new parameter
  const CustomButton({Key? key, required this.btnText, required this.onTap, this.isDisabled = false,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isDisabled, // disable the button if isDisabled is true
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1.0, // reduce the opacity if isDisabled is true
        child: InkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            height: 55,
            decoration: BoxDecoration(
              color: MainColors.mainColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
              ],
            ),
            child: Text(
              btnText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
