import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterImageApp(),
    );
  }
}

class CounterImageApp extends StatefulWidget {
  @override
  _CounterImageAppState createState() => _CounterImageAppState();
}

class _CounterImageAppState extends State<CounterImageApp>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  bool _isImageOne = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleImage() {
    setState(() {
      _isImageOne = !_isImageOne;
    });
    _controller.forward(from: 0.0);
  }

  void _reset() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Reset Confirmation"),
          content: Text("Are you sure you want to reset?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _counter = 0;
                  _isImageOne = true;
                });
                Navigator.of(context).pop();
              },
              child: Text("Reset"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter & Image Toggle App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter: $_counter',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Text("Increment"),
            ),
            SizedBox(height: 20),
            FadeTransition(
              opacity: _animation,
              child: Image.asset(
                _isImageOne ? 'assets/image1.png' : 'assets/image2.png',
                height: 150,
              ),
            ),
            ElevatedButton(
              onPressed: _toggleImage,
              child: Text("Toggle Image"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _reset,
              child: Text("Reset"),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
