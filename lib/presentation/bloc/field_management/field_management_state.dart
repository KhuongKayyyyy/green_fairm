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
