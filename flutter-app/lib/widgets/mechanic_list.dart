import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';
import '../utils/main.colors.dart';

class CustomMechanicList extends StatelessWidget {
  final List<MyMechanicItem> list;

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
        return  GestureDetector(
          onTap: () {
            Get.toNamed(Routers.getMechanicProfileInClientRoute());
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
                          child: Image.asset(
                            list[index].imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            title: Text(
              list[index].name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Row(
              children: [
                RatingBarIndicator(
                  rating: list[index].rate,
                  itemBuilder: (context, index) =>  Icon(
                    Icons.star,
                    color: MainColors.mainColor,
                  ),
                  itemCount: 5,
                  itemSize: 16.0,
                  direction: Axis.horizontal,
                ),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
               print("Request btn pressed");
              },
              style: ElevatedButton.styleFrom(
                primary: MainColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Request'),
            ),
          ),
        );
      },
    );
  }
}

class MyMechanicItem {
  final String name;
  final String imagePath;
  final double rate;

  MyMechanicItem({
    required this.name,
    required this.imagePath,
    required this.rate,
  });
}