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