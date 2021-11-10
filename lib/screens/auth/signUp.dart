import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../widgets/styles/colors.dart';
import '../../widgets/custom_text_form_field.dart';

import '../../providers/auth.dart';

import '../../models/http_exception.dart';

import '../../widgets/progressDialog.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/register';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Timer timer;
  User user;

  var _isLoading = false;

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Signining In , please wait....",
          );
        });

    final User firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error:" + errMsg.toString(), context);
    }))
        .user;
    await _firebaseAuth.currentUser.sendEmailVerification();

    if (firebaseUser != null) //user has been created
    {
      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      usersRef.child(firebaseUser.uid).set(userDataMap);

      // await firebaseUser.sendEmailVerification();

      // if(user.emailVerified){
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      //
      displayToastMessage(
          "Welcome to KalyDrive. Book ride as you like", context);
    } else {
      Navigator.pop(context);
      //if error display messages
      displayToastMessage("UserAccount hasn't been Created", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/login');
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Log In",
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
                  "Sign Up",
                  style: _theme.textTheme.headline6.merge(
                    TextStyle(fontSize: 30.0),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              _signupForm(),
              SizedBox(
                height: 30.0,
              ),
              if (_isLoading)
                Center(child: CircularProgressIndicator())
              else
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 30.0),
                  height: 45.0,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: _theme.primaryColor,
                    ),
                    onPressed: () async {
                      if (nameTextEditingController.text.length < 4) {
                        displayToastMessage(
                            "Username Must be atleast 4 characters", context);
                      } else if (!emailTextEditingController.text
                          .contains("@")) {
                        displayToastMessage("Email is not Valid ", context);
                      } else if ((phoneTextEditingController.text.length < 9)) {
                        displayToastMessage("Invalid Phone number  ", context);
                      } else if (passwordTextEditingController.text.length <
                          6) {
                        displayToastMessage(
                            "Password must be 6 characters long", context);
                      } else {
                        registerNewUser(context);
                      }
                    },
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signupForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          CustomTextFormField(
            onSavedFunction: (val) => nameTextEditingController = val,
            controller: nameTextEditingController,
            hintText: "Username",
            keyboardType: TextInputType.name,
          ),
          SizedBox(
            height: 20.0,
          ),
          CustomTextFormField(
            controller: emailTextEditingController,
            hintText: "Email",
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: 20.0,
          ),
          CustomTextFormField(
            controller: phoneTextEditingController,
            hintText: "Phone number",
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 20.0,
          ),
          CustomTextFormField(
            controller: passwordTextEditingController,
            hintText: "Password",
            obscureText: true,
          ),
          SizedBox(
            height: 25.0,
          ),
          Text(
            "By clicking \"Sign Up\" you agree to our terms and conditions as well as our pricacy policy",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: dbasicDarkColor),
          )
        ],
      ),
    );
  }
}
