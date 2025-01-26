class User {
  final String civilId;

  User({required this.civilId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      civilId: json['civilId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'civilId': civilId,
    };
  }
}
