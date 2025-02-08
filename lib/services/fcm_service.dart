import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class FCMService {
  FCMService._();
  static FCMService fcmService = FCMService._();

  Future<String> getAccessToken() async {
    String jsonPath = "assets/json/fcm.json";

    String json = await rootBundle.loadString(jsonPath);

    var accCredential = ServiceAccountCredentials.fromJson(json);
    List<String> scopes = [
      //from google cloud api
      "https://www.googleapis.com/auth/firebase.messaging",
    ];

    var accessToken = await clientViaServiceAccount(accCredential, scopes);

    return accessToken.credentials.accessToken.data;
  }

  Future<void> sendFCM({
    required String title,
    required String body,
    required String token,
  }) async {
    String accessToken = await getAccessToken();

    String apiKey =
        "https://fcm.googleapis.com/v1/projects/chat-app-71e8f/messages:send";

    Map<String, dynamic> apiBody = {
      'message': {
        'token': token,
        'notification': {
          'title': title,
          'body': body,
        },
        'data': {
          'age': '22',
          'school': 'PQR',
        }
      },
    };

    http.Response res = await http.post(
      Uri.parse(apiKey),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(apiBody),
    );

    if (res.statusCode == 200) {
      log('Notification send successfully--------${res.body}');
    } else {
      log('${res.body}');
    }
  }
}
