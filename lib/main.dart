import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.example.sleeper/battery');

  String _batteryLevel = 'Unknown';
  Future<void> _getBatteryLevel() async {
    String level = '';
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      level = 'Battery level: $result';
    } on PlatformException catch (e) {
      level = 'Failed to get battery level';
    }
    setState(() {
      _batteryLevel = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Text(_batteryLevel),
            TextButton(
              child: Text('Get battery level'),
              onPressed: () {
                _getBatteryLevel();
              },
            ),
          ],
        ));
  }
}
