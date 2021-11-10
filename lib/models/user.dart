import 'package:flutter/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// class User {
//   final String firstName;
//   final String lastName;
//   final String userPassword;
//   final String userEmail;
//   final String phoneNumber;

//   User({
//     @required this.firstName,
//     @required this.lastName,
//     @required this.userPassword,
//     @required this.userEmail,
//     @required this.phoneNumber,
//   });
// }

class Users {
  String id;
  String email;
  String name;
  String phone;

  Users({this.id, this.email, this.name, this.phone});

  Users.fromSnapshot(DataSnapshot dataSnapshot) {
    id = dataSnapshot.key;
    email = dataSnapshot.value["email"];
    name = dataSnapshot.value["name"];
    phone = dataSnapshot.value["phone"];
  }
}
