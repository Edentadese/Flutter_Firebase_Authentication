import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/app/splash_screen/splash_screen.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/login.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

void main() async {

  
  WidgetsFlutterBinding.ensureInitialized();
  final client = StreamVideo(
    'mmhfdzb5evj2',
    user: User.regular(
      userId: 'Darth_Nihilus',
      role: 'admin',
      name: 'John Doe',
    ),
    userToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiRGFydGhfTmloaWx1cyIsImlzcyI6Imh0dHBzOi8vcHJvbnRvLmdldHN0cmVhbS5pbyIsInN1YiI6InVzZXIvRGFydGhfTmloaWx1cyIsImlhdCI6MTcyNDE1ODM0MywiZXhwIjoxNzI0NzYzMTQ4fQ.DtPFdqKgUQhTwJUjc1z67M-Mr57AQ-TKbjW8gGP7fwY',
  );
  await Firebase.initializeApp(
    options: FirebaseOptions(
       apiKey: "your api key",
        projectId: "your project id",
        messagingSenderId: "your messaging sender id",
        appId: "your app id",   
      ) 
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video call app',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: 
      SplashScreeen(child: LoginPage(),),
    );
  }
}

