import 'dart:async';

import 'package:authenticator/src/data/local/theme_service.dart';
import 'package:authenticator/src/core/constant/color_constants.dart';
import 'package:authenticator/src/data/models/secure_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class OTPItemWidget extends StatefulWidget {
  SecureOtp secureOtp;

  OTPItemWidget({required this.secureOtp});

  @override
  State<StatefulWidget> createState() {
    return OTPItemWidgetState();
  }
}

class OTPItemWidgetState extends State<OTPItemWidget> {
  StreamController<String> _otpStreamController = StreamController();
  StreamController<int> _CircularSliderStreamController = StreamController();
  int _duration = 30;
  int _otpTimerDuration = 0;


  void _timerScheduler() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      _otpTimerDuration = ((DateTime.now().second < 30
          ? ((_duration - DateTime.now().second) - 1)
          : ((2 * _duration - DateTime.now().second) - 1)));
      _CircularSliderStreamController.sink.add(_otpTimerDuration);
      if (_otpTimerDuration == (_duration - 1)) {
        _otpStreamController.sink.add(widget.secureOtp.getOtp());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _otpStreamController.sink.add(widget.secureOtp.getOtp());
    _timerScheduler();
  }

  @override
  Widget build(BuildContext context) {
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
                  widget.secureOtp.accountName,
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
            max: (_duration - 1),
            initialValue: snapshot.data == null
                ? ((DateTime.now().second < 30
                        ? ((DateTime.now().second - _duration).abs() - 1)
                        : (DateTime.now().second - 2 * _duration).abs() - 1))
                    .toDouble()
                : snapshot.data!.toDouble(),
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
                        ? ((DateTime.now().second < 30
                                ? ((DateTime.now().second - _duration).abs() -
                                    1)
                                : (DateTime.now().second - 2 * _duration)
                                        .abs() -
                                    1))
                            .toString()
                        : snapshot.data!.toString()),
                customWidths:
                    CustomSliderWidths(trackWidth: 2, progressBarWidth: 2),
                customColors: CustomSliderColors(
                    trackColor: ThemeService().theme == ThemeMode.dark
                        ? AppColors.LigtDark
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
            '${snapshot.data.toString().substring(0, snapshot.data.toString().length ~/ 2)} ${snapshot.data.toString().substring(snapshot.data.toString().length ~/ 2)}',
            style: TextStyle(
                fontSize: 28, color: Colors.blue, fontWeight: FontWeight.w500),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _otpStreamController.close();
    _CircularSliderStreamController.close();
    super.dispose();
  }
}
