// ignore_for_file: unused_field

import 'package:eco/helper/product.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../constants/Theme.dart';

class ProductCarousel extends StatefulWidget {
  final List<Product> imgArray;

  const ProductCarousel({
    super.key,
    required this.imgArray,
  });

  @override
  _ProductCarouselState createState() => _ProductCarouselState();
}

class _ProductCarouselState extends State<ProductCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: widget.imgArray
          .map((item) => Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.transparent,
                              blurRadius: 8,
                              spreadRadius: 0.3,
                              offset: Offset(0, 3))
                        ]),
                        child: AspectRatio(
                          aspectRatio: 2 / 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset(
                              item.image,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Column(
                        children: [
                          Text(item.price.toString(),
                              style: const TextStyle(
                                  fontSize: 16, color: ArgonColors.header)),
                          Text(item.name,
                              style: const TextStyle(
                                  fontSize: 32, color: ArgonColors.text)),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 8),
                            child: Text(
                              item.description,
                              style: const TextStyle(
                                  fontSize: 16, color: ArgonColors.muted),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
          .toList(),
      options: CarouselOptions(
          height: 500,
          autoPlay: false,
          enlargeCenterPage: false,
          aspectRatio: 4 / 4,
          enableInfiniteScroll: false,
          initialPage: 0,
          // viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          }),
    );
  }
}
