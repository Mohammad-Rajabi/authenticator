import 'dart:async';

import 'package:authenticator/src/data/models/secure_otp.dart';
import 'package:hive/hive.dart';

class DBHandler {
  static final DBHandler _instance = DBHandler._internal();

  factory DBHandler() => _instance;

  DBHandler._internal();

  final _totpBox = Hive.box('totp');

  Box get totpBox=> _totpBox;

  void saveTotp(SecureOtp totp) {
    _totpBox.put(totp.secret, totp);
  }

  void delete(SecureOtp totp) {
    _totpBox.delete(totp);
  }

}
