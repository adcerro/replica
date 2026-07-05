// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      name: fields[0] as String?,
      email: fields[1] as String,
      password: fields[2] as String,
      income: (fields[3] as num).toDouble(),
      budget: (fields[4] as num).toDouble(),
    )..categories = (fields[5] as Map).cast<String, CategoryInfo>();
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.income)
      ..writeByte(4)
      ..write(obj.budget)
      ..writeByte(5)
      ..write(obj.categories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final typeId = 1;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaction(
      userEmail: fields[1] as String,
      value: (fields[3] as num).toDouble(),
      category: fields[4] == null ? '' : fields[4] as String,
      label: fields[2] == null ? '' : fields[2] as String,
      dateTime: fields[0] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.userEmail)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.value)
      ..writeByte(4)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryInfoAdapter extends TypeAdapter<CategoryInfo> {
  @override
  final typeId = 2;

  @override
  CategoryInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryInfo(
      color: (fields[0] as num).toInt(),
      icon: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryInfo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.color)
      ..writeByte(1)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
