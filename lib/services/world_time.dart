import 'dart:convert';
import 'package:http/http.dart';

class WorldTime {
  // Current Time
  late DateTime time;
  // Position of location' avatar
  late String flag;
  // Requested Location
  late String location;
  // Part of the worldtime api
  late String url;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    // Getting Data from the world time api
    Response response =
        await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));

    // Changing data to usable form
    Map data = jsonDecode(response.body);
    // Current time
    String dateTime = data['datetime'];
    // Offset for the current location
    String offset = data['utc_offset'];

    DateTime now = DateTime.parse(dateTime);
    now = now.add(Duration(
      hours: int.parse(offset.substring(1, 3)),
      minutes: int.parse(offset.substring(4, 6)),
    ));
    time = now;
  }
}
