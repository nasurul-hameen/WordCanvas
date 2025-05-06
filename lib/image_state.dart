import 'package:equatable/equatable.dart';
import 'home.dart';

abstract class ImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final ImageUrlModel imageUrlModel;

  ImageLoaded(this.imageUrlModel);

  @override
  List<Object> get props => [imageUrlModel];
}

class ImageError extends ImageState {
  final String message;

  ImageError(this.message);

  @override
  List<Object> get props => [message];
}
