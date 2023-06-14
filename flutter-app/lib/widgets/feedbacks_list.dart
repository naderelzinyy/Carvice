import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../utils/main.colors.dart';

class CustomMechanicList extends StatelessWidget {
  final List<FeedbackItem> list;

  const CustomMechanicList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.grey[300],
          height: 1,
          thickness: 1,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            // Handle item tap here
          },
          child: ListTile(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
            leading: SizedBox(
              height: 90,
              width: 60,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: SizedBox(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Text(
                            list[index].name.substring(0, 1), // Display only the first character of the name
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            title: Text(
              list[index].name.replaceAll(RegExp(r'.'),
                  '*'), // Replace all characters in the name with stars
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: list[index].rate,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: MainColors.mainColor,
                      ),
                      itemCount: 5,
                      itemSize: 16.0,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
                Text(
                  list[index].feedbackText, // Display the user feedback text
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            trailing: Text(
              list[index].feedbackDate, // Display the date of the feedback
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}

class FeedbackItem {
  final String name;
  final double rate;
  final String feedbackText;
  final String feedbackDate;

  FeedbackItem({
    required this.name,
    required this.rate,
    required this.feedbackText,
    required this.feedbackDate,
  });
}
