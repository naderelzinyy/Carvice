import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_summary/rating_summary.dart';

import '../../../widgets/app_navigation.dart';
import '../../../widgets/button.dart';
import '../../../widgets/feedbacks_list.dart';

class MechanicProfile extends StatelessWidget {
  const MechanicProfile({Key? key});

  @override
  Widget build(BuildContext context) {
    final List<FeedbackItem> mechanicList = [
      FeedbackItem(
        name: 'SARA Doe',
        rate: 4.5,
        feedbackText: 'Great service! Great service! Great service! Great service! Great service! Great service! Great service! Great service! Great service!',
        feedbackDate: '2023-06-01',
      ),
      FeedbackItem(
        name: 'Jane Smith',
        rate: 3.8,
        feedbackText: 'Could be better.',
        feedbackDate: '2023-06-02',
      ),
      FeedbackItem(
        name: 'Nader Smith',
        rate: 3.8,
        feedbackText: 'Could be better!!!!!!!!!!!!!!!!!.',
        feedbackDate: '2023-06-02',
      ),
      FeedbackItem(
        name: 'Maryam Smith',
        rate: 1.8,
        feedbackText: 'bad.',
        feedbackDate: '2023-06-02',
      ),
      // Add more items as needed
    ];

    return Scaffold(
      appBar: AppNavigation(
        title: 'mechanic_profile'.tr,
        automaticallyCallBack: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/person.jpeg'),
                    radius: 50,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Mechanic Name',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: CustomButton(
                btnText: 'Make a request',
                onTap: () {
                  print("hi");
                },
              ),
            ),
            const SizedBox(height: 50),
            const Align(
              alignment: Alignment.center,
              child: RatingSummary(
                counter: 13,
                average: 3.846,
                showAverage: true,
                counterFiveStars: 5,
                counterFourStars: 4,
                counterThreeStars: 2,
                counterTwoStars: 1,
                counterOneStars: 1,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Expanded(
              child: CustomMechanicList(list: mechanicList),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Made with ♥ by Carvice team",
            ),
          ],
        ),
      ),
    );
  }
}
