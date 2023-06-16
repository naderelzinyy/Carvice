import 'package:flutter/material.dart';

class CustomFooterWidget extends StatelessWidget {
  const CustomFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Made with ♥ by Carvice team",
          ),
        ],
      ),
    );
  }
}
