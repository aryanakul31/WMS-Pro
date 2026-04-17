import 'package:isar/isar.dart';

part 'app_user.g.dart';

enum UserRole { admin, vendor }

@Collection()
class AppUser {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String email;

  late String name;
  late String passwordHash;
  late String passwordSalt;

  @Enumerated(EnumType.name)
  late UserRole role;

  late DateTime createdAt;

  AppUser copyWith({
    String? email,
    String? name,
    String? passwordHash,
    String? passwordSalt,
    UserRole? role,
  }) {
    final u = AppUser()
      ..id = id
      ..email = email ?? this.email
      ..name = name ?? this.name
      ..passwordHash = passwordHash ?? this.passwordHash
      ..passwordSalt = passwordSalt ?? this.passwordSalt
      ..role = role ?? this.role
      ..createdAt = createdAt;
    return u;
  }
}
