import 'dart:convert';

AppUser userModelFromJson(String str) => AppUser.fromJson(json.decode(str));
String userModelToJson(AppUser data) => json.encode(data.toJson());

class AppUser {
  static int _idCounter = 0;
  int id;
  String name;
  String password;
  String email;
  String avatarURL;

  AppUser({
    required this.name,
    required this.password,
    required this.email,
    required this.avatarURL,
  }) : id = ++_idCounter;

  String get lastName {
    List<String> nameParts = name.split(' ');
    return nameParts.isNotEmpty ? nameParts.last : '';
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, avatarURL: $avatarURL}';
  }

  // AppUser fromFirebaseUser(User firebaseUser) {
  //   return AppUser(
  //     name: firebaseUser.displayName ?? '',
  //     email: firebaseUser.email ?? '',
  //     avatarURL: firebaseUser.photoURL ?? '',
  //     password: '',
  //   );
  // }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      name: json['name'],
      password:
          '', // Password should not be stored in JSON for security reasons
      email: json['email'],
      avatarURL: json['avatarURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarURL': avatarURL,
    };
  }
}
