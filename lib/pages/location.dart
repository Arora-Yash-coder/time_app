import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:time_app/services/world_time.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  void initState() {
    super.initState();
    getLocationsData();
  }

  Future<void> getLocationsData() async {
    Response locationsData =
        await get(Uri.parse("http://worldtimeapi.org/api/timezone/"));
    List locationData = jsonDecode(locationsData.body);
    for (var i = 0; i < locationData.length; i++) {
      String tempURL = locationData[i].toString();
      List tempLocation = locationData[i].toString().split("/");

      locations.add(WorldTime(
        location: !locationData[i].toString().contains("/")
            ? tempLocation[0].toString()
            : tempLocation[1].toString(),
        flag: 'lib/images/flag.png',
        url: tempURL,
      ));
    }
    setState(() {
      locations;
    });
  }

  List<WorldTime> locations = [];

  //Sending data of the new selected location.
  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Choose a Location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
                child: ListTile(
              onTap: (() {
                updateTime(index);
              }),
              title: Text(locations[index].location),
              leading: const CircleAvatar(
                backgroundImage: AssetImage('lib/images/flag.png'),
              ),
            )),
          );
        },
      ),
    );
  }
}
