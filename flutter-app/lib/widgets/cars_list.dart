import 'package:carvice_frontend/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/routes.dart';

class CustomItemList extends StatelessWidget {
  final List<MyListItem> list;

  const CustomItemList({Key? key, required this.list}) : super(key: key);

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
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
            alignment: AlignmentDirectional.centerEnd,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) async {
            // Remove the item from the data source.
            if (await AccountManager()
                .deleteCar({"car_id": list[index].carID})) {
              list.removeAt(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('itemDeleted'.tr),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
            // Show a snackbar to notify the user that the item has been removed.
          },
          child: GestureDetector(
            onTap: () {
              String carId = list[index].carID;
              Get.toNamed(Routers.getEditCarPageRoute(carId));
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
                                    'assets/images/car_avatar.jpeg',
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
              trailing: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyListItem {
  final String name;
  final String carID;

  MyListItem({required this.name, required this.carID});
}
