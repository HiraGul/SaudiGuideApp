import 'dart:io';

import 'package:http/http.dart' as http;

class OCRRepository {
  static Future<int> getScannedData({required String city}) async {
    try {
      var headers = {
        'Ocp-Apim-Subscription-Key': 'b57c280ccc414551a198ada606ae7629',
        'Content-Type': 'application/octet-stream'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://saudiguide.cognitiveservices.azure.com//vision/v3.1/ocr'));
      request.files.add(await http.MultipartFile.fromPath('',
          '/Users/apple/Downloads/WhatsApp Image 2023-05-20 at 4.32.11 PM.jpeg'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }

      return response.statusCode;
    } on SocketException {
      return 501;
    } on Exception {
      return 0;
    }
  }
}
