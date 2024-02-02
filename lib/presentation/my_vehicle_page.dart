import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class MyVehiclePage extends StatelessWidget {
  final String parkingSlot;

  const MyVehiclePage({super.key, required this.parkingSlot});

  @override
  Widget build(BuildContext context) {
     String userName = "John Doe";
    int remainingTime = 120 * 60; // in seconds
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Vehicle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.directions_car,
              size: 100.0,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
             Text('Your car is parked in slot: $parkingSlot'),
            SizedBox(height: 10),
            CountdownTimer(
              endTime: DateTime.now().millisecondsSinceEpoch + remainingTime * 1000,
              textStyle: TextStyle(fontSize: 20, color: Colors.black),
              onEnd: () {
                // Handle when the countdown ends
                print('Countdown ended');
              },
            ),
            SizedBox(height: 10),
            Text('User Name: $userName'),
          ],
        ),
      ),
    );
  }
}
