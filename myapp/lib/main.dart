import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(
  home: Home(),
));

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hey fella'),
        centerTitle: true,
        backgroundColor: Colors.red[700],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(30),
                color: Colors.cyan,
                child: Text('1'),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(30),
                color: Colors.green,
                child: Text('2'),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(30),
                color: Colors.red,
                child: Text('3'),
              ),
            ),
          ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.red[300],
        child: Text('click'),
      ),
    );
  }
}
