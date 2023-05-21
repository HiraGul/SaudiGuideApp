part of 'text_to_image_cubit.dart';

@immutable
abstract class TextToImageState {}

class TextToImageInitial extends TextToImageState {}
class TextToImageLoading extends TextToImageState {}
class TextToImageLoaded extends TextToImageState {

  final Uint8List image ;

  TextToImageLoaded({required this.image});
}
class TextToImageError extends TextToImageState {
  final String error;

  TextToImageError({required this.error});
}
