import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:isar/isar.dart';
import '../domain/app_user.dart';

// SHA-256 + random salt — upgrade to Argon2 when a backend is added.
abstract class AuthRepository {
  Future<AppUser?> login(String email, String password);
  Future<AppUser?> findById(int id);
  Future<void> seedDefaultAdmin();
}

class LocalAuthRepository implements AuthRepository {
  final Isar isar;
  LocalAuthRepository({required this.isar});

  @override
  Future<AppUser?> login(String email, String password) async {
    final user = await isar.appUsers
        .filter()
        .emailEqualTo(email.toLowerCase().trim())
        .findFirst();
    if (user == null) return null;
    final hash = _hash(password, user.passwordSalt);
    return hash == user.passwordHash ? user : null;
  }

  @override
  Future<AppUser?> findById(int id) => isar.appUsers.get(id);

  @override
  Future<void> seedDefaultAdmin() async {
    final existing = await isar.appUsers.count();
    if (existing > 0) return;
    final salt = DateTime.now().microsecondsSinceEpoch.toString();
    final admin = AppUser()
      ..email = 'admin@wms.pro'
      ..name = 'Admin'
      ..passwordSalt = salt
      ..passwordHash = _hash('Admin@123', salt)
      ..role = UserRole.admin
      ..createdAt = DateTime.now();
    await isar.writeTxn(() => isar.appUsers.put(admin));
  }

  String _hash(String password, String salt) {
    final bytes = utf8.encode(password + salt);
    return sha256.convert(bytes).toString();
  }
}
