import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class NewMeeting extends StatefulWidget {
  const NewMeeting({super.key});

  @override
  State<NewMeeting> createState() => _NewMeetingState();
}

class _NewMeetingState extends State<NewMeeting> {
  final TextEditingController _meetingNameController = TextEditingController();
  final TextEditingController _participantsNumberController = TextEditingController();
  final Uuid _uuid = const Uuid();
  final Map<String, String> _meetingDetails = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 214, 199, 218),
        title: const Center(child: Text("Create meeting", style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)))),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 10),
        child: Column(
          children: [
            const Image(
              image: AssetImage('assets/splash.png'),
              width: 300,
              height: 300,
            ),
            TextField(
              controller: _meetingNameController,
              decoration: InputDecoration(
                labelText: 'Enter Meeting Name',
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
                  borderSide: const BorderSide(
                    color: Colors.purple,
                    width: 2.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _participantsNumberController,
              decoration: InputDecoration(
                labelText: 'Enter Number of Participants',
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
                  borderSide: const BorderSide(
                    color: Colors.purple,
                    width: 2.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                // Validate inputs
                String meetingName = _meetingNameController.text.trim();
                int? maxParticipants = int.tryParse(_participantsNumberController.text.trim());

                if (meetingName.isEmpty || maxParticipants == null || maxParticipants <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter valid meeting details')),
                  );
                  return;
                }

                // Generate a unique ID for the call
                String uniqueCallId = _uuid.v4();

                // Store the meeting details
                _meetingDetails[uniqueCallId] = meetingName;

                // Show a modal with the meeting ID
                showDialog(
                  context: context,
                  builder: (context) => DisplayMeetingIdScreen(meetingId: uniqueCallId),
                );
              },
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 145, 106, 154),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Create a call",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class DisplayMeetingIdScreen extends StatelessWidget {
  final String meetingId;

  const DisplayMeetingIdScreen({super.key, required this.meetingId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Your Meeting ID',style: TextStyle(fontSize: 16),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SelectableText(
            meetingId,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: meetingId));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Meeting ID copied to clipboard'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 145, 106, 154),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Copy Meeting ID',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:uuid/uuid.dart';

// class NewMeeting extends StatefulWidget {
//   const NewMeeting({super.key});

//   @override
//   State<NewMeeting> createState() => _NewMeetingState();
// }

// class _NewMeetingState extends State<NewMeeting> {
//   final TextEditingController _meetingNameController = TextEditingController();
//   final TextEditingController _participantsNumberController = TextEditingController();
//   final Uuid _uuid = const Uuid();
//   final Map<String, String> _meetingDetails = {};

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 214, 199, 218),
//         title: const Center(child: Text("Create meeting", style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)))),
//       ),
//       body: Padding(
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
//     );
//   }
// }

// class DisplayMeetingIdScreen extends StatelessWidget {
//   final String meetingId;

//   const DisplayMeetingIdScreen({super.key, required this.meetingId});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Your Meeting ID',style: TextStyle(fontSize: 16),),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SelectableText(
//             meetingId,
//             style: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 16),
//           GestureDetector(
//             onTap: () {
//               Clipboard.setData(ClipboardData(text: meetingId));
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Meeting ID copied to clipboard'),
//                   duration: Duration(seconds: 2),
//                 ),
//               );
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 145, 106, 154),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Text(
//                 'Copy Meeting ID',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Close'),
//         ),
//       ],
//     );
//   }
// }