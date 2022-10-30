import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  late String time; // the time in that location
  String flag; // url for an asset flag icon
  String url; // location url for API endpoint
  late bool isDaytime; // to check if day or night

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try{
      // fetching data from API
      Response response = await get(Uri.https('worldtimeapi.org', '/api/timezone/$url'));
      var data = jsonDecode(response.body) as Map<String, dynamic>;

      // setting respective offset
      String offset = data['utc_offset'];

      // adding offset to UTC DateTime
      DateTime now = DateTime.parse(data['datetime']);
      now = now.add(Duration(
        minutes: int.parse(offset.substring(4)),
        hours: int.parse(offset.substring(1,3)),
      ));

      // set day-night
      isDaytime = now.hour > 6 && now.hour < 19 ? true : false;

      // set time property of the object
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'Failed to update time!';
    }

  }
}