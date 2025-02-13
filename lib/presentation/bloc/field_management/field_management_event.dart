part of 'field_management_bloc.dart';

sealed class FieldManagementEvent extends Equatable {
  const FieldManagementEvent();

  @override
  List<Object> get props => [];
}

final class FieldManagementEventGetAll extends FieldManagementEvent {
  const FieldManagementEventGetAll();
}

final class FieldManagementEventGetById extends FieldManagementEvent {
  final String id;
  const FieldManagementEventGetById({required this.id});

  @override
  List<Object> get props => [id];
}

final class FieldManagementEventCreate extends FieldManagementEvent {
  final Field field;

  const FieldManagementEventCreate({required this.field});

  @override
  List<Object> get props => [field];
}

final class FieldManagementGetByUserId extends FieldManagementEvent {
  final String userId;
  const FieldManagementGetByUserId({required this.userId});

  @override
  List<Object> get props => [userId];
}

final class FieldManagementEventUpdate extends FieldManagementEvent {
  final Field field;

  const FieldManagementEventUpdate({required this.field});

  @override
  List<Object> get props => [field];
}

final class FieldManagementEventDelete extends FieldManagementEvent {
  final Field field;

  const FieldManagementEventDelete({required this.field});

  @override
  List<Object> get props => [field];
}

final class FieldManagementEventUpdateFieldSetting
    extends FieldManagementEvent {
  final Field field;
  final String settingType;

  const FieldManagementEventUpdateFieldSetting(
      {required this.field, required this.settingType});

  @override
  List<Object> get props => [field, settingType];
}
