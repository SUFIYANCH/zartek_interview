import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:levelx_interview/model/api_model.dart';
import 'package:levelx_interview/service/api_service.dart';
import 'package:levelx_interview/service/auth_service.dart';

final apiProvider = FutureProvider<List<ApiModel>?>((ref) async {
  return ApiService().getDishData();
});

final userDataProvider = StateProvider<User?>((ref) {
  return null;
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authCheckerProvider = StreamProvider<User?>((ref) {
  return ref.read(authServiceProvider).authState;
});

final itemCountProvider = StateProvider<int>((ref) {
  return 0;
});
