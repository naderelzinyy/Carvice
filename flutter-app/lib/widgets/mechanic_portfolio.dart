import '../../../widgets/button.dart';
import '../../../widgets/feedbacks_list.dart';
import 'package:flutter/material.dart';
import 'package:rating_summary/rating_summary.dart';

class MechanicPortfolio extends StatefulWidget {
  final bool isClient;

  MechanicPortfolio({super.key, required this.isClient});

  @override
  _MechanicPortfolioState createState() => _MechanicPortfolioState();
}

class _MechanicPortfolioState extends State<MechanicPortfolio> {
  late double space = widget.isClient ? 20 : 30;
  final List<FeedbackItem> feedbackList = [
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
        if (widget.isClient)  // Conditionally render the button if isClient is true
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
          child: CustomMechanicList(list: feedbackList),
        ),
      ],
    );
  }
}
