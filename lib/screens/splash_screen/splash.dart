import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/splash.dart';
import '../../widgets/splash_widgets/splash_template.dart';
import '../../widgets/splash_widgets/splash_stepper.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash';

  final PageController _pageViewController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final SplashProvider _splashProvider =
        Provider.of<SplashProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  controller: _pageViewController,
                  onPageChanged: (int index) {
                    _splashProvider.onPageChange(index);
                  },
                  children: <Widget>[
                    SplashTemplate(
                      title: "Pay with your mobile",
                      subtitle:
                          "I know this is crazy, buy i tried something fresh, I hope you love it.",
                      image: Image.asset("assets/images/walkthrough1.png"),
                    ),
                    SplashTemplate(
                      title: "Get bonuses on each ride",
                      subtitle:
                          "I know this is crazy, buy i tried something fresh, I hope you love it.",
                      image: Image.asset("assets/images/walkthrough2.png"),
                    ),
                    SplashTemplate(
                      title: "Invite friends and get paid.",
                      subtitle:
                          "I know this is crazy, buy i tried something fresh, I hope you love it.",
                      image: Image.asset("assets/images/walkthrough3.png"),
                    )
                  ],
                ),
              ),
              _buildPageControl(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageControl(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SplashStepper(controller: _pageViewController),
          ),
          ClipOval(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: IconButton(
                icon: Icon(
                  Icons.trending_flat,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (_pageViewController.page >= 2) {
                    Navigator.of(context).pushReplacementNamed('/auth');
                    return;
                  }
                  _pageViewController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                padding: EdgeInsets.all(13.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
