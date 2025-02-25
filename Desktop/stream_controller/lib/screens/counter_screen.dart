import 'dart:async';
import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final StreamController<int> _counterController = StreamController<int>();
  int _counter = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _counter++;
      _counterController.add(_counter);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _counterController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador en tiempo real'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: _counterController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                'Contador: ${snapshot.data}',
                style: TextStyle(fontSize: 24),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
