import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_summary/rating_summary.dart';

import '../../../widgets/button.dart';
import '../../../widgets/feedbacks_list.dart';
import '../services/authentication.dart';

class MechanicPortfolio extends StatefulWidget {
  final bool isClient;
  final String? mechanicID;

  MechanicPortfolio({super.key, required this.isClient, this.mechanicID});

  @override
  _MechanicPortfolioState createState() => _MechanicPortfolioState();
}

class _MechanicPortfolioState extends State<MechanicPortfolio> {
  late double space = widget.isClient ? 20 : 30;
  late List<FeedbackItem> feedbackList = [];
  final AccountManager _accountManager = AccountManager();

  void getReviewsList() async {
    List<dynamic> reviews =
        await _accountManager.getReviews({"mechanic_id": widget.mechanicID});
    setState(() {
      feedbackList = reviews
          .map(
            (item) => FeedbackItem(
                name: item["client_name"],
                rate: double.parse(item["rate"]),
                feedbackText: item["comment"],
                feedbackDate: item["date"]),
          )
          .toList();
    });
  }
  // FeedbackItem(
  // name: 'Maryam Smith',
  // rate: 1.8,
  // feedbackText: 'bad.',
  // feedbackDate: '2023-06-02',
  // ),

  @override
  void initState() {
    super.initState();
    getReviewsList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: space),
        const Row(
          children: [
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(15.0),
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
        if (widget
            .isClient) // Conditionally render the button if isClient is true
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: CustomButton(
              btnText: 'make_request'.tr,
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
          child: CustomMechanicList(list: feedbackList),
        ),
      ],
    );
  }
}
