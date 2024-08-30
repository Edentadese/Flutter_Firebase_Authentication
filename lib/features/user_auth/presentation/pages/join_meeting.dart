import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/meeting_screen.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

class JoinMeeting extends StatefulWidget {
  const JoinMeeting({super.key, required String userId, String? token});

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
      body: 
      Padding(
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


// import 'package:flutter/material.dart';
// import 'package:stream_video_flutter/stream_video_flutter.dart' as stream_video;
// import 'package:flutter_application_1/features/user_auth/presentation/pages/meeting_screen.dart';
// import 'package:stream_video_flutter/stream_video_flutter.dart';
// import 'package:uuid/uuid.dart';

// class JoinMeeting extends StatefulWidget {
//   final stream_video.StreamVideo client;

//   const JoinMeeting({super.key, required this.client});

//   @override
//   State<JoinMeeting> createState() => _JoinMeetingState();
// }

// class _JoinMeetingState extends State<JoinMeeting> {
//    final TextEditingController _meetingNameController = TextEditingController();
//   final TextEditingController _participantsNumberController = TextEditingController();
//   final Uuid _uuid = const Uuid();
//   final Map<String, String> _meetingDetails = {};
//   final TextEditingController _meetingIdController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 214, 199, 218),
//         title: Center(child: const Text("Join", style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)))),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 28.0, right: 28, top: 10),
//         child: Column(
//           children: [
//             // Image(
//             //   image: AssetImage('assets/splash.png'),
//             //   width: 300,
//             //   height: 300,
//             // ),
//             Padding(
//         padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 10),
//         child: Column(
//           children: [
//             const Image(
//               image: AssetImage('assets/splash.png'),
//               width: 300,
//               height: 300,
//             ),
//             TextField(
//               controller: _meetingNameController,
//               decoration: InputDecoration(
//                 labelText: 'Enter Meeting Name',
//                 floatingLabelBehavior: FloatingLabelBehavior.auto,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: BorderSide(
//                     color: Colors.grey.shade400,
//                     width: 1.0,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: const BorderSide(
//                     color: Colors.purple,
//                     width: 2.0,
//                   ),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _participantsNumberController,
//               decoration: InputDecoration(
//                 labelText: 'Enter Number of Participants',
//                 floatingLabelBehavior: FloatingLabelBehavior.auto,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: BorderSide(
//                     color: Colors.grey.shade400,
//                     width: 1.0,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: const BorderSide(
//                     color: Colors.purple,
//                     width: 2.0,
//                   ),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 20),
//             GestureDetector(
//               onTap: () async {
//                 // Validate inputs
//                 String meetingName = _meetingNameController.text.trim();
//                 int? maxParticipants = int.tryParse(_participantsNumberController.text.trim());

//                 if (meetingName.isEmpty || maxParticipants == null || maxParticipants <= 0) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Please enter valid meeting details')),
//                   );
//                   return;
//                 }

//                 // Generate a unique ID for the call
//                 String uniqueCallId = _uuid.v4();

//                 // Store the meeting details
//                 _meetingDetails[uniqueCallId] = meetingName;

//                 // Show a modal with the meeting ID
//                 showDialog(
//                   context: context,
//                   builder: (context) => DisplayMeetingIdScreen(meetingId: uniqueCallId),
//                 );
//               },
//               child: Container(
//                 width: double.infinity,
//                 height: 45,
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 145, 106, 154),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     "Create a call",
//                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//             TextField(
//               controller: _meetingIdController,
//               decoration: InputDecoration(
//                 labelText: 'Enter Meeting ID',
//                 floatingLabelBehavior: FloatingLabelBehavior.auto,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: BorderSide(
//                     color: Colors.grey.shade400,
//                     width: 1.0,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: BorderSide(
//                     color: Colors.purple,
//                     width: 2.0,
//                   ),
//                 ),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//               ),
//             ),
//             const SizedBox(height: 20),
//             GestureDetector(
//               onTap: () async {
//                 try {
//                   String enteredMeetingId = _meetingIdController.text.trim();
//                   if (enteredMeetingId.isEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Please enter a valid Meeting ID')),
//                     );
//                     return;
//                   }

//                   // Create or join a call
//                   var call = widget.client.makeCall(
//                     callType: stream_video.StreamCallType(),
//                     id: enteredMeetingId,
//                   );
//                   await call.getOrCreate();

//                   // Navigate to the call screen
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => CallScreen(call: call, username: "ns"),
//                     ),
//                   );
//                 } catch (e) {
//                   debugPrint('Error joining call: $e');
//                 }
//               },
//               child: Container(
//                 width: double.infinity,
//                 height: 45,
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 145, 106, 154),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "Join a call",
//                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class CallScreen extends StatefulWidget {
//   final Call call; // Use the correct class for Stream Video calls
//   final String username;

//   const CallScreen({
//     Key? key,
//     required this.call,
//     required this.username,
//   }) : super(key: key);

//   @override
//   State<CallScreen> createState() => _CallScreenState();
// }

// class _CallScreenState extends State<CallScreen> {
//   late Call _call;

//   @override
//   void initState() {
//     super.initState();
//     _call = widget.call;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 214, 199, 218),
//         title: Center(child: Text('Call')),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: StreamCallContainer(
//                 call: _call,
//                 callContentBuilder: (
//                   BuildContext context,
//                   Call call,
//                   CallState callState,
//                 ) {
//                   return StreamCallContent(
//                     call: call,
//                     callState: callState,
//                     callControlsBuilder: (
//                       BuildContext context,
//                       Call call,
//                       CallState callState,
//                     ) {
//                       final localParticipant = callState.localParticipant!;
//                       return StreamCallControls(
//                         options: [
//                           CallControlOption(
//                             icon: const Icon(Icons.chat_outlined),
//                             onPressed: () {
//                               // Open your chat window
//                             },
//                           ),
//                           FlipCameraOption(
//                             call: call,
//                             localParticipant: localParticipant,
//                           ),
//                           AddReactionOption(
//                             call: call,
//                             localParticipant: localParticipant,
//                           ),
//                           ToggleMicrophoneOption(
//                             call: call,
//                             localParticipant: localParticipant,
//                           ),
//                           ToggleCameraOption(
//                             call: call,
//                             localParticipant: localParticipant,
//                           ),
//                           LeaveCallOption(
//                             call: call,
//                             onLeaveCallTap: () {
//                               call.leave();
//                             },
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Username: ${widget.username}', // Display username
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   await _call.leave(); // End the call
//                   Navigator.pop(context);
//                 } catch (e) {
//                   debugPrint('Error ending call: $e');
//                 }
//               },
//               child: Text('End Call'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
