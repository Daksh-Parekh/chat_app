import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class APIService {
  APIService._();
  static APIService apiService = APIService._();
  String userImgURL = '';
  Future<String> uploadUserImg({required File image}) async {
    Uri url = Uri.parse("https://api.imgur.com/3/image");

    Uint8List imgList = await image.readAsBytes();

    String baseUserImg = base64Encode(imgList);

    http.Response response = await http.post(
      url,
      headers: {
        'Authorization': 'Client-ID 64f6ac921895c81',
      },
      body: baseUserImg,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      log('${data}');
      userImgURL = data['data']['link'];
    }

    return userImgURL;
  }
}
