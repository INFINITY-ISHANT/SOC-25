import 'package:flutter/material.dart';
import 'package:worldtime/services/gettime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getData() async {
    String timezone = await getUserCoordinates();
    WorldTime instance = WorldTime(location: 'Your Location', flag: 'globe.png', url: timezone);
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isdaytime': instance.isdaytime,
    });
  }
  Future<String> getUserCoordinates() async {
    // Request permission
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Future.error('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission=await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever){
      return Future.error('location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();
    double lat = position.latitude;
    double lon = position.longitude;

    // Get timezone from API
    final uri = Uri.parse('https://timeapi.io/api/TimeZone/coordinate?latitude=$lat&longitude=$lon');
    final response = await get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['timeZone']; // e.g., "Asia/Kolkata"
    } else {
      throw Exception("Failed to get timezone");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.blue[900],
          size: 50,
        ),
      ),
    );
  }
}
