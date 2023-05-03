import 'package:carvice_frontend/widgets/app_navigation.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavigation(title: "About Us", automaticallyCallBack: true,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/images/transparent_logo.png",
                height: 200,
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Our Story',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Carvice is a mobile application that was developed in response to the growing demand for on-demand car repair services. We saw an opportunity to streamline the process of getting a car fixed by connecting clients with mechanics through a mobile app. We conducted extensive research and used cutting-edge technology to develop a platform that is easy to use, reliable, and efficient. Our goal is to make car repair services accessible to everyone and provide mechanics with an additional source of income.",
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Our Mission',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Our mission at Carvice is to provide a convenient and efficient platform for clients to connect with mechanics and get their cars fixed. We aim to simplify the process of getting a car repaired by providing a user-friendly mobile application that connects clients with reliable and experienced mechanics. We strive to improve the car repair industry and provide value to clients and mechanics alike."
                      ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Our Vision',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Our vision is to revolutionize the car repair industry by making it more accessible, efficient, and transparent. We aim to expand our services globally and become the go-to platform for on-demand car repair services. We envision a future where car owners can easily connect with mechanics through our mobile app and get their cars fixed quickly and conveniently. We also aim to provide mechanics with a steady stream of work and opportunities for growth and development."  ),
                  ],
                ),
              ),
            ),
          ],

        ),
      ),
      bottomNavigationBar: Container(
          height: 80,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: const [
              Text(
                "Made with ♥ by Carvice team",
              ),
            ],
          )
      ),
    );
  }}