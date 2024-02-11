import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kokzaki_admin_panel/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:kokzaki_admin_panel/helper/firebase_helper.dart';
import 'package:kokzaki_admin_panel/screens/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   super.initState();
  //   getCollections();
  //   print('current user is ${FirebaseAuth.instance.currentUser!.uid}');
  // }

  // getCollections() async {
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('bankTransferRequest')
  //       .get();
  //   print('collection NAme ${snapshot.docs.first.data()}');
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kokozaki Admin Panel',
      theme: ThemeData(
        // useMaterial3: true,
        // primaryColor: primaryColor,
        // canvasColor: canvasColor,
        scaffoldBackgroundColor: Colors.white,
        // textTheme: const TextTheme(
        //   headlineSmall: TextStyle(
        //     color: Colors.white,
        //     fontSize: 46,
        //     fontWeight: FontWeight.w800,
        //   ),
        // ),
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginScreen()
          : Dashboard(),
    );
  }
}
