import 'dart:async';

import 'package:authenticator/models/secure_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class OTPItem extends StatelessWidget {
  late String _otp;
  late StreamController<String> _otpStreamController;
  late StreamController<int> _CircularSliderStreamController;
  late final SecureOtp secureOtp;
  late int duration;

  OTPItem({required this.secureOtp, required this.duration});

  @override
  Widget build(BuildContext context) {
    _otp = secureOtp.getOtp();
    _otpStreamController = StreamController();
    _CircularSliderStreamController = StreamController();
    _otpStreamController.sink.add(_otp);

    Timer.periodic(Duration(seconds: (duration - (DateTime.now().second))),
        (timer) async {
      _otpStreamController.sink.add(secureOtp.getOtp());
    });

    Timer.periodic(Duration(seconds: 1), (timer) async {
      _CircularSliderStreamController.sink
          .add(DateTime.now().second.toInt());
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
                        stream: _otpStreamController.stream,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              '${snapshot.data.toString().substring(0, _otp.length ~/ 2)} ${snapshot.data.toString().substring(_otp.length ~/ 2)}',
                              style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        },
                      ),
                      StreamBuilder(
                        stream: _CircularSliderStreamController.stream,
                        builder: (BuildContext context,
                            AsyncSnapshot<int> snapshot) {
                          return SleekCircularSlider(
                            min: 0,
                            max: (duration-1),
                            initialValue:
                                ((duration-1) - snapshot.data!).toDouble(),
                            appearance: CircularSliderAppearance(
                                size: 32,
                                startAngle: 270,
                                angleRange: 360,
                                counterClockwise: true,
                                animationEnabled: false,
                                infoProperties: InfoProperties(
                                    mainLabelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                    modifier: (double value) =>
                                        ((duration-1) - snapshot.data!)
                                            .toString()),
                                customWidths: CustomSliderWidths(
                                    trackWidth: 2, progressBarWidth: 2),
                                customColors: CustomSliderColors(
                                    trackColor: Colors.white,
                                    progressBarColor: Colors.blue)),
                          );
                        },
                      ),
                      // CircularCountDownTimer(
                      //   height: 24,
                      //   width: 24,
                      //   duration: (duration - (DateTime.now().second)),
                      //   strokeWidth: 2,
                      //   isReverse: true,
                      //   controller: _countDownController,
                      //   ringColor: Colors.blue,
                      //   fillColor: Colors.white,
                      //   textStyle: TextStyle(fontSize: 12),
                      //   textFormat: CountdownTextFormat.S,
                      //   isTimerTextShown: true,
                      //   autoStart: true,
                      //   onComplete: () => _countDownController.restart(),
                      // ),
                      //
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
