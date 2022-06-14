import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tm/data.dart';
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
      home: const TimeMachineHomePage(),
    );
  }
}

class TimeMachineHomePage extends StatefulWidget {
  const TimeMachineHomePage({Key? key}) : super(key: key);

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
        title: const Text(appName),
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
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                child: SizedBox(
                  height: 288,
                  width: 512,
                  child: Material(
                    color: Colors.indigo,
                    clipBehavior: Clip.antiAlias,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(64)),
                    child: TimeMachine.observatory(
                      size: const Size(200.0, 200.0),
                      backgroundColor: Colors.white,
                      data: const TMData(cards: [
                        TMCard(
                            title: 'title',
                            subTitle: 'subTitle',
                            description: 'description',
                            content: Center(child: Text('content 1'))),
                        TMCard(
                            title: 'title',
                            subTitle: 'subTitle',
                            description: 'description',
                            content: Center(child: Text('content 2'))),
                        TMCard(
                            title: 'title',
                            subTitle: 'subTitle',
                            description: 'description',
                            content: Center(child: Text('content 3'))),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                child: SizedBox(
                  height: 288,
                  width: 512,
                  child: Material(
                    color: Colors.indigoAccent,
                    clipBehavior: Clip.antiAlias,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(64)),
                    child: TimeMachine.observatory(
                      size: const Size(300.0, 200.0),
                      backgroundColor: Colors.white70,
                      cardShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      data: const TMData(cards: [
                        TMCard(
                            title: 'title',
                            subTitle: 'subTitle',
                            description: 'description',
                            content: Center(child: Text('content 1'))),
                        TMCard(
                            title: 'title',
                            subTitle: 'subTitle',
                            description: 'description',
                            content: Center(child: Text('content 2'))),
                      ]),
                    ),
                  ),
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
