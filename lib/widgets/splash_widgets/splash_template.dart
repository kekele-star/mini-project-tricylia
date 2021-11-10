import 'package:flutter/material.dart';

class SplashTemplate extends StatelessWidget {
  final String title;
  final String subtitle;
  final Image image;

  SplashTemplate({
    @required this.title,
    @required this.subtitle,
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: image,
            ),
          ),
          Container(
            height: 180.0,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title),
                      SizedBox(height: 10.0),
                      Text(subtitle),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
