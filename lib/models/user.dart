class User {
  String username;
  String userType; // 'senior' or 'junior'
  Map<String, dynamic> preferences;

  User({
    required this.username,
    required this.userType,
    required this.preferences,
  });
}
