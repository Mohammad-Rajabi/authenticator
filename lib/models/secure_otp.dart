import 'package:hive/hive.dart';
import 'package:otp/otp.dart';
import 'package:validated/validated.dart' as validate;
import 'package:base32/base32.dart';

@HiveType(typeId: 0)
class SecureOtp {
  @HiveField(0)
  final String algorithm;

  @HiveField(1)
  final int digits;

  @HiveField(2)
  final int interval;

  @HiveField(3)
  String secret;

  @HiveField(4)
  final String accountName;

  SecureOtp(
      {required this.secret,
      required this.accountName,
      this.algorithm = 'SHA256',
      this.digits = 6,
      this.interval = 60});

  String getOtp() {
    if (validate.isAlpha(secret)) {
      if (!validate.isBase32(secret)) {
        secret = base32.encodeString(secret);
      }
    }
    // if(validate.isAlphanumeric(secret)){
    //   if (!validate.isBase32(secret)) {
    //     secret = base32.encodeHexString(secret);
    //   }
    // }
    return OTP.generateTOTPCodeString(
        secret, DateTime.now().millisecondsSinceEpoch,interval: interval,
        algorithm: getAlgorithm(algorithm));
  }

  Algorithm getAlgorithm(String algorithm) {
    switch (algorithm) {
      case 'SHA256':
        return Algorithm.SHA256;
      case 'SHA512':
        return Algorithm.SHA512;
      case 'SHA1':
        return Algorithm.SHA1;
      default:
        return Algorithm.SHA256;
    }
  }
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SecureOtpAdapter extends TypeAdapter<SecureOtp> {
  @override
  final int typeId = 0;

  @override
  SecureOtp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SecureOtp(
      secret: fields[3] as String,
      accountName: fields[4] as String,
      algorithm: fields[0] as String,
      digits: fields[1] as int,
      interval: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SecureOtp obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.algorithm)
      ..writeByte(1)
      ..write(obj.digits)
      ..writeByte(2)
      ..write(obj.interval)
      ..writeByte(3)
      ..write(obj.secret)
      ..writeByte(4)
      ..write(obj.accountName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SecureOtpAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
