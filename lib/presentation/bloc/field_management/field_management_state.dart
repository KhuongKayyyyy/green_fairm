part of 'field_management_bloc.dart';

sealed class FieldManagementState extends Equatable {
  const FieldManagementState();

  @override
  List<Object> get props => [];
}

final class FieldManagementInitial extends FieldManagementState {}

final class FieldManagementLoading extends FieldManagementState {}

final class FieldManagementCreateSuccess extends FieldManagementState {
  final Field field;
  const FieldManagementCreateSuccess({required this.field});
}

final class FieldManagementCreateError extends FieldManagementState {
  final String message;
  const FieldManagementCreateError({required this.message});

  @override
  List<Object> get props => [message];
}

final class FieldManagementGetAllSuccess extends FieldManagementState {
  final List<Field> fields;
  const FieldManagementGetAllSuccess({required this.fields});
}

final class FieldManagementGetAllError extends FieldManagementState {
  final String message;
  const FieldManagementGetAllError({required this.message});

  @override
  List<Object> get props => [message];
}

final class FieldManagementGetByIdSuccess extends FieldManagementState {
  final Field field;
  const FieldManagementGetByIdSuccess({required this.field});
}

final class FieldManagementGetByIdError extends FieldManagementState {
  final String message;
  const FieldManagementGetByIdError({required this.message});

  @override
  List<Object> get props => [message];
}

final class FieldManagementGetByUserIdSuccess extends FieldManagementState {
  final List<Field> fields;
  const FieldManagementGetByUserIdSuccess({required this.fields});
}

final class FieldManagementGetByUserIdError extends FieldManagementState {
  final String message;
  const FieldManagementGetByUserIdError({required this.message});

  @override
  List<Object> get props => [message];
}

final class FieldManagementUpdateSuccess extends FieldManagementState {
  final Field field;
  const FieldManagementUpdateSuccess({required this.field});
}

final class FieldManagementUpdateError extends FieldManagementState {
  final String message;
  const FieldManagementUpdateError({required this.message});

  @override
  List<Object> get props => [message];
}

final class FieldManagementDeleteSuccess extends FieldManagementState {
  final Field field;
  const FieldManagementDeleteSuccess({required this.field});
}

final class FieldManagementDeleteError extends FieldManagementState {
  final String message;
  const FieldManagementDeleteError({required this.message});

  @override
  List<Object> get props => [message];
}

final class FieldManagementUpdateFieldSettingSuccess
    extends FieldManagementState {
  final Field field;
  const FieldManagementUpdateFieldSettingSuccess({required this.field});
}

final class FieldManagementUpdateFieldSettingError
    extends FieldManagementState {
  final String message;
  const FieldManagementUpdateFieldSettingError({required this.message});

  @override
  List<Object> get props => [message];
}
