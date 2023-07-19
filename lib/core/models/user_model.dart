class User {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNum;
  final String email;
  final String role;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNum,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      id: jsonData['id'],
      firstName: jsonData['first_name'],
      lastName: jsonData['last_name'],
      phoneNum: jsonData['phone_num'],
      email: jsonData['email'],
      role: jsonData['role'],
    );
  }
}
