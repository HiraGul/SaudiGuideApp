import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saudi_guide/Models/web_scrap_list_model.dart';

class WebScrapListRepo{



 static Future<Stream<List<WebScrapListModel>>?> getData()async{

  try {
    return FirebaseFirestore.instance.collection('web-scrap').doc(FirebaseAuth.instance.currentUser?.uid).collection('user-doc').
     snapshots().map((event) => event.docs.map((data) => WebScrapListModel.fromJson(data, data.id)).toList());
  } on Exception catch (e) {

    rethrow;
    // TODO
  }



 }


 static deleteField({required String docId}) async {

   await  FirebaseFirestore.instance.collection('web-scrap').doc(FirebaseAuth.instance.currentUser?.uid).collection('user-doc').doc(docId).delete();
 }
}


