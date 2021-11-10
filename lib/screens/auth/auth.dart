import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tricylia/screens/auth/username.dart';

import '../../widgets/styles/colors.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isAuth = false;
  final _usersRef = FirebaseFirestore.instance.collection('users');
  final DateTime _timestamp = DateTime.now();

  handleGoogleSign(GoogleSignInAccount account) {
    if (account != null) {
      createUserInFirestore();
      setState(() {
        _isAuth = true;
      });
    } else {
      setState(() {
        _isAuth = false;
      });
    }
  }

  createUserInFirestore() async {
    //Check if user exist in database using their id
    final GoogleSignInAccount user = googleSignIn.currentUser;
    final DocumentSnapshot doc = await _usersRef.doc(user.id).get();

    //if user doesn't exist, take them to registeration page
    if (!doc.exists) {
      final userName = await Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext contex) => UsernNamePage()));
      //get username from registeration and add them to users collection

      _usersRef.doc(user.id).set({
        "id": user.id,
        "username": userName,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timeStamp": _timestamp,
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // signed user in
    // googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
    //   handleGoogleSign(account);
    // }, onError: (err) {
    //   print('Error signing in: $err');
    // });

    // //reauthenticate user when app is opened
    // googleSignIn.signInSilently(suppressErrors: false).then((account) {
    //   handleGoogleSign(account);
    // }).catchError((err) {
    //   print('Error signing in: $err');
    // });
  }

  _signUp() {
    googleSignIn.signIn();
    // googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
    //   handleGoogleSign(account);
    // }, onError: (err) {
    //   print('Error signing in: $err');
    // });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Image.asset("assets/images/bg.png"),
                decoration: BoxDecoration(),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              height: 250.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: _theme.primaryColor,
                          ),
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/login');
                          },
                        ),
                      ),
                      SizedBox(width: 40.0),
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: facebookColor),
                          child: Text(
                            "REGISTER",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/register');
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: dbasicGreyColor,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Or connect with social",
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: dbasicGreyColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: facebookColor,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.facebookSquare,
                          color: Colors.white,
                        ),
                        Expanded(
                          child: Text(
                            "Login with Facebook",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _signUp,
                    child: Container(
                      margin: EdgeInsets.only(top: 15.0),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      height: 45.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: _theme.primaryColor),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.google,
                            color: _theme.primaryColor,
                          ),
                          Expanded(
                            child: Text(
                              "Login with Google",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _theme.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
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
    );
  }
}
