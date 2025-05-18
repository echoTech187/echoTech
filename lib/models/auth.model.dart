class Auth {
  final String userId;
  final String username;
  final String firstName;
  final String lastName;
  final String token;

  const Auth(
      {required this.userId,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.token});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': String userId,
        'username': String username,
        'firstName': String firstName,
        'lastName': String lastName,
        'token': String token
      } =>
        Auth(
          userId: userId,
          username: username,
          firstName: firstName,
          lastName: lastName,
          token: token,
        ),
      _ => throw const FormatException('Failed to load Auth.'),
    };
  }
}
