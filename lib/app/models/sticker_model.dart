import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class StickerModel {
  final int id;
  final String strickerCode;
  final String strickerName;
  final String strickerNumber;
  final String strickerImage;
  StickerModel({
    required this.id,
    required this.strickerCode,
    required this.strickerName,
    required this.strickerNumber,
    required this.strickerImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'stricker_code': strickerCode,
      'stricker_name': strickerName,
      'stricker_number': strickerNumber,
      'stricker_image': strickerImage,
    };
  }

  factory StickerModel.fromMap(Map<String, dynamic> map) {
    return StickerModel(
      id: map['id']?.toInt() ?? 0,
      strickerCode: map['stricker_code'] ?? '',
      strickerName: map['stricker_name'] ?? '',
      strickerNumber: map['stricker_number'] ?? '',
      strickerImage: map['stricker_image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StickerModel.fromJson(String source) => StickerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
