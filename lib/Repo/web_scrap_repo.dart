import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class WebScrapRepo {
  static var scrapData = '';

  static Future<int> getScrap({
    required String url,
    required String websiteName,
    bool? isPredefined = false,
  }) async {
    scrapData = '';
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://askodel.jmminnovations.com/Scrap'));
      request.fields.addAll({'url': url});

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = json.decode(await response.stream.bytesToString());
        //   print(data['data']);
        scrapData = data['data'];
        print(data['data']);

        try {
          storeInDb(
            data: data['data'],
            websiteName: websiteName,
            url: url,
            isPredefined: isPredefined,
          );
        } catch (e) {
          rethrow;
        }
        return response.statusCode;
      } else {
        print(response.reasonPhrase);
        return response.statusCode;
      }
    } on Exception {
      rethrow;
      // TODO
    }
  }
}

Future<bool> storeInDb(
    {required String data,
    required String websiteName,
    required String url,
    bool? isPredefined = false}) async {
  var ref = FirebaseFirestore.instance
      .collection('web-scrap')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('user-doc');

  try {
    await ref.add({
      "data": data,
      "website_name": websiteName,
      "is_predefined": isPredefined,
      "url": url,
      "date_time": DateTime.now(),
    });
    return true;
  } on Exception {
// Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);

    rethrow;
// TODO
  }
}
