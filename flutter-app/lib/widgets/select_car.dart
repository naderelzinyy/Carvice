import 'package:flutter/material.dart';
import 'package:carvice_frontend/utils/main.colors.dart';

class CustomSelectCarList extends StatefulWidget {
  final List<SelectCar> list;
  final Function(SelectCar?) onCarSelected; // Define callback function

  const CustomSelectCarList({Key? key, required this.list, required this.onCarSelected})
      : super(key: key);

  @override
  _CustomSelectCarListState createState() => _CustomSelectCarListState();
}

class _CustomSelectCarListState extends State<CustomSelectCarList> {
  SelectCar? selectedItem;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 5, height: 10,); // Add spacing between items
      },
      itemCount: widget.list.length,
      itemBuilder: (BuildContext context, int index) {
        final item = widget.list[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedItem = item;
              widget.onCarSelected(selectedItem); // Invoke the callback function
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: selectedItem == item ? MainColors.mainColor : Colors.grey,
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 130,
                            height: 130,
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
                const SizedBox(height: 4),
                Text(
                  item.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedItem == item ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SelectCar {
  final String name;
  final String carID;

  SelectCar({required this.name, required this.carID});
}
