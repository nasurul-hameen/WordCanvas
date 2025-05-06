import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart';
import 'image_event.dart';
import 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<FetchImage>(_onFetchImage);
  }

  Future<void> _onFetchImage(FetchImage event, Emitter<ImageState> emit) async {
    emit(ImageLoading());
    try {
      final response = await http.post(
        Uri.parse('https://ai-text-to-image-generator-api.p.rapidapi.com/realistic'),
        headers: {
          'x-rapidapi-host': 'ai-text-to-image-generator-api.p.rapidapi.com',
          'x-rapidapi-key': '2cdb8bf700mshad375e0d52fe621p17c126jsnb2c8b73e2a66',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"inputs": event.prompt}),
      );

      if (response.statusCode == 200) {
        final imageUrlModel = ImageUrlModel.fromJson(json.decode(response.body));
        emit(ImageLoaded(imageUrlModel));
      } else {
        emit(ImageError('Failed to load image. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ImageError('Error fetching image: $e'));
    }
  }
}
