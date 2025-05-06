import 'dart:convert';

class ImageUrlModel {
  final String url;

  ImageUrlModel({required this.url});

  factory ImageUrlModel.fromJson(Map<String, dynamic> json) {
    return ImageUrlModel(
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}
