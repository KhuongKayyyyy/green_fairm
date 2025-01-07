import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/core/util/helper.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/bloc/field_management/field_management_bloc.dart';
import 'package:green_fairm/presentation/view/main/home/widget/check_our_ai_recommendation.dart';
import 'package:green_fairm/presentation/widget/field_information_item.dart';
import 'package:green_fairm/presentation/widget/grey_button.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class FieldOverview extends StatefulWidget {
  final Field field;
  const FieldOverview({super.key, required this.field});

  @override
  State<FieldOverview> createState() => _FieldOverviewState();
}

class _FieldOverviewState extends State<FieldOverview> {
  FieldManagementBloc fieldManagementBloc = FieldManagementBloc();
  final TextEditingController fieldNameController = TextEditingController();
  final TextEditingController fieldTypeController = TextEditingController();
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    // Initialize controllers with the field name
    fieldNameController.text = widget.field.name ?? "No name";
    fieldTypeController.text = "Sau rieng";
    countryValue = Helper.getCountry(widget.field.area!);
    stateValue = Helper.getState(widget.field.area!);
    cityValue = Helper.getCity(widget.field.area!);
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    fieldNameController.dispose();
    fieldTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFieldName(),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: -1.0,
                child: child,
              ),
            );
          },
          child: isExpanded
              ? Column(
                  key: ValueKey<bool>(isExpanded),
                  children: [
                    const SizedBox(height: 10),
                    _buildFieldDeatailInformation(),
                  ],
                )
              : SizedBox.shrink(
                  key: ValueKey<bool>(isExpanded),
                ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: _buildOverviewInformation()),
        CheckOurAiRecommendation(
          message: "Check farm analysics",
          icon: CupertinoIcons.rocket,
          onTap: () {
            context.pushNamed(Routes.fieldAnalysis, extra: widget.field);
          },
        )
      ],
    );
  }

  Widget _buildOverviewInformation() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FieldInformationItem(
                informationType: "Crop health",
                information: widget.field.cropHealth ?? "No data",
                isExpandable: true,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FieldInformationItem(
                  informationType: "Planting Date",
                  information: widget.field.plantingDate ?? "No data"),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Expanded(
              child: FieldInformationItem(
                  informationType: "Expenses", information: "\$2.000"),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FieldInformationItem(
                  informationType: "Harvest Time",
                  information: widget.field.haverstTime ?? "No data"),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildFieldName() {
    return Row(
      children: [
        Text(
          "${widget.field.name} ",
          style: AppTextStyle.mediumBold(color: AppColors.secondaryColor),
        ),
        const SizedBox(width: 10),
        const Spacer(),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: GreyButton(
            key: ValueKey<bool>(isExpanded),
            child: Row(
              children: [
                const Text("More detail"),
                const SizedBox(width: 5),
                AnimatedRotation(
                  turns: isExpanded ? 0.25 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(
                    CupertinoIcons.chevron_right,
                    size: 20,
                  ),
                ),
              ],
            ),
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFieldDeatailInformation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10), // Add padding for better spacing
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Text(
                  "Field name",
                  style: AppTextStyle.defaultBold(),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: TextField(
                  controller: fieldNameController,
                  // onChanged: (text) {
                  //   setState(() {
                  //     widget.field.name = text;
                  //   });
                  // },
                  cursorColor: AppColors.secondaryColor,

                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color:
                            AppColors.secondaryColor, // Set your custom color
                        width: 2.0, // Set your desired border width
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: widget.field.name,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(color: AppColors.secondaryColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Text(
                  "Field type",
                  style: AppTextStyle.defaultBold(),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: TextField(
                  controller: fieldTypeController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color:
                            AppColors.secondaryColor, // Set your custom color
                        width: 2.0, // Set your desired border width
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: "Sau rieng",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Field location",
                style: AppTextStyle.defaultBold(),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: CSCPicker(
                  flagState: CountryFlag.DISABLE,
                  currentCountry: countryValue,
                  currentState: stateValue,
                  currentCity: cityValue,
                  onCountryChanged: (country) {
                    setState(() {
                      countryValue = country;
                    });
                  },
                  onStateChanged: (state) {
                    setState(() {
                      stateValue =
                          state ?? ""; // Use empty string if state is null
                    });
                  },
                  onCityChanged: (city) {
                    setState(() {
                      cityValue =
                          city ?? ""; // Use empty string if city is null
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          BlocListener<FieldManagementBloc, FieldManagementState>(
            bloc: fieldManagementBloc,
            listener: (context, updateState) {
              if (updateState is FieldManagementUpdateSuccess) {
                EasyLoading.showSuccess('Field updated');
              } else if (updateState is FieldManagementUpdateError) {
                EasyLoading.showError(updateState.message);
              } else if (updateState is FieldManagementLoading) {
                EasyLoading.show(status: 'Updating field...');
              } else if (updateState is FieldManagementDeleteSuccess) {
                EasyLoading.showSuccess('Field deleted');
                context.pop();
              } else if (updateState is FieldManagementDeleteError) {
                EasyLoading.showError(updateState.message);
              } else if (updateState is FieldManagementLoading) {
                EasyLoading.show(status: 'Deleting field...');
              }
            },
            child: PrimaryButton(
              isReverse: true,
              onPressed: () {
                widget.field.name = fieldNameController.text;
                widget.field.type = fieldTypeController.text;
                widget.field.area = "$cityValue, $stateValue, $countryValue";
                fieldManagementBloc
                    .add(FieldManagementEventUpdate(field: widget.field));
              },
              text: "Save",
            ),
          ),
          const SizedBox(height: 10),
          PrimaryButton(
              text: "Delete Field",
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: const Text('Delete Field'),
                      content: const Text(
                          'Are you sure you want to delete this field?'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          onPressed: () {
                            Navigator.of(context).pop();
                            fieldManagementBloc.add(FieldManagementEventDelete(
                                field: widget.field));
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              })
        ],
      ),
    );
  }
}
