import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'hospital_home_screen.dart';
import 'user_home_screen.dart';
import 'profile_screen.dart';
import 'manage_stock.dart';
import 'manage_donor.dart';
import 'find_donor.dart';
import 'donor_scheduling.dart';
import 'request_blood.dart';
import 'login_screen.dart';
import 'register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloodConnect',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headlineSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            color: Colors.grey[600],
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            textStyle: TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      initialRoute: '/login', // ✅ Start from login page

      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/': (context) => HomeScreen(),
        '/hospitalHome': (context) => HospitalHomeScreen(),
        '/userHome': (context) => UserHomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/manageStock': (context) => ManageStockScreen(),
        '/manageDonor': (context) => ManageDonorScreen(),
        '/findDonor': (context) => FindDonorScreen(),
        '/donorScheduling': (context) => DonorSchedulingScreen(),
        '/requestBlood': (context) => RequestBloodScreen(),
      },
    );
  }
}
