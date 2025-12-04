import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:simaru/screens/home_screen.dart';
import 'package:simaru/services/login_service.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final LoginService _service = Get.put(LoginService());
  final box = GetStorage();
// Observable variables
  var isLoading = false.obs;

  // Text editing controllers untuk input email dan password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Fungsi login
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email dan Password harus diisi');
      return;
    }

    try {
      isLoading.value = true;

      final response = await _service.login(email, password);

      if (response != null && response['accessToken'] != null) {
        // Simpan token ke GetStorage atau SharedPreferences kalau mau
        final token = response['accessToken'];
        box.write('accessToken', token);
        // Navigasi ke halaman berikutnya
        // Get.offAllNamed('/home');
        Get.offAll(() => HomeScreen());
        Get.snackbar('Sukses', 'Login berhasil');

      } else {
        Get.snackbar('Gagal', 'Email atau password salah');
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