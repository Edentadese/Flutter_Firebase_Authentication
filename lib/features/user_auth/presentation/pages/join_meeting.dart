import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/meeting_screen.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

class JoinMeeting extends StatefulWidget {
  const JoinMeeting({super.key});

  @override
  State<JoinMeeting> createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  
  final TextEditingController _meetingIdController = TextEditingController();
  
  final Map<String, String> _meetingDetails = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 214, 199, 218),
        title: Center(child: const Text("Join",style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 28.0,right: 28,top: 10),
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/splash.png'),
              width: 300, 
              height: 300, 
            ),
            TextField(
                  controller: _meetingIdController,
                  decoration: InputDecoration(
          labelText: 'Enter Meeting ID',
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.purple,
              width: 2.0,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: ()async{
                    try {
                      String enteredMeetingId = _meetingIdController.text.trim();
                      if (enteredMeetingId.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please enter a valid Meeting ID')),
                        );
                        return;
                      }
                      var call = StreamVideo.instance.makeCall(
                        callType: StreamCallType(),
                        id: enteredMeetingId,
                      );
                      await call.getOrCreate();
                      // Get the meeting name associated with the entered ID
                      String? meetingName = _meetingDetails[enteredMeetingId];
                      // Navigate to the call screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CallScreen(
                            call: call,
                            meetingName: meetingName,
                          ),
                        ),
                      );
                    } catch (e) {
                      debugPrint('Error joining call: $e');
                      debugPrint(e.toString());
                    }

                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 145, 106, 154),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                      "Join a call",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                    ),
                  )
                ),     
          ],
        ),
      ),
    );
  }
}