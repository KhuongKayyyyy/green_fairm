import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:green_fairm/core/constant/app_setting.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/data/res/field_repository.dart';

part 'field_management_event.dart';
part 'field_management_state.dart';

class FieldManagementBloc
    extends Bloc<FieldManagementEvent, FieldManagementState> {
  final FieldRepository _fieldRepository = FieldRepository();
  FieldManagementBloc() : super(FieldManagementInitial()) {
    on<FieldManagementEventCreate>(_onCreate);
  }

  Future<void> _onCreate(
    FieldManagementEventCreate event,
    Emitter<FieldManagementState> emit,
  ) async {
    emit(FieldManagementLoading());
    try {
      await _fieldRepository.saveNewFieldToServer(
        name: event.field.name!,
        area: event.field.area!,
        userId:
            await const FlutterSecureStorage().read(key: AppSetting.userUid) ??
                '',
      );
      emit(FieldManagementCreateSuccess(field: event.field));
    } catch (e) {
      emit(const FieldManagementCreateError(
          message: 'An unknown error occurred'));
    }
  }
}
