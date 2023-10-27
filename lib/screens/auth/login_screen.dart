import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:levelx_interview/screens/auth/send_code_screen.dart';
import 'package:levelx_interview/service/auth_service.dart';
import 'package:levelx_interview/utils/responsive.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
              height: R.rh(600, context),
              child: Image.asset("assets/firebase.png")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                fixedSize: Size(R.rw(300, context), R.rh(50, context))),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return const Center(child: CircularProgressIndicator());
                },
              );
              await AuthService.signInWithGoogle().then((value) {
                Navigator.pop(context);
              });
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: R.rw(12, context),
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    "assets/googlelogo.png",
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                Text(
                  'Google',
                  style: TextStyle(fontSize: R.rw(18, context)),
                ),
                const Spacer(
                  flex: 3,
                )
              ],
            ),
          ),
          SizedBox(
            height: R.rh(14, context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: const StadiumBorder(),
                fixedSize: Size(R.rw(300, context), R.rh(50, context))),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SendCodePage(),
                  ));
            },
            child: Row(
              children: [
                const Icon(Icons.call),
                const Spacer(
                  flex: 2,
                ),
                Text(
                  'Phone',
                  style: TextStyle(fontSize: R.rw(18, context)),
                ),
                const Spacer(
                  flex: 3,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
