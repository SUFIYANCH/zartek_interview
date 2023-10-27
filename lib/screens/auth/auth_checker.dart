import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:levelx_interview/providers/provider.dart';
import 'package:levelx_interview/screens/auth/login_screen.dart';
import 'package:levelx_interview/screens/home_screen.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authCheckerProvider).when(
      data: (data) {
        Future.delayed(Duration.zero)
            .then((value) => ref.read(userDataProvider.notifier).state = data);

        return data == null ? const LoginScreen() : const HomeScreen();
      },
      error: (error, stackTrace) {
        return const Text("Something went wrong");
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
