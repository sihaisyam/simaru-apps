import 'dart:io';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';

class RoomService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://localhost:8000/api';
    // httpClient.defaultContentType = 'application/json';
    super.onInit();
  }

  Future<Response> getRoom(String token, String search, String status) {
    return get(
      '/rooms?search=$search&status=$status',
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<Response> createRoom(FormData payload, String token) {
    return post(
      '/rooms',
      payload,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }
}
