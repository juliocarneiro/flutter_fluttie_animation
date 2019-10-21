import 'package:flutter/material.dart';
import 'package:fluttie/fluttie.dart';

import 'form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var busy = false;
  var done = false;

  FluttieAnimationController animationCtlr;

  @override
  initState() {
    super.initState();
    prepareAnimation();
  }

  @override
  dispose() {
    super.dispose();
    animationCtlr?.dispose();
  }

  prepareAnimation() async {
    var instance = Fluttie();
    var checkAnimation =
        await instance.loadAnimationFromAsset("assets/ok.json");

    animationCtlr = await instance.prepareAnimation(
      checkAnimation,
      duration: const Duration(seconds: 2),
      repeatCount: const RepeatCount.dontRepeat(),
      repeatMode: RepeatMode.START_OVER,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: double.infinity,
          alignment: Alignment.center,
        ),
        FluttieAnimation(animationCtlr),
        !done ? SubmitForm(busy: busy, func: submit) : Container()
      ],
    ));
  }

  Future<Function> submit() async {
    setState(() {
      busy = true;
    });

    Future.delayed(
        const Duration(seconds: 4),
        () => setState(() {
              done = true;
              animationCtlr.start();
            }));
  }
}
