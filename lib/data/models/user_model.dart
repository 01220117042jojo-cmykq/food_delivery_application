class UserModel {
  final String uId;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String? imageUrl;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      imageUrl: map['imageUrl'],
    );
  }
}
