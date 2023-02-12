import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idental/layout/home_screen.dart';
import 'package:idental/screens/appointment_screen.dart';
import 'package:idental/screens/appoit_screen.dart';
import 'package:idental/upload.dart';
import './screens/getting_started_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: DoctorDetailPage(),
      home: GettingStartedScreen(),
    );
  }
}
