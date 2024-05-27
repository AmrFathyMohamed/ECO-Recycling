import 'package:flutter/material.dart';
import '../constants/Theme.dart';

class CardShopping extends StatelessWidget {
  const CardShopping(
      {super.key,
      this.body = "Placeholder Title",
      this.stock = true,
      this.price = "332",
      this.img = "https://via.placeholder.com/200",
      required this.deleteOnPress});

  final String body;
  final bool stock;
  final String price;
  final String img;
  final Function deleteOnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      // margin: EdgeInsets.only(top: 64),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ArgonColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 65,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image.network(img))),
                  FlatButton(
                    textColor: ArgonColors.white,
                    color: ArgonColors.initial,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 12, bottom: 12),
                      child: Dropdown(),
                    ),
                  ),
                ]),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(body,
                        style: const TextStyle(
                            color: ArgonColors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w400)),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 1.0),
                            child: Text(
                                stock == true ? 'In Stock' : 'Not In Stock',
                                style: TextStyle(
                                    color: stock == true
                                        ? ArgonColors.success
                                        : ArgonColors.error,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text("\$$price",
                                style: const TextStyle(
                                    color: ArgonColors.primary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                          textColor: ArgonColors.white,
                          color: ArgonColors.initial,
                          onPressed: () {
                            deleteOnPress();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 5.0, right: 5.0, top: 12, bottom: 12),
                              child: Text("DELETE",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.0))),
                        ),
                        FlatButton(
                          textColor: ArgonColors.white,
                          color: ArgonColors.initial,
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 5.0, right: 5.0, top: 12, bottom: 12),
                              child: Text("SAVE FOR LATER",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11.0))),
                        )
                      ],
                    )
                  ]),
            ),
          )
        ]),
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
      height: 14.0,
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
            onChanged: (newValue) => {
              setState(() {
                dropdownValue = newValue!;
              })
            },
            items: <String>['1', '2', '3', '4']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: const TextStyle(
                        color: ArgonColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0)),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
