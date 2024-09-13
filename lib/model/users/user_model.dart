import 'dart:convert';

import 'package:flutter/widgets.dart';

class UserModel {
  String? name;
  String? email;
  String? profileUrl;
  UserModel({
    this.name,
    this.email,
    this.profileUrl,
  });

  UserModel copyWith({
    ValueGetter<String?>? name,
    ValueGetter<String?>? email,
    ValueGetter<String?>? profileUrl,
  }) {
    return UserModel(
      name: name != null ? name() : this.name,
      email: email != null ? email() : this.email,
      profileUrl: profileUrl != null ? profileUrl() : this.profileUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'profileUrl': profileUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      profileUrl: map['profileUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(name: $name, email: $email, profileUrl: $profileUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.profileUrl == profileUrl;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ profileUrl.hashCode;
}
