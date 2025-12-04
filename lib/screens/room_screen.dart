import 'package:flutter/material.dart';

class RoomScreen extends StatelessWidget {
  RoomScreen({super.key});

  final List<String> data = [
    "Room Tari",
    "Room Musik",
    "Room Lukis",
    "Room Teater",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            child: ListTile(
              title: Text(data[index]),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
