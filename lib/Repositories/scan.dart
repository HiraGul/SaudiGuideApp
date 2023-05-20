import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Models/land_mark_controller.dart';
import '../Models/landmark.dart';

class ScanObjectRepository {
  static Future<int> getScannedData({required String file}) async {
    try {
      var headers = {
        'Ocp-Apim-Subscription-Key': 'b57c280ccc414551a198ada606ae7629',
        'Content-Type': 'application/octet-stream'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://saudiguide.cognitiveservices.azure.com//vision/v3.1/describe'));
      request.files.add(await http.MultipartFile.fromPath('', file));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        LandMarkController.landMark = landMarkModel
            .fromJson(jsonDecode(await response.stream.bytesToString()));
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
