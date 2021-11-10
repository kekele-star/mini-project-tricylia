import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tricylia/screens/splash_screen/custom_text_form_field.dart';

import '../../widgets/styles/colors.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.times),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Hello Kelvin !",
                    style: _theme.textTheme.headline6
                        .merge(TextStyle(fontSize: 26.0)),
                  ),
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: AssetImage('assets/images/kay.jpg'),
                  )
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              CustomTextFormField(
                hintText: "Name",
                value: "Kelvin Agyemang",
              ),
              SizedBox(
                height: 15.0,
              ),
              CustomTextFormField(
                hintText: "Email",
                value: "opokukelvin29@gmail.com",
                suffixIcon: Icon(
                  Icons.check_circle,
                  color: _theme.primaryColor,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              CustomTextFormField(
                hintText: "Phone Number",
                value: "543-685-739",
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "PREFERENCES",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                  color: Color(0xFF9CA4AA),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffFBFBFD),
                  border: Border.all(
                    color: Color(0xffD6D6D6),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "RECEIVE RECEIPT MAILS",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Switch(
                          value: true,
                          activeColor: _theme.primaryColor,
                          onChanged: (bool state) {},
                        )
                      ],
                    ),
                    Text(
                      "The switch is the widget used to achieve the popular.",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffFBFBFD),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "SOCIAL NETWORK",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        color: Color(0xFF9CA4AA),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 45.0,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: facebookColor),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.facebookSquare,
                              color: Colors.white,
                            ),
                            Expanded(
                              child: Text(
                                "Connect with Facebook",
                                textAlign: TextAlign.center,
                                style: _theme.textTheme.bodyText2.merge(
                                  TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: _theme.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(3.0)),
                      margin: EdgeInsets.only(top: 10.0),
                      height: 45.0,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: _theme.scaffoldBackgroundColor,
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.google,
                              size: 18.0,
                              color: _theme.primaryColor,
                            ),
                            Expanded(
                              child: Text(
                                "Connect with Google",
                                textAlign: TextAlign.center,
                                style: _theme.textTheme.bodyText2.merge(
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _theme.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
