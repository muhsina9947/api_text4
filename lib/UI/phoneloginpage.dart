import 'package:api_text4/UI/translatorscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Phoneloginpage extends StatefulWidget {
  const Phoneloginpage({super.key});

  @override
  State<Phoneloginpage> createState() => _PhoneloginpageState();
}

class _PhoneloginpageState extends State<Phoneloginpage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  ConfirmationResult? confirmationResult;

  /// ✅ SEND OTP
  Future<void> sendOTP() async {
    if (phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter phone number")),
      );
      return;
    }

    try {
      confirmationResult = await FirebaseAuth.instance
          .signInWithPhoneNumber(phoneController.text);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("OTP Sent")));
    } catch (e) {
      print("Send OTP Error: $e");
    }
  }

  /// ✅ VERIFY OTP
  Future<void> verifyOTP() async {
    if (otpController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter OTP")),
      );
      return;
    }

    try {
      await confirmationResult!.confirm(otpController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TranslatorScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String msg = "Login Failed";

      if (e.code == 'invalid-verification-code') {
        msg = "Invalid OTP";
      } else if (e.code == 'session-expired') {
        msg = "OTP expired";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg)));
    } catch (e) {
      print("Verify Error: $e");
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Phone Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// PHONE
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                hintText: "Enter phone (+91...)",
              ),
            ),

            const SizedBox(height: 10),

            /// SEND OTP
            ElevatedButton(
              onPressed: sendOTP,
              child: const Text("Send OTP"),
            ),

            const SizedBox(height: 20),

            /// OTP
            TextField(
              controller: otpController,
              decoration: const InputDecoration(
                hintText: "Enter OTP",
              ),
            ),

            const SizedBox(height: 10),

            /// VERIFY
            ElevatedButton(
              onPressed: verifyOTP,
              child: const Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}