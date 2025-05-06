import 'package:equatable/equatable.dart';

abstract class ImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchImage extends ImageEvent {
  final String prompt;

  FetchImage(this.prompt);

  @override
  List<Object> get props => [prompt];
}
