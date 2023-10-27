import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:levelx_interview/screens/auth/send_code_screen.dart';
import 'package:levelx_interview/utils/responsive.dart';
import 'package:pinput/pinput.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: R.rw(20, context)),
            child: Column(
              children: [
                Image.asset(
                  'assets/login.png',
                  height: R.rh(250, context),
                ),
                SizedBox(
                  height: R.rh(20, context),
                ),
                Text(
                  'Phone Verification',
                  style: TextStyle(
                      fontSize: R.rw(26, context), fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: R.rh(8, context),
                ),
                Text(
                  'We need to register your phone before getting started!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: R.rw(16, context), fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: R.rh(30, context),
                ),
                Pinput(
                  length: 6,
                  showCursor: true,
                  onChanged: (value) {
                    code = value;
                  },
                  defaultPinTheme: PinTheme(
                      height: R.rh(55, context),
                      width: R.rw(45, context),
                      textStyle: TextStyle(
                          fontSize: R.rw(24, context),
                          fontWeight: FontWeight.bold),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius:
                              BorderRadius.circular(R.rw(10, context)))),
                ),
                SizedBox(
                  height: R.rh(20, context),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 8, 12, 140),
                      foregroundColor: Theme.of(context).canvasColor,
                      fixedSize: Size(R.rw(375, context), R.rh(50, context))),
                  onPressed: () async {
                    try {
                      // Create a PhoneAuthCredential with the code
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: SendCodePage.verify,
                              smsCode: code);
                      log("phone User:$credential");

                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      log('Wrong otp');
                    }
                  },
                  child: const Text('Verify phone number'),
                ),
                SizedBox(
                  height: R.rh(10, context),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 8, 12, 140)),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SendCodePage(),
                          ),
                          (route) => false);
                    },
                    child: const Text('Edit Phone Number?'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
