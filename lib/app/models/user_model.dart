import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  final int id;
  final String  name;
  final String email;
  final String token;
//total figurinhas do album
  final int totalAlbum;
  //total figurinhas que eu tenho no album
  final int totalStickers;
  //total figurinhas repetidas
  final int totalDuplicates;
  //total de figurinhas que faltam para completar o album
  final int totalComplete;
  //percentual de conclusão do album
  final int totalCompletePercent;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.totalAlbum,
    required this.totalStickers,
    required this.totalDuplicates,
    required this.totalComplete,
    required this.totalCompletePercent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'total_album': totalAlbum,
      'total_stickers': totalStickers,//Camel case "_s" para snack case "S"
      'total_duplicates': totalDuplicates,
      'total_complete': totalComplete,
      'total_complete_percent': totalCompletePercent,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
      totalAlbum: map['total_album'] ?? 0,
      totalStickers: map['total_stickers'] ?? 0,
      totalDuplicates: map['total_duplicates'] ?? 0,
      totalComplete: map['total_complete'] ?? 0,
      totalCompletePercent: map['total_complete_percent'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
