part of 'upload_document_cubit.dart';

@immutable
abstract class UploadDocumentState {}

class UploadDocumentInitial extends UploadDocumentState {}
class UploadDocumentLoading extends UploadDocumentState {}
class UploadDocumentLoaded extends UploadDocumentState {

  final UserDocumentModel model;

  UploadDocumentLoaded({required this.model});
}
class UploadDocumentError extends UploadDocumentState {
  final String error;

  UploadDocumentError({required this.error});
}
class UploadDocumentEmpty extends UploadDocumentState {}
