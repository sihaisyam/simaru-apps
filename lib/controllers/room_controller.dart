import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:simaru/services/room_service.dart';
import 'package:get_storage/get_storage.dart';

class RoomController extends GetxController {
  final RoomService _service = Get.put(RoomService());
  final box = GetStorage();
// Observable variables
  var isLoading = false.obs;
  var rooms = <dynamic>[].obs;

  // Text editing controllers untuk input search dan status
  final searchController = TextEditingController();
  final statusController = TextEditingController();

  @override
  void onInit() {
    fetchRooms();
    super.onInit();
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