class AppUser {
  final String name;
  final String email;
  final DateTime birthdate;
  final String role; // Player | Facility owner

  const AppUser({
    required this.name,
    required this.email,
    required this.birthdate,
    required this.role,
  });

  AppUser copyWith({String? name}) => AppUser(
        name: name ?? this.name,
        email: email,
        birthdate: birthdate,
        role: role,
      );
}
