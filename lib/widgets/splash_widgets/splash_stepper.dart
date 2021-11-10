import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/splash.dart';

class SplashStepper extends StatelessWidget {
  final PageController controller;
  SplashStepper({@required this.controller});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        3,
        (int index) {
          return Consumer(
            builder:
                (BuildContext context, SplashProvider splash, Widget child) {
              return GestureDetector(
                onTap: () {
                  controller.animateToPage(index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  child: Container(
                    height: 5.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: index <= splash.currentPageValue
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: EdgeInsets.only(right: 5.0),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
