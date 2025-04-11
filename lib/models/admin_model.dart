class Admin {
  final int adminId;
  final String name;
  final String email;
  final String role;
  final String? adminProfilePicture;

  Admin({
    required this.adminId,
    required this.name,
    required this.email,
    required this.role,
    this.adminProfilePicture,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      adminId: json['admin_id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      adminProfilePicture: json['admin_profile_picture'],
    );
  }
}