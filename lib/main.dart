import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../screens/drawer_screens/payment.dart';
import '../screens/drawer_screens/profile.dart';
import '../screens/drawer_screens/favorites.dart';
import '../../screens/drawer_screens/my_rides.dart';
import '../../screens/drawer_screens/promotions.dart';
import 'package:provider/provider.dart';

import '../screens/splash_screen/splash.dart';
import '../screens/auth/auth.dart';
import '../screens/auth/signUp.dart';
import '../screens/auth/login.dart';
import '../screens/home/home.dart';
import '../screens/searchScreen.dart';

import '../widgets/styles/theme_data.dart';

import '../providers/splash.dart';
import '../providers/auth.dart';
import '../providers/location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference usersRef =
    FirebaseDatabase.instance.reference().child("users");
DatabaseReference driversRef =
    FirebaseDatabase.instance.reference().child("drivers");
DatabaseReference newRequestsRef =
    FirebaseDatabase.instance.reference().child("Ride Requests");

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: SplashProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider.value(
          value: LocationProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeScheme.light(),
          // initialRoute: '/splash',
          // home: auth.isAuth ? HomeScreen() : AuthScreen(),
          home: HomeScreen(),
          routes: {
            '/splash': (BuildContext context) => SplashScreen(),
            '/auth': (BuildContext context) => AuthScreen(),
            '/register': (BuildContext context) => SignUp(),
            '/login': (BuildContext context) => LoginScreen(),
            '/home': (BuildContext context) => HomeScreen(),
            '/search': (BuildContext context) => SearchScreen(),
            '/promotions': (BuildContext context) => Promotions(),
            '/myRides': (BuildContext context) => MyRides(),
            '/payment': (BuildContext context) => Payment(),
            '/favorites': (BuildContext context) => Favorites(),
            '/profile': (BuildContext context) => Profile(),
          },
        ),
      ),
    );
  }
}
