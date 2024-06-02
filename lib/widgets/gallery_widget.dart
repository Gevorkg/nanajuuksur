import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class ImageSwiper extends StatelessWidget {
  final List<String> imgList = [
    'images/carousel_nana0.png',
    'images/carousel_nana1.png',
    'images/carousel_nana2.png',
    'images/carousel_nana3.png',
    'images/carousel_nana4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(height: 200, 
      width: 500,
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 2, ),
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
            },
            clipBehavior: Clip.hardEdge,
          ),
          items: imgList.map((item) => Container(
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
              child: Image.asset(item, fit: BoxFit.cover, width: double.infinity,),
            ),
          )).toList(),
        ),
      );
  }
}