// my_vehicle_page.dart

import 'package:flutter/material.dart';

class MyVehiclePage extends StatelessWidget {
  final String parkingSlot;

  const MyVehiclePage({super.key, required this.parkingSlot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Vehicle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your car is parked in slot: $parkingSlot'),
            // Add more details or UI elements as needed
          ],
        ),
      ),
    );
  }
}
