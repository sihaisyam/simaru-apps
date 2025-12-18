import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:simaru/services/room_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_connect/connect.dart';
import 'package:image_picker/image_picker.dart';

class RoomController extends GetxController {
  final RoomService _service = Get.put(RoomService());
  final box = GetStorage();
// Observable variables
  var isLoading = false.obs;

  var pickedImage = Rx<File?>(null);

  final picker = ImagePicker();
  var rooms = <dynamic>[].obs;

  // Text editing controllers untuk input search dan status
  final searchController = TextEditingController();
  final statusController = TextEditingController();

  @override
  void onInit() {
    fetchRooms();
    super.onInit();
  }

   Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = File(image.path);
    }
  }

  Future<void> createRoom({
    required String name,
    required String facultyName,
    required String capacity,
  }) async {
    if (pickedImage.value == null) {
      Get.snackbar("Error", "Foto wajib diisi");
      return;
    }

    isLoading(true);

    final form = FormData({
      'name': name,
      'faculty_name': facultyName,
      'capacity': capacity,
      'photo': MultipartFile(
        pickedImage.value!,
        filename: pickedImage.value!.path.split('/').last,
      ),
    });

    final response = await _service.createRoom(form, box.read('accessToken'));

    isLoading(false);

    if (response.isOk) {
      Get.back();
      Get.snackbar("Sukses", "Ruangan berhasil ditambahkan");
      fetchRooms(); // refresh list
    } else {
      Get.snackbar("Error", response.statusText ?? "Gagal menambah ruangan");
    }
  }

  // Fungsi Room
  Future<void> fetchRooms() async {
    final search = searchController.text.trim();
    final status = statusController.text.trim();

    try {
      isLoading.value = true;

      final response = await _service.getRoom(box.read('accessToken'),search, status);
      if (response != null) {
        List data = response['data'];

        rooms.value = data;
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }
}