import 'dart:async';

import 'package:authenticator/models/secure_otp.dart';

import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OTPItem extends StatefulWidget {
  final SecureOtp secureOtp;

  const OTPItem({Key? key, required this.secureOtp}) : super(key: key);

  @override
  State<StatefulWidget> createState() => OTPItemState();
}

class OTPItemState extends State<OTPItem> {
  late final SecureOtp secureOtp;
  final CountdownController _controller = CountdownController(autoStart: true);
  late String totp;

  @override
  void initState() {
    super.initState();
    secureOtp = widget.secureOtp;
    totp = secureOtp.getTotp();

    Timer.periodic(Duration(seconds: 60), (timer) {
      totp = secureOtp.getTotp();
    });
  }

  @override
  Widget build(BuildContext context) {
    var totpKey = secureOtp.secret;

    return Padding(
      padding: EdgeInsets.only(top: 8, right: 8, left: 8),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: EdgeInsets.only(top: 18, bottom: 18, left: 16, right: 16),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    secureOtp.accountName,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    '${totp.substring(0, totp.length ~/ 2)} ${totp.substring(totp.length ~/ 2)}',
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
