import 'package:flutter/material.dart';
import 'package:tricylia/providers/location.dart';
import 'package:tricylia/screens/searchScreen.dart';
import 'package:provider/provider.dart';

import '../divider.dart';

class RideRequestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: AnimatedSize(
        // vsync: this,
        curve: Curves.bounceIn,
        duration: Duration(milliseconds: 160),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(15.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.red,
                blurRadius: 16.0,
                spreadRadius: 0.5,
                offset: Offset(0.7, 0.7),
              )
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [
                  // backgroundColor: Color(0xFFB6D7BE),
                  Color(0xFFB6D7BE),
                  Colors.red,

                  Colors.blue,
                ],
              ),
              borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
              // color: Colors.white,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6.0),
                  Text(
                    'he',
                    // "Hi ${uName}".toUpperCase(),
                    // "hi ${userCurrentInfo.name ?? "There"}",

                    style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: "Brand-Bold",
                        color: Colors.black,
                        letterSpacing: 3),
                  ),
                  Text(
                    "Where to ?",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Brand-Bold",
                        color: Colors.black),
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () async {
                      var res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(),
                        ),
                      );
                      if (res == "obtainDirection") {
                        // displayRideDetailsContainer();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Search Drop off",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Provider.of<LocationProvider>(context)
                                        .pickUpLocation !=
                                    null
                                ? Provider.of<LocationProvider>(context)
                                    .pickUpLocation
                                    .placeName
                                : "Add Home",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "Home Location",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  DividerWidget(),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.work,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add Work",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "Office Location",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
