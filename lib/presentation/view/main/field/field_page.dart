import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_setting.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/bloc/field_management/field_management_bloc.dart';
import 'package:green_fairm/presentation/view/main/field/widget/field_page_field_list.dart';
import 'package:green_fairm/presentation/view/main/field/widget/field_page_header.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FieldPage extends StatefulWidget {
  const FieldPage({super.key});

  @override
  State<FieldPage> createState() => _FieldPageState();
}

class _FieldPageState extends State<FieldPage> {
  FieldManagementBloc fieldManagementBloc = FieldManagementBloc();
  var userId = "";
  List<Field> fields = [];
  @override
  void initState() {
    super.initState();
    _initializeUserId();
    fieldManagementBloc.add(FieldManagementGetByUserId(userId: userId));
  }

  Future<void> _initializeUserId() async {
    userId =
        (await const FlutterSecureStorage().read(key: AppSetting.userUid))!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Optional: Uncomment this for background image
          Positioned(
            top: -520,
            left: -100, // Adjust left position to move container
            right: -100, // Adjust right position to move container
            child: Container(
              width: MediaQuery.of(context).size.width, // Exceed width
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(200),
                color: AppColors.secondaryColor,
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 10,
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: FieldPageHeader(
              fields: fields,
            ),
          ),
          Positioned(
            top: 200,
            left: 20,
            right: 20,
            child: BlocBuilder<FieldManagementBloc, FieldManagementState>(
              bloc: fieldManagementBloc,
              builder: (context, fileldState) {
                if (fileldState is FieldManagementLoading) {
                  return Skeletonizer(
                    enableSwitchAnimation: true,
                    enabled: true,
                    child: FieldPageFieldList(fields: FakeData.fakeFields),
                  );
                } else if (fileldState is FieldManagementGetByUserIdSuccess) {
                  fields = fileldState.fields;
                  print(fields.length);
                  return FieldPageFieldList(fields: fileldState.fields);
                }
                return Skeletonizer(
                  enableSwitchAnimation: true,
                  enabled: true,
                  child: FieldPageFieldList(fields: FakeData.fakeFields),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
