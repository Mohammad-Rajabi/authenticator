import 'dart:async';

import 'package:authenticator/models/secure_otp.dart';
import 'package:flutter/material.dart';

class OTPItem extends StatelessWidget {
  late final SecureOtp secureOtp;
  late String totp;
  late StreamController<String> streamController;

  OTPItem({required this.secureOtp});

  @override
  Widget build(BuildContext context) {
    totp = secureOtp.getTotp();
    streamController = StreamController();
    streamController.sink.add(totp);

    Timer.periodic(Duration(seconds: 60), (timer) {
      streamController.sink.add(secureOtp.getTotp());
    });

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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamBuilder<String>(
                        stream: streamController.stream,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          return Text(
                            '${snapshot.data.toString().substring(0, totp.length ~/ 2)} ${snapshot.data.toString().substring(totp.length ~/ 2)}',
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          );
                        },
                      ),
                      TweenAnimationBuilder(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: Duration(seconds: 60),
                          builder: (BuildContext context, double value, child) {
                            return ShaderMask(
                              shaderCallback: (rect) {
                                return SweepGradient(

                                        stops: [value, value],
                                        colors: [Colors.blue, Colors.white])
                                    .createShader(rect);
                              },
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                              ),
                            );
                          })
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
