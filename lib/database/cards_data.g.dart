// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cards_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardDataAdapter extends TypeAdapter<CardData> {
  @override
  final int typeId = 1;

  @override
  CardData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardData(
      cardId: fields[0] as String,
      bankName: fields[1] as String,
      fullName: fields[2] as String,
      cardNumber: fields[3] as String,
      cvv: fields[4] as String,
      validThru: fields[5] as String,
      cardType: fields[6] as String,
      cardScheme: fields[7] as String,
      cardColor: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CardData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.cardId)
      ..writeByte(1)
      ..write(obj.bankName)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.cardNumber)
      ..writeByte(4)
      ..write(obj.cvv)
      ..writeByte(5)
      ..write(obj.validThru)
      ..writeByte(6)
      ..write(obj.cardType)
      ..writeByte(7)
      ..write(obj.cardScheme)
    ..writeByte(8)
    ..write(obj.cardColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
