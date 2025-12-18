import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simaru/controllers/room_controller.dart';
import 'add_room_screen.dart';

class RoomScreen extends StatelessWidget {
  RoomScreen({super.key});

  final RoomController controller = Get.put(RoomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Ruangan")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddRoomScreen());
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.rooms.isEmpty) {
          return const Center(child: Text("Tidak ada data ruangan"));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.rooms.length,
          itemBuilder: (context, index) {
            final room = controller.rooms[index];

            return Card(
              elevation: 3,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    "http://127.0.0.1:8000${room['photo']}",
                    width: 55,
                    height: 55,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, obj, stack) =>
                        const Icon(Icons.image_not_supported, size: 40),
                  ),
                ),
                title: Text(room['name']),
                subtitle: Text(
                  "${room['faculty_name']} • Kapasitas ${room['capacity']}",
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
