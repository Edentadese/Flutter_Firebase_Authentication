import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/login.dart';

class SplashScreeen extends StatefulWidget {
  final Widget child;
  const SplashScreeen({super.key, required this.child});

  @override
  State<SplashScreeen> createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration(seconds: 10), () {
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) => LoginPage()),
  //         (route) => false);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Column(
          mainAxisSize: MainAxisSize.min, // Center the content vertically
          children: [
            SizedBox(height: 40,),
            Text(
              "Welccome to ...",
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,fontStyle: FontStyle.italic), // Adjust the text size as needed
            ),
            Text(
              "Video conferencing web app",
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,fontStyle: FontStyle.italic), // Adjust the text size as needed
            ),
            Image(
              image: AssetImage('assets/splash.png'),
              width: 500, // Set your desired width
              height: 500, // Set your desired height
            ),
            Padding(
              padding: const EdgeInsets.only(left:38.0,right: 38),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                              (route) => false,
                        );
                },
               child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 145, 106, 154),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child:  Text(
                        "Get started",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ),
            )
            
            // SizedBox(height: 20), // Spacing between the image and text
            
          ],
        
      ),
    );
  }
}
