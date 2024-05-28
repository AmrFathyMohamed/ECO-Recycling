import 'package:flutter/material.dart';
import '../constants/Theme.dart';

class CardShopping extends StatelessWidget {
  const CardShopping({
    super.key,
    this.body = "Placeholder Title",
    this.stock = true,
    this.price = "332",
    this.img = "https://via.placeholder.com/200",
    this.deleteOnPress,
  });

  final String body;
  final bool stock;
  final String price;
  final String img;
  final Function()? deleteOnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ArgonColors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      image: DecorationImage(
                        image: NetworkImage(img),
                        fit: BoxFit.cover,
                      ),
                    ),
                    clipBehavior: Clip.hardEdge,
                  ),
                  const SizedBox(height: 8),
                  FlatButton(
                    textColor: ArgonColors.white,
                    color: ArgonColors.initial,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Dropdown(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      body,
                      style: const TextStyle(
                        color: ArgonColors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stock ? 'In Stock' : 'Not In Stock',
                          style: TextStyle(
                            color: stock ? ArgonColors.success : ArgonColors.error,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          '\$$price',
                          style: const TextStyle(
                            color: ArgonColors.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ActionButton(
                          label: "DELETE",
                          onPressed: deleteOnPress,
                          fontWeight: FontWeight.w600,
                        ),
                        ActionButton(
                          label: "SAVE FOR LATER",
                          onPressed: () {},
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final FontWeight fontWeight;

  const ActionButton({super.key, 
    required this.label,
    required this.onPressed,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: ArgonColors.white,
      color: ArgonColors.initial,
      onPressed: (){},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: fontWeight,
            fontSize: 11.0,
          ),
        ),
      ),
    );
  }
}

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String dropdownValue = '1';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.0,
      child: DropdownButtonHideUnderline(
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: ArgonColors.initial,
          ),
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: ArgonColors.white,
              ),
            ),
            iconSize: 20,
            elevation: 1,
            style: const TextStyle(color: ArgonColors.white),
            onChanged: (newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['1', '2', '3', '4'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    color: ArgonColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
