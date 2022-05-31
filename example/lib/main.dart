import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tm/tm.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const TimeMachineDemoApp());

const String appName = 'Demo TimeMachine';
const String repoURL = 'https://github.com/glorylab/timemachine';

class TimeMachineDemoApp extends StatelessWidget {
  const TimeMachineDemoApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: const TimeMachineHomePage(title: appName),
    );
  }
}

class TimeMachineHomePage extends StatefulWidget {
  const TimeMachineHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TimeMachineHomePage> createState() => _TimeMachineHomePageState();
}

class _TimeMachineHomePageState extends State<TimeMachineHomePage> {
  void _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 2.0,
        actions: [
          IconButton(
            onPressed: () {
              _launchUrl(repoURL);
            },
            icon: Image.asset(
              'icons/ic_github.png',
              package: 'web3_icons',
              width: 32.0,
              height: 32.0,
            ),
          )
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            const Align(
              child: SizedBox(
                width: 320.0,
                height: 200.0,
                child: TimeMachine(
                  size: Size(200.0, 200.0),
                  backgroundColor: Colors.green,
                ),
              ),
            ),
            const SizedBox(
              height: 88,
            ),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.asset(
                      'icons/ic_glory_lab.png',
                      package: 'web3_icons',
                      width: 32.0,
                      height: 32.0,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Made in Glory Lab',
                      style: GoogleFonts.robotoMono(
                        color: Colors.grey[500],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
