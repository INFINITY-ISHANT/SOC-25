import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data={};
  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)?.settings.arguments;
    // if (args != null && args is Map) {
    //   data = args;
    // }
    data = data.isNotEmpty? data : ModalRoute.of(context)?.settings.arguments as Map;
    print(data);

    String bg=data['isdaytime']? 'day.jpg' : 'night.jpg';
    Color bgcolor=data['isdaytime']? Colors.blue : Colors.black;
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
          child:Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Center(
                  child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: data['isdaytime']? Colors.orange : Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () async {
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        setState(() {
                          data={
                            'time': result['time'],
                            'location': result['location'],
                            'isdaytime': result['isdaytime'],
                            'flag': result['flag'],
                          };
                        });
                      },
                      label: Text('choose location'),
                      icon: Icon(Icons.edit_location),
                  ),
                ),
                SizedBox(height: 10),
                Text(data['location'],
                style: TextStyle(
                  color: data['isdaytime']? Colors.black : Colors.white,
                  fontSize: 28,
                  letterSpacing: 2,
                ),),
                Text(data['time'],
                style: TextStyle(
                  fontSize: 66,
                  color: data['isdaytime']? Colors.black : Colors.white,
                ),)
              ],
            ),
          ),
      ),
    );
  }
}
