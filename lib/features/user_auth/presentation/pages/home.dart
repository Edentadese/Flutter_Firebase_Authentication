import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/login.dart';
import 'package:flutter_application_1/global/common/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("HomePage"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome home"),
              // GestureDetector(
              //   onTap: () {
              //     // _createData(UserModel(
              //     //   username: "Henry",
              //     //   age: 21,
              //     //   adress: "London",
              //     // ));
              //   },
              //   child: Container(
              //     height: 45,
              //     width: 100,
              //     decoration: BoxDecoration(
              //         color: Colors.blue,
              //         borderRadius: BorderRadius.circular(10)),
              //     child: Center(
              //       child: Text(
              //         "Create Data",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 18),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 10),
              // StreamBuilder<List<UserModel>>(
              //   stream: _readData(),
              //   builder: (context, snapshot) {
              //     if(snapshot.connectionState == ConnectionState.waiting){
              //       return Center(child: CircularProgressIndicator(),);
              //     } if(snapshot.data!.isEmpty){
              //       return Center(child:Text("No Data Yet"));
              //     }
              //     final users = snapshot.data;
              //     return Padding(padding: EdgeInsets.all(8),
              //     child: Column(
              //       children: users!.map((user) {
              //         return ListTile(
              //           leading: GestureDetector(
              //             onTap: (){
              //               _deleteData(user.id!);
              //             },
              //             child: Icon(Icons.delete),
              //           ),
              //           trailing: GestureDetector(
              //             onTap: (){
              //               _updateData(
              //                 UserModel(
              //                   id: user.id,
              //                   username: "John Wick",
              //                   adress: "Pakistan",)
              //               );
              //             },
              //             child: Icon(Icons.update),
              //           ),
              //           title: Text(user.username!),
              //           subtitle: Text(user.adress!),
              //         );
              //       }).toList()
              //     ),);
              //   }
              // ),

              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false);
                  showToast(message: "Successfully signed out");
                },
                child: Container(
                  height: 45,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Sign out",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}