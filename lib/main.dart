import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:users_app/screens/gMap_screen/gMap_screen.dart';
import 'package:users_app/screens/landing_screens/user_landing_screen.dart';
import 'package:users_app/screens/image_update/update_image.dart';
import 'package:users_app/screens/users_list/users_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:users_app/services/pushNotification/firebase_api.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'list-users',
      navigatorKey: navigatorKey,
      // home: GMapScreen(
      //   sourcePosition: LatLng(25.5941, 85.1376),
      // destinationPosition: LatLng(20.5941, 80.1376),),
      home: UserLandingScreen(),
      routes: {
        '/gMapScreen': (context) => GMapScreen(
      sourcePosition: LatLng(25.5941, 85.1376),
    destinationPosition: LatLng(20.5941, 80.1376),)
      },
    );
  }
}
