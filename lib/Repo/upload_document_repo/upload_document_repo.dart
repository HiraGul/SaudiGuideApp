import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saudi_guide/Models/user_document_model.dart';

class UploadDocumentRepo {

  static var documentRef = FirebaseFirestore.instance
      .collection("user-documents");
  static List<Documents>  docList = [];
static Future<Stream<UserDocumentModel>?> getAllDocuments() async {
    try {
     return  documentRef
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots()
          .map((event) => UserDocumentModel.fromJson(event));
    } on Exception catch (e) {
      rethrow;
      // TODO
    }



  }
}
