import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:time_app/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  // Getting Initial Data
  void setupTime() async {
    WorldTime instance =
        WorldTime(location: 'Kolkata', flag: '', url: 'Asia/Kolkata');
    await instance.getTime();

    // Sending Data to HomePage
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'flag': instance.flag,
      'location': instance.location,
      'time': instance.time,
    });
  }

  @override
  void initState() {
    super.initState();
    setupTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitCircle(
        color: Colors.grey[500],
        size: 50,
      ),
    ));
  }
}
