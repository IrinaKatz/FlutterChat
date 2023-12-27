// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExternalImage _$NetworkImageFromJson(Map<String, dynamic> json) =>
    ExternalImage(
      id: json['id'] as int,
      previewURL: json['previewURL'] as String,
      webformatURL: json['webformatURL'] as String,
      userImageURL: json['userImageURL'] as String,
    );

Map<String, dynamic> _$NetworkImageToJson(ExternalImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'previewURL': instance.previewURL,
      'webformatURL': instance.webformatURL,
      'userImageURL': instance.userImageURL,
    };
