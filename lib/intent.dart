// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:receive_sharing_intent/receive_sharing_intent.dart';

// class Intents extends StatefulWidget {
//   const Intents({super.key});

//   @override
//   State<Intents> createState() => _IntentsState();
// }

// class _IntentsState extends State<Intents> {
//   late StreamSubscription _intentData;
//   String? Data;
//   void initState() {
//     super.initState();
//     _intentData = ReceiveSharingIntent.getTextStream().listen((String value) {
//       setState(() {
//         Data = value;
//       });
//     });
//     ReceiveSharingIntent.getInitialText().then((String? value) {
//       setState(() {
//         Data = value;
//       });
//     });
//   }

//   void dispose() {
//     _intentData.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Intent"),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Text("shared urls/text:",style: TextStyle(fontSize: 20),),
//             Text(Data??"")
//           ],
//         )
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key? key}) : super(key: key);

  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  static const platform = const MethodChannel('app.channel.shared.data');
  String dataShared = "No data";

  @override
  void initState() {
    super.initState();
    getSharedText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(dataShared)));
  }

  getSharedText() async {
    var sharedData = await platform.invokeMethod("getSharedText");
    if (sharedData != null) {
      setState(() {
        dataShared = sharedData;
      });
    }
  }
}
