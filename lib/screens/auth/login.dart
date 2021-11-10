import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tricylia/models/http_exception.dart';
import 'package:tricylia/screens/home/home.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../widgets/styles/colors.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../providers/auth.dart';

import '../../widgets/progressDialog.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _isLoading = false;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Authenticating , please wait....",
          );
        });

    final User firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error:" + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null &&
        firebaseUser.emailVerified) //user has been created
    {
      //saving user data to database
      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
          displayToastMessage("You have been logged in", context);
        } else {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage("Invalid Email or password", context);
        }
      });
    } else {
      Navigator.pop(context);
      //if error display messages
      displayToastMessage("Something went wrong, can't Login", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/register');
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: _theme.primaryColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Log In",
                  style: _theme.textTheme.headline6.merge(
                    TextStyle(fontSize: 30.0),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              _loginForm(context),
              SizedBox(
                height: 30.0,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Or connect using social account",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
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
                      margin: EdgeInsets.only(
                        top: 10.0,
                      ),
                      height: 45.0,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: _theme.scaffoldBackgroundColor),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.google,
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

  Widget _loginForm(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomTextFormField(
            hintText: "Email",
            controller: emailTextEditingController,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: 20.0,
          ),
          CustomTextFormField(
            hintText: "Password",
            obscureText: true,
            controller: passwordTextEditingController,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Forgot password?",
            style: TextStyle(
                color: _theme.primaryColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 25.0,
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            )
          else
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45.0,
              child: TextButton(
                style:
                    TextButton.styleFrom(backgroundColor: _theme.primaryColor),
                onPressed: () {
                  if (!emailTextEditingController.text.contains("@")) {
                    displayToastMessage("Email is not Valid ", context);
                  } else if (passwordTextEditingController.text.isEmpty) {
                    displayToastMessage("Password must be Provided", context);
                  } else {
                    loginAndAuthenticateUser(context);
                  }
                },
                child: Text(
                  "LOG IN",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            )
        ],
      ),
    );
  }
}



//   Future<void> _submit() async {
//   if (!_formKey.currentState.validate()) {
//     //Invalid
//     return;
//   }
//   _formKey.currentState.save();
//   setState(() {
//     _isLoading = true;
//   });
//   try {
//     await Provider.of<AuthProvider>(context, listen: false)
//         .login(_authData['email'], _authData['password']);
//     Navigator.of(context).pushReplacementNamed('/home');
//   } on HttpException catch (error) {
//     var errorMessage = 'Login failed. Please try again later';
//     if (error.toString().contains('EMAIL_EXISTS')) {
//       errorMessage = 'The email already exist';
//     } else if (error.toString().contains('INVALID_EMAIL')) {
//       errorMessage = 'The email is invalid';
//     } else if (error.toString().contains('WEAK_PASSWORD')) {
//       errorMessage = 'This password is too weak';
//     } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
//       errorMessage = 'This email address does not exist';
//     } else if (error.toString().contains('INVALID_PASSWORD')) {
//       errorMessage = 'That is an invalid password';
//     }

//     _showErrorDiaglog(errorMessage);
//   } catch (error) {
//     const errorMessage = 'Could not log you in. Please try again later';
//     _showErrorDiaglog(errorMessage);
//   }
//   setState(() {
//     _isLoading = false;
//   });
//   return;
// }
