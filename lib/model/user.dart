class User {
  final int userid;
  final String email;
  final String name;
  final String username;
  final String password;
  final String phone;

  User({
    required this.userid,
    required this.email,
    required this.name,
    required this.username,
    required this.password,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userid: json['userid'],
      email: json['email'],
      name: json['name'],
      username: json['username'],
      password: json['password'],
      phone: json['phone'],
    );
  }
}

