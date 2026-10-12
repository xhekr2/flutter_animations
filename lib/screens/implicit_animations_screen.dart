import 'package:flutter/material.dart';

class const ImplicitAnimationsScreen({super.key}) extends StatefulWidget {
  @override
  State<ImplicitAnimationsScreen> createState() =>
      _ImplicitAnimationsScreenState();
}

class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen> {
  bool _flag = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Implicit Animations'), centerTitle: true),
      body: Center(
        child: Column(
          spacing: 50,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AnimatedAlign(
            //   alignment: _flag ? Alignment.centerLeft : Alignment.centerRight,
            //   duration: Duration(milliseconds: 500),
            //   child: AnimatedOpacity(
            //     opacity: _flag ? 1 : 0,
            //     duration: Duration(milliseconds: 500),
            //     child: Container(
            //       decoration: BoxDecoration(color: Colors.amberAccent),
            //       width: size.width * 0.8,
            //       height: size.width * 0.8,
            //     ),
            //   ),
            // ),
            AnimatedContainer(
              curve: Curves.elasticOut,
              // curve: Curves.bounceIn,
              duration: Duration(milliseconds: 1000),
              decoration: BoxDecoration(
                color: _flag ? Colors.redAccent : Colors.amberAccent,
                borderRadius: BorderRadius.circular(_flag ? 100 : 0),
              ),
              transform: Matrix4.rotationZ(_flag ? 1 : 0),
              transformAlignment: Alignment.center,
              width: size.width * 0.8,
              // width: _flag ? size.width : size.width * 0.8,
              height: size.width * 0.8,
              // height: _flag ? size.width : size.width * 0.8,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _flag = !_flag;
                });
              },
              child: Text('Go'),
            ),
          ],
        ),
      ),
    );
  }
}
