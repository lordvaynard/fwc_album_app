import '../../models/register_user_model.dart';

abstract class AuthRepository {//orientado a interface
  Future<void> register(RegisterUserModel registerModel);
  Future<String> login({required String email, required String password});
  Future<void> logout();
}