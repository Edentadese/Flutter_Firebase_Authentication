import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/login.dart';

class SplashScreeen extends StatefulWidget {
  final Widget child;
  const SplashScreeen({super.key, required this.child});

  @override
  State<SplashScreeen> createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Welcome"),
      ),
    );
  }
}
