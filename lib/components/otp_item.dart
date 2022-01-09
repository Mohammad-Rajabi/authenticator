import 'dart:async';

import 'package:authenticator/models/secure_otp.dart';
import 'package:authenticator/utility/theme_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class OTPItem extends StatelessWidget {
  SecureOtp secureOtp;
  int duration;
  late String _otp;
  late StreamController<String> _otpStreamController;
  late StreamController<int> _CircularSliderStreamController;

  OTPItem({required this.secureOtp, required this.duration});

  void _counterTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      _CircularSliderStreamController.sink.add(DateTime.now().second);
    });
  }

  void _getOtpTimer() {
    Timer.periodic(Duration(seconds: (60 - (DateTime.now().second))),
        (timer) async {
      _otpStreamController.sink.add(secureOtp.getOtp());
    });
  }

  @override
  Widget build(BuildContext context) {
    _otp = secureOtp.getOtp();
    _otpStreamController = StreamController();
    _CircularSliderStreamController = StreamController();
    _otpStreamController.sink.add(_otp);

    _counterTimer();
    _getOtpTimer();

    return Padding(
      padding: EdgeInsets.only(top: 8, right: 8, left: 8),
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
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _buildOtpStream(),
                _buildCounterStream(),
              ]),
              Divider(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<int> _buildCounterStream() {
    return StreamBuilder(
      stream: _CircularSliderStreamController.stream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return Container(
          height: 32,
          width: 32,
          child: SleekCircularSlider(
            min: 0,
            max: (duration - 1),
            initialValue: snapshot.data == null
                ? ((duration - 1) - DateTime.now().second).toDouble()
                : ((duration - 1) - snapshot.data!).toDouble(),
            appearance: CircularSliderAppearance(
                size: 32,
                startAngle: 270,
                angleRange: 360,
                counterClockwise: true,
                animationEnabled: false,
                infoProperties: InfoProperties(
                    mainLabelStyle:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    modifier: (double value) => snapshot.data == null
                        ? ((duration - 1) - DateTime.now().second).toString()
                        : ((duration - 1) - snapshot.data!).toString()),
                customWidths:
                    CustomSliderWidths(trackWidth: 2, progressBarWidth: 2),
                customColors: CustomSliderColors(
                    trackColor: ThemeService().theme == ThemeMode.dark
                        ? Color(0xff202124)
                        : Colors.white,
                    progressBarColor: Colors.blue)),
          ),
        );
      },
    );
  }

  StreamBuilder<String> _buildOtpStream() {
    return StreamBuilder<String>(
      stream: _otpStreamController.stream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Text(
            '${snapshot.data.toString().substring(0, _otp.length ~/ 2)} ${snapshot.data.toString().substring(_otp.length ~/ 2)}',
            style: TextStyle(
                fontSize: 28, color: Colors.blue, fontWeight: FontWeight.w500),
          ),
        );
      },
    );
  }
}
