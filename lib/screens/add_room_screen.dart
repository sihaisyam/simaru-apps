import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simaru/controllers/room_controller.dart';

class AddRoomScreen extends StatelessWidget {
  AddRoomScreen({super.key});

  final RoomController controller = Get.find();

  final nameC = TextEditingController();
  final facultyC = TextEditingController();
  final capacityC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Ruangan")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameC,
              decoration: const InputDecoration(labelText: "Nama Ruangan"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: facultyC,
              decoration: const InputDecoration(labelText: "Fakultas"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: capacityC,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Kapasitas"),
            ),
            const SizedBox(height: 16),

            Obx(() => controller.pickedImage.value == null
                ? const Text("Belum pilih gambar")
                : Image.file(
                    controller.pickedImage.value!,
                    height: 150,
                  )),

            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: controller.pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Pilih Foto"),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                controller.createRoom(
                  name: nameC.text,
                  facultyName: facultyC.text,
                  capacity: capacityC.text,
                );
              },
              child: const Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
