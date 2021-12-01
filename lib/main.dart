import 'dart:convert';
import 'dart:io';

import 'package:authenticator/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'models/secure_otp.dart';

void main() async{

  // Directory appDocDir = await getApplicationDocumentsDirectory();
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

  runApp(MyApp());
}




