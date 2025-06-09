import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(
  home: Ninjacard(),
));

class Ninjacard extends StatefulWidget {
  const Ninjacard({super.key});

  @override
  State<Ninjacard> createState() => _NinjacardState();
}

class _NinjacardState extends State<Ninjacard> {

  int Ninjalevel=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text('NINJA ID CARD'),
        centerTitle: true,
        backgroundColor: Colors.grey[600],
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
              Ninjalevel++;
            });
          },
        child: Icon(Icons.add),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/ninja2.jpg'),
                radius: 50,
              ),
            ),
            Divider(
              height: 60,
              color: Colors.black,
            ),
            Text(
              'NAME',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2,
              ),
            ),
            Text(
              'Ishant Kumar',
              style: TextStyle(
                color: Colors.amber,
                letterSpacing: 2,
                fontSize:30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            Text(
              'CURRENT NINJA LEVEL',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2,
              ),
            ),
            Text(
              '$Ninjalevel',
              style: TextStyle(
                color: Colors.amber,
                letterSpacing: 2,
                fontSize:30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                SizedBox(width: 10,),
                Text('ishan@hulu.com',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 30,
                  letterSpacing: 1,
                ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}



