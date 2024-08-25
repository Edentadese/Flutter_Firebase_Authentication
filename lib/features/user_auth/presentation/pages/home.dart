import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/join_meeting.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/login.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/new_meeting.dart';
import 'package:flutter_application_1/global/common/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  bool _isSideMenuOpen = false;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    setState(() {
      _currentUser = FirebaseAuth.instance.currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Side menu
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: 0,
            bottom: 0,
            left: _isSideMenuOpen ? 0 : -200,
            child: SizedBox(
              width: 200,
              child: Material(
                color: Color.fromARGB(255, 214, 199, 218),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 22.0,
                              backgroundImage: _currentUser?.photoURL != null
                                  ? NetworkImage(_currentUser!.photoURL!)
                                  : null,
                              child: _currentUser?.photoURL == null
                                  ? const Icon(Icons.person, size: 30.0)
                                  : null,
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "etadese009@gmail.com",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.home, color: Color.fromARGB(255, 0, 0, 0)),
                        title: const Text('Option 1', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                        onTap: () {
                          // Handle Option 1 tap
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings, color: Color.fromARGB(255, 0, 0, 0)),
                        title: const Text('Option 2', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                        onTap: () {
                          // Handle Option 2 tap
                        },
                      ),
                      // const Spacer(),
                      ListTile(
                        leading: const Icon(Icons.settings, color: Color.fromARGB(255, 0, 0, 0)),
                        title: const Text('Option 3', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                        onTap: () {
                          // Handle Settings tap
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Color.fromARGB(255, 0, 0, 0)),
                        title: const Text('Logout', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                            (route) => false,
                          );
                          showToast(message: "Successfully signed out");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Main content area
          GestureDetector(
            onTap: () {
              setState(() {
                _isSideMenuOpen = !_isSideMenuOpen;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              transform: Matrix4.translationValues(_isSideMenuOpen ? 200 : 0, 0, 0),
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Color.fromARGB(255, 214, 199, 218),
                  automaticallyImplyLeading: false,
                  title: const Text("HomePage", style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  leading: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      setState(() {
                        _isSideMenuOpen = !_isSideMenuOpen;
                      });
                    },
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Column(
                    children: [
                      Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewMeeting(
                          
                        ),
                      ),
                    );
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 163, 98, 2),
                          ),
                          child: Icon(Icons.video_call, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text("New meeting")
                    ],
                  ),
                  SizedBox(width:50),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to the Join screen
                          Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JoinMeeting(
                          
                        ),
                      ),
                    );
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 107, 73, 115),
                          ),
                          child: Icon(Icons.group, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text("Join")
                    ],
                  ),
                  SizedBox(width:50),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to the Schedule screen
                          Navigator.pushNamed(context, '/schedule');
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 107, 73, 115),
                          ),
                          child: Icon(Icons.schedule, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text("Schedule")
                    ],
                  ),
                  SizedBox(width:50),
                                
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to the Share Screen screen
                          Navigator.pushNamed(context, '/shareScreen');
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 107, 73, 115),
                          ),
                          child: Icon(Icons.screen_share, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text("Share screen")
                    ],
                  )
                                ],
                                
                                ),
                                SizedBox(height: 150,),
              Padding(
                padding: EdgeInsets.only(top:28.0),
                child: Column(
                  children: [
                    Text("No upcoming meetings here",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    Text("The scheduled meetings will be listed here!",style: TextStyle(fontSize: 11),)
                  ],
                ),
                )
                    ],
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  currentIndex: _selectedIndex,
  selectedItemColor: Color.fromARGB(255, 107, 73, 115),
  unselectedItemColor: Color.fromARGB(255, 97, 95, 95),
  onTap: _onItemTapped,
  elevation: 10,
  items: [
    BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(
          0.0,
          _selectedIndex == 0 ? -5.0 : 0.0,
          0.0,
        ),
        child: Icon(Icons.home),
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(
          0.0,
          _selectedIndex == 1 ? -5.0 : 0.0,
          0.0,
        ),
        child: Icon(Icons.search),
      ),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(
          0.0,
          _selectedIndex == 2 ? -5.0 : 0.0,
          0.0,
        ),
        child: Icon(Icons.notifications),
      ),
      label: 'Notifications',
    ),
    BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(
          0.0,
          _selectedIndex == 3 ? -5.0 : 0.0,
          0.0,
        ),
        child: Icon(Icons.message),
      ),
      label: 'Messages',
    ),
    BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(
          0.0,
          _selectedIndex == 4 ? -5.0 : 0.0,
          0.0,
        ),
        child: Icon(Icons.settings),
      ),
      label: 'Settings',
    ),
  ],
)
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}