import 'package:flutter/material.dart';
import 'package:carvice_frontend/utils/main.colors.dart';

import 'button.dart';

class CustomProfile extends StatelessWidget {
  final String image;
  final String title;
  final String email;
  final VoidCallback onTap;
  const CustomProfile({
    Key? key,
    required this.image,
    required this.title,
    required this.email,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Stack(
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
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            email,
            style:  TextStyle(
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            btnText: "Edit Profile",
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
