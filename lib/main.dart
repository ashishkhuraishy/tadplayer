import 'package:flutter/material.dart';
import 'package:tadplayer/constants.dart';
import 'package:tadplayer/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadPlaceholder();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Wrapper(),
    );
  }
}
