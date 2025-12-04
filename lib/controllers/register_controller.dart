import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:simaru/screens/login_screen.dart';
import 'package:simaru/services/register_service.dart';

class RegisterController extends GetxController {
  final RegisterService _service = Get.put(RegisterService());
// Observable variables
  var isLoading = false.obs;

  // Text editing controllers untuk input email dan password
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  // Fungsi login
  Future<void> login() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final passwordConfirm = passwordConfirmController.text.trim();

    if(name.isEmpty) {
      Get.snackbar('Error', 'Nama harus diisi');
      return;
    } else if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email dan Password harus diisi');
      return;
    } else if (passwordConfirm != password) {
      Get.snackbar('Error', 'Password dan Confirmation Password harus sama!');
      return;
    }

    try {
      isLoading.value = true;

      final response = await _service.register(name, email, password, passwordConfirm);

      if (response != null && response['accessToken'] != null) {
        // Simpan token ke GetStorage atau SharedPreferences kalau mau
        Get.snackbar('Sukses', 'Register berhasil');
        // Navigasi ke halaman berikutnya
        Get.to(() => LoginScreen());
      } else {
        Get.snackbar('Gagal', 'Pendaftaran gagal');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}