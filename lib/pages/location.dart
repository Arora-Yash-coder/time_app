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
  // Todo: Get all the locations provided by the api.
  // void getLocations() {
  //   Future<Response> locationsData =
  //     get(Uri.parse("http://worldtimeapi.org/api/timezone/"));
  // }

  //List of some defined locations
  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
  ];

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
              leading: const CircleAvatar(backgroundImage: AssetImage('')),
            )),
          );
        },
      ),
    );
  }
}
