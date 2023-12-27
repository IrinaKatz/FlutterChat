import 'package:json_annotation/json_annotation.dart';
part 'image_model.g.dart';

@JsonSerializable()
class ExternalImage {
  int id;
  String previewURL;
  String webformatURL;
  String userImageURL;

  ExternalImage({required this.id, required this.previewURL, required this.webformatURL, required this.userImageURL});

  factory ExternalImage.fromJson(Map<String, dynamic> json) => _$NetworkImageFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkImageToJson(this);
}