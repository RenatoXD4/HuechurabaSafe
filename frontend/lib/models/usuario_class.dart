class Usuario {
  int id;
  String username;
  String email;
  String password;
  int rolId;

  Usuario({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.rolId,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      rolId: json['rol_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'rol_id': rolId,
    };
  }
}