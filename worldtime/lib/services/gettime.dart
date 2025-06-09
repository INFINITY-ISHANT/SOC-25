import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  late String time;
  String flag;
  String url;
  late bool isdaytime;

  WorldTime({required this.location, required this.flag, required this.url});
  Future<void> getTime() async {
    try {
      Response response = await get(Uri.parse('https://api.api-ninjas.com/v1/worldtime?timezone=$url'), headers:{'X-Api-Key': 'xiLIZhhG/QrVPKRIGi1sdg==5wuA7GaP02xyDEHY'});
      Map data = jsonDecode(response.body);
      DateTime dateTime = DateTime.parse(data['datetime']);
      isdaytime = dateTime.hour > 6 && dateTime.hour < 20 ? true : false;
      time = DateFormat.jm().format(dateTime);
    }
    catch (e) {
      print('caught error $e');
      time='could not get time';
    }

  }

}

