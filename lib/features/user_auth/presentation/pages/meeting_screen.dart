import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

class DisplayMeetingIdScreen extends StatelessWidget {
  final String meetingId;

  const DisplayMeetingIdScreen({Key? key, required this.meetingId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting ID'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Meeting ID is:',
              // style: Styl,
            ),
            const SizedBox(height: 10),
            Center(
              child: SelectableText(
                meetingId,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: meetingId));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Meeting ID copied to clipboard!')),
                );
              },
              child: const Text('Copy Meeting ID'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the main page
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class CallScreen extends StatefulWidget {
  final Call call;
  final String? meetingName;
  final int? maxParticipants;

  const CallScreen({
    Key? key,
    required this.call,
    this.meetingName,
    this.maxParticipants,
  }) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meetingName ?? 'Call'),
      ),
      body: StreamCallContainer(
        
        call: widget.call,
        callContentBuilder: (
          BuildContext context,
          Call call,
          CallState callState,
        ) {
          return StreamCallContent(
            call: call,
            callState: callState,
            callControlsBuilder: (
              BuildContext context,
              Call call,
              CallState callState,
            ) {
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
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}