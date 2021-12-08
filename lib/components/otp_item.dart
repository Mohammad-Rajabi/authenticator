import 'dart:async';

import 'package:authenticator/models/secure_otp.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class OTPItem extends StatelessWidget {
  late String _totp;
  late StreamController<String> _streamController;
  late final SecureOtp secureOtp;
  late int duration;
  late CountDownController _countDownController;

  OTPItem({required this.secureOtp, required this.duration});

  @override
  Widget build(BuildContext context) {
    _totp = secureOtp.getTotp();
    _streamController = StreamController();
    _countDownController =  CountDownController();
    _streamController.sink.add(_totp);

    Timer.periodic(Duration(seconds: duration), (timer) async{
      _streamController.sink.add(secureOtp.getTotp());
    });

    return Padding(
      padding: EdgeInsets.only(top: 8, right: 8, left: 8),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        stream: _streamController.stream,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          return Text(
                            '${snapshot.data.toString().substring(0, _totp.length ~/ 2)} ${snapshot.data.toString().substring(_totp.length ~/ 2)}',
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          );
                        },
                      ),
                      CircularCountDownTimer(
                        height: 24,
                        width: 24,
                        initialDuration: 0,
                        duration: duration,
                        strokeWidth: 2,
                        isReverse: true,
                        controller: _countDownController,
                        ringColor: Colors.blue,
                        fillColor: Colors.white,
                        textStyle: TextStyle(fontSize: 12),
                        textFormat: CountdownTextFormat.S,
                        isTimerTextShown: true,
                        autoStart: true,
                        onComplete: ()=>_countDownController.restart(),
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
