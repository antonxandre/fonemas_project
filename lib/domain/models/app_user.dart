class AppUser {
  final String id;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String role; // 'patient' or 'admin'

  const AppUser({
    required this.id,
    this.email,
    this.displayName,
    this.photoUrl,
    this.role = 'patient',
  });

  factory AppUser.empty() {
    return const AppUser(id: '');
  }

  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => id.isNotEmpty;

  AppUser copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    String? role,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      role: role ?? this.role,
    );
  }
}
