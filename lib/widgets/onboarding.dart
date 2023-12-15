import 'package:flutter/material.dart';

class OnBoardingWidgets extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subtitle;

  const OnBoardingWidgets({
    this.image,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight,
      padding: EdgeInsets.only(top: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/${image}"),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "${title}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "${subtitle}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
