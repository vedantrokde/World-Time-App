import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  Future<void> setupWorldTime() async {
    WorldTime instance = WorldTime(
      location: 'Kolkata',
      flag: 'india.png',
      url: 'Asia/Kolkata'
    );
    await instance.getTime();

    if (!mounted) return;
    Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: {
          'location': instance.location,
          'flag': instance.flag,
          'time': instance.time,
          'isDaytime': instance.isDaytime
        }
    );
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: const Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
