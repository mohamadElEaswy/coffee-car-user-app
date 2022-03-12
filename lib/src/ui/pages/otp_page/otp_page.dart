import 'package:flutter/material.dart';
import 'package:mk/src/core/navigation/navigation_methods.dart';
import 'package:mk/src/services/remote/firebase/auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../home/home_page.dart';

// ignore: must_be_immutable
class OTPPage extends StatelessWidget {
  OTPPage({Key? key, required this.phoneNumber}) : super(key: key);
  static const String route = '/otp_page';
  dynamic phoneNumber;
  late String otpCode;

  @override
  Widget build(BuildContext context) {
    // void showProgressIndicator(BuildContext context) {
    //   AlertDialog alertDialog = const AlertDialog(
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //     content: Center(
    //       child: CircularProgressIndicator(
    //         valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
    //       ),
    //     ),
    //   );
    //
    //   showDialog(
    //     barrierColor: Colors.white.withOpacity(0),
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (context) {
    //       return alertDialog;
    //     },
    //   );
    // }

    void onVerified() {
      final auth = Provider.of<AuthBase>(context, listen: false);
      auth.submitOTP(otpCode);
      RouteMethods.navigateAndChange(context: context, routeName: Home.route);
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'phone number:' + phoneNumber,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: PinCodeTextField(
                appContext: context,
                autoFocus: true,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                length: 6,
                obscureText: false,
                animationType: AnimationType.scale,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  borderWidth: 1,
                  activeColor: Colors.black,
                  inactiveColor: Colors.black,
                  inactiveFillColor: Colors.white,
                  activeFillColor: Colors.white,
                  selectedColor: Colors.blue,
                  selectedFillColor: Colors.white,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                onCompleted: (submittedCode) {
                  otpCode = submittedCode;
                  onVerified;
                },
                onChanged: (value) {},
              ),
            ),
            ElevatedButton(
              onPressed: onVerified,
              child: const Text(
                'Verify',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(110, 50),
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
