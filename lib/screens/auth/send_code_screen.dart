import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:levelx_interview/screens/auth/verification_screen.dart';
import 'package:levelx_interview/utils/responsive.dart';

class SendCodePage extends StatefulWidget {
  static String verify = '';
  const SendCodePage({super.key});

  @override
  State<SendCodePage> createState() => _SendCodePageState();
}

class _SendCodePageState extends State<SendCodePage> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: R.rw(20, context)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              TextField(
                style: TextStyle(fontSize: R.rw(20, context)),
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(R.rw(16, context)),
                    prefixText: '+91',
                    prefixStyle: TextStyle(
                        color: Colors.black, fontSize: R.rw(20, context)),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(R.rw(10, context))),
                    )),
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
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '+91${phoneController.text}',
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        SendCodePage.verify = verificationId;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VerificationPage(),
                            ));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  child: const Text('Send the code'))
            ],
          ),
        ),
      ),
    );
  }
}
