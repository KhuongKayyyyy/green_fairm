import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/bloc/field_management/field_management_bloc.dart';
import 'package:green_fairm/presentation/view/setting/widget/toggle_selection_item.dart';

class FieldSetting extends StatefulWidget {
  final Field field;
  final Function(bool) mqqtNotifier;
  const FieldSetting(
      {super.key, required this.field, required this.mqqtNotifier});

  @override
  State<FieldSetting> createState() => _FieldSettingState();
}

class _FieldSettingState extends State<FieldSetting> {
  final FieldManagementBloc _fieldManagementBloc = FieldManagementBloc();
  @override
  Widget build(BuildContext context) {
    return BlocListener<FieldManagementBloc, FieldManagementState>(
      bloc: _fieldManagementBloc,
      listener: (context, state) {
        if (state is FieldManagementUpdateFieldSettingSuccess) {
          EasyLoading.showSuccess("Updated setting successfully");
        } else if (state is FieldManagementUpdateFieldSettingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is FieldManagementLoading) {
          EasyLoading.show(status: 'Updating...');
        }
      },
      child: Column(
        children: [
          ToggleSelectionItem(
            onChange: (value) {
              setState(() {
                widget.field.isWeatherService = value;
              });
              _updateFieldSetting(settingType: "switch-weather");
            },
            isSelected: widget.field.isWeatherService,
            title: "Weather APIs",
            description:
                "Integrate weather APIs to get the most accurate weather forecast for your farm",
          ),
          const SizedBox(height: 10),
          ToggleSelectionItem(
              isSelected: true,
              title: "Environmental Sensors",
              description:
                  "Soil sensors and analysis tools offer precise details on soil health factors like moisture, nutrients, pH and compaction."),
          const SizedBox(height: 10),
          ToggleSelectionItem(
              onChange: (value) {
                setState(() {
                  widget.field.isAutoWatering = value;
                });
                _updateFieldSetting(
                    settingType: "switch-auto-watering", isAutoWatering: value);
              },
              isSelected: widget.field.isAutoWatering,
              title: "Irrigation Automation",
              description:
                  "Automate irrigation systems to ensure that your crops are watered at the right time and in the right amount."),
        ],
      ),
    );
  }

  void _updateFieldSetting(
      {required String settingType, bool? isAutoWatering}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Update setting"),
          content: const Text("Do you want to update the setting?"),
          actions: [
            CupertinoDialogAction(
              child: const Text("Cancel"),
              onPressed: () {
                setState(() {
                  if (settingType == "switch-auto-watering") {
                    widget.field.isAutoWatering =
                        !(widget.field.isAutoWatering ?? false);
                  } else if (settingType == "switch-weather") {
                    widget.field.isWeatherService =
                        !(widget.field.isWeatherService ?? false);
                  }
                });
                context.pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text("Update"),
              onPressed: () {
                _fieldManagementBloc.add(FieldManagementEventUpdateFieldSetting(
                    field: widget.field, settingType: settingType));
                widget.mqqtNotifier(
                    isAutoWatering ?? widget.field.isAutoWatering!);
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
