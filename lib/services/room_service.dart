import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' show Client;

class RoomService extends GetxService {
  Client client = Client();

  Future<dynamic> getRoom(String token, String search, String status) async {
    try {
      final response = await client.get(
        Uri.parse('http://127.0.0.1:8000/api/rooms?search=' + search + '&status=' + status),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future<dynamic> createRoom(FormData payload, String token) async {
    try {
      final response = await client.post(
        Uri.parse('http://127.0.0.1:8000/api/rooms'),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      return response;
    } catch (e) {
      return throw Exception(e);
    }
  }
}
