import 'package:hive/hive.dart';

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
      this.algorithm = 'SHA1',
      this.digits = 6,
      this.interval = 60});

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
