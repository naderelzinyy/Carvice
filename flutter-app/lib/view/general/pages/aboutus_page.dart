import 'package:carvice_frontend/widgets/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppNavigation(title: 'aboutUs'.tr, automaticallyCallBack: true,),
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
                  children: [
                    Text(
                      'ourStory'.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'ourStoryContent'.tr
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
                  children: [
                    Text(
                      'ourMission'.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                     'ourMissionContent'.tr
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
                  children: [
                    Text(
                      'ourVision'.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text( 'ourVisionContent'.tr
                      ),
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
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                "Made with ♥ by Carvice team",
              ),
            ],
          )
      ),
    );
  }}