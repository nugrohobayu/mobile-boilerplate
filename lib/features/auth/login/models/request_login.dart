class RequestLogin {
  final String username;
  final String password;

  RequestLogin({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
