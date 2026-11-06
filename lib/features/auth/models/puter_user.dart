class PuterUser {
  final String username;
  final String? uuid;
  final String? email;
  final bool isTemporary;

  PuterUser({
    required this.username,
    this.uuid,
    this.email,
    this.isTemporary = false,
  });

  factory PuterUser.fromJson(Map<String, dynamic> json) {
    return PuterUser(
      username: json['username'] as String? ?? 'Puter User',
      uuid: json['uuid'] as String? ?? json['id'] as String?,
      email: json['email'] as String?,
      isTemporary: json['is_temporary'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'uuid': uuid,
      'email': email,
      'is_temporary': isTemporary,
    };
  }
}
