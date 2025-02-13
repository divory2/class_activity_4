import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterAndImageToggle(),
    );
  }
}

class CounterAndImageToggle extends StatefulWidget {
  @override
  _CounterAndImageToggleState createState() => _CounterAndImageToggleState();
}

class _CounterAndImageToggleState extends State<CounterAndImageToggle> with TickerProviderStateMixin {
  int _counter = 0;
  bool _showFirstImage = true;
  late AnimationController _controller;
  late Animation<double> _animation;
  double size = 20;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 0.5,
    );
    _animation = Tween(begin: 0.8, end: 1.2).animate(
  CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
    _controller.addStatusListener((status){
      if (status == AnimationStatus.completed){
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed){
        _controller.forward();
      }

    });
   

    _controller.repeat(reverse:true);


  }
  @override
void dispose(){
  _controller.dispose();
  super.dispose();
}

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleImage() {
    setState(() {
      _showFirstImage = !_showFirstImage;
    });
    // _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter & Image Toggle')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: $_counter', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Text('Increment'),
            ),
            SizedBox(height: 40),
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                _showFirstImage ? 'assets/VD3.png' : 'assets/VD5.png',
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleImage,
              child: Text('Toggle Image'),
            ),
          ],
        ),
      ),
    );
  }

  
}
