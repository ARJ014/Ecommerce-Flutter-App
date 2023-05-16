import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String name;
  final String id;
  final String email;
  final String password;
  final String token;
  final String type;
  final String address;
  final List<dynamic> cart;
  User(
      {required this.name,
      required this.id,
      required this.email,
      required this.password,
      required this.token,
      required this.type,
      required this.address,
      required this.cart});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'email': email,
      'password': password,
      'token': token,
      'type': type,
      'address': address,
      'cart': cart,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      name: map['name'] as String,
      id: map['_id'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      token: map['token'] as String,
      type: map['type'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? name,
    String? id,
    String? email,
    String? password,
    String? token,
    String? type,
    String? address,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }
}
