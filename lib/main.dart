import 'dart:convert';

import 'package:authenticator/app.dart';
import 'package:authenticator/src/data/models/secure_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async{

  await _startSetup();

  runApp(App());
}

Future<void> _startSetup() async {
  await GetStorage.init();
  Hive.registerAdapter(SecureOtpAdapter());
  await Hive.initFlutter();

  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  var containsEncryptionKey = await secureStorage.containsKey(key: 'encryptionKey');
  List<int> encryptionKey;

  if(!containsEncryptionKey){
    encryptionKey = Hive.generateSecureKey();
    await secureStorage.write(key: 'encryptionKey', value: base64UrlEncode(encryptionKey));
  }

  encryptionKey = base64Url.decode((await secureStorage.read(key:'encryptionKey'))!);
  await Hive.openBox('totp',encryptionCipher: HiveAesCipher(encryptionKey));
}




