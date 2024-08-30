import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/app/splash_screen/splash_screen.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/login.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAwiN6Lp0kmSfrXcJBCQL5C5HbpypAkOMM",
      projectId: "web-app-7664f",
      messagingSenderId: "63797330302",
      appId: "1:63797330302:web:0835d5246a42dafd0eb32f",
    ),
  );

  runApp(const MyApp()); // Start the app without a username initially
}

class MyApp extends StatelessWidget {
  final String? userName;

  const MyApp({super.key, this.userName});

  static bool isStreamVideoInitialized = false;  // Flag to track initialization

  @override
  Widget build(BuildContext context) {
    // Initialize StreamVideo only if it hasn't been initialized yet
    if (!isStreamVideoInitialized && userName != null && userName!.isNotEmpty) {
      StreamVideo(
        'mmhfdzb5evj2',
        user: User.regular(
          userId: 'Exar_Kun',
          role: 'admin',
          name: userName!,
        ),
        userToken:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiRXhhcl9LdW4iLCJpc3MiOiJodHRwczovL3Byb250by5nZXRzdHJlYW0uaW8iLCJzdWIiOiJ1c2VyL0V4YXJfS3VuIiwiaWF0IjoxNzI1MDM3ODk0LCJleHAiOjE3MjU2NDI2OTl9.2uvu5CdHZrH98NpzRylexn27u3IEAsWjgv2ak3pCkdE',
      );
      isStreamVideoInitialized = true;  // Set the flag to true after initialization
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video call app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Display()
      // SplashScreeen(
      //   child: LoginPage(),
      // ),
    );
  }
}
