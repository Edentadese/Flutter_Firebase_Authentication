import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/firebase_auh_implementation/firebase_auth_service.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/meeting_screen.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/sign_up.dart';
import 'package:flutter_application_1/features/user_auth/presentation/widgets/form.dart';
import 'package:flutter_application_1/global/common/toast.dart';
import 'package:flutter_application_1/main.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart' hide User;
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';  // Import this for Clipboard functionality

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image(
            image: AssetImage('assets/splash.png'),
            width: 300,
            height: 300,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38.0),
            child: Column(
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
                ),
                SizedBox(height: 10),
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    _signIn();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 145, 106, 154),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isSigning
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                          (route) => false,
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color.fromARGB(255, 145, 106, 154),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      // Get the token
      String? token = await user.getIdToken();

      // Ensure token is not null
      if (token != null) {
        String userId = user.uid;

        showToast(message: "User is successfully signed in");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Display(
              // token: token, userId: userId
            ),
          ),
          (route) => false,
        );
      } else {
        showToast(message: "Error occurred: Token is null");
      }
    } else {
      showToast(message: "Error occurred: User is null");
    }
  }
}


class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _meetingNameController = TextEditingController();
  final TextEditingController _participantsController = TextEditingController();
  String? _generatedId;

  void _generateNewId() {
    if (_meetingNameController.text.isEmpty || _participantsController.text.isEmpty) {
      showToast(message: "Please enter Meeting Name and Number of Participants");
      return;
    }

    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Uuid().v4().toString();
    setState(() {
      _generatedId = String.fromCharCodes(
        Iterable.generate(
          4,
          (_) => characters.codeUnitAt(
            random.codeUnitAt(_) % characters.length,
          ),
        ),
      );

      String meetingName = _meetingNameController.text;
      String participants = _participantsController.text;

      showToast(message: "Meeting ID: $_generatedId\nMeeting Name: $meetingName\nParticipants: $participants");
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _meetingNameController.dispose();
    _participantsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generate and Join Call"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/splash.png'),
              width: 250, // Set your desired width
              height: 250, // Set your desired height
            ),
            // Meeting Name Input
            Padding(
              padding: const EdgeInsets.only(left:78.0,right: 78),
              child: TextField(
                controller: _meetingNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Meeting Name',
                ),
              ),
            ),
            SizedBox(height: 10),

            // Participants Input
            Padding(
              padding: const EdgeInsets.only(left:78.0,right: 78),
              child: TextField(
                controller: _participantsController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Number of Participants',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: _generateNewId,
              child: Text('Generate New ID'),
            ),
            SizedBox(height: 10),
            if (_generatedId != null) ...[
              SelectableText("Generated ID: $_generatedId", style: TextStyle(fontSize: 16)),
              ElevatedButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _generatedId!));
                  showToast(message: "ID copied to clipboard");
                },
                child: Text('Copy ID'),
              ),
            ],
            SizedBox(height: 10),

            // User Name Input
            Padding(
              padding: const EdgeInsets.only(left:78.0,right: 78),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Your Name',
                ),
              ),
            ),
            SizedBox(height: 10),

            // Call ID Input
            Padding(
              padding: const EdgeInsets.only(left:78.0,right: 78),
              child: TextField(
                controller: _idController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Call ID',
                ),
              ),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                String callId = _idController.text.trim();
                String userName = _nameController.text.trim();
                String meetingName = _meetingNameController.text.trim();

                if (callId.isNotEmpty && userName.isNotEmpty) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(userName: userName),
                    ),
                    (route) => false,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallScreen(callId: callId, userName: userName, meetingName: meetingName),
                    ),
                  );
                } else {
                  showToast(message: "Please enter a valid Call ID and your name");
                }
              },
              child: const Text('Join Call with Entered ID'),
            ),
          ],
        ),
      ),
    );
  }
}




class CallScreen extends StatefulWidget {
  final String callId;
  final String userName;
  final String meetingName;

  const CallScreen({
    Key? key,
    required this.callId,
    required this.userName,
    required this.meetingName,
  }) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the existing StreamVideo client
    final client = StreamVideo.instance;

    // Join or create the call
    var call = client.makeCall(
      callType: StreamCallType(),
      id: widget.callId,
    );

    return Scaffold(
      body: Stack(
        children: [
          StreamCallContainer(
            call: call,
            callContentBuilder: (context, call, callState) {
              return StreamCallContent(
                call: call,
                callState: callState,
                callControlsBuilder: (context, call, callState) {
                  final localParticipant = callState.localParticipant!;
                  return StreamCallControls(
                    options: [
                      CallControlOption(
                        icon: const Icon(Icons.chat_outlined),
                        onPressed: () {
                          // Open your chat window
                        },
                      ),
                      FlipCameraOption(
                        call: call,
                        localParticipant: localParticipant,
                      ),
                      AddReactionOption(
                        call: call,
                        localParticipant: localParticipant,
                      ),
                      ToggleMicrophoneOption(
                        call: call,
                        localParticipant: localParticipant,
                      ),
                      ToggleCameraOption(
                        call: call,
                        localParticipant: localParticipant,
                      ),
                      LeaveCallOption(
                        call: call,
                        onLeaveCallTap: () {
                          call.leave();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          // Overlay for meeting name
          Positioned(
            top: 20,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: Colors.black54, // Semi-transparent background
              child: Text(
                widget.meetingName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}