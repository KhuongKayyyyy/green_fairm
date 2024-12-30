import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/bloc/field_management/field_management_bloc.dart';
import 'package:green_fairm/presentation/view/setting/widget/set_up_drop_down_menu.dart';
import 'package:green_fairm/presentation/view/setting/widget/set_up_text_field.dart';
import 'package:green_fairm/presentation/view/setting/widget/toggle_selection_item.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class SetUpFieldPage extends StatefulWidget {
  const SetUpFieldPage({super.key});

  @override
  State<SetUpFieldPage> createState() => _SetUpFieldPageState();
}

class _SetUpFieldPageState extends State<SetUpFieldPage> {
  late final FieldManagementBloc _fieldManagementBloc;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  String farmName = "";
  List<String> title = [
    "Set up your farm",
    "AI Intergration",
    "Preferences & Goals",
  ];
  List<String> subTitle = [
    "Accurate information about your farm is helpful in giving better recommendation",
    "Choose out with service you want to integrate into your app since we praise personalization.",
    "Let us know your goal to sort out things that suit you the bests",
  ];
  int _currentIndex = 0; // To track the current step index

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fieldManagementBloc = BlocProvider.of<FieldManagementBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FieldManagementBloc, FieldManagementState>(
        listener: (context, createState) {
          if (createState is FieldManagementCreateSuccess) {
            EasyLoading.dismiss();
            context.goNamed(Routes.setUpSuccess, extra: createState.field);
          } else if (createState is FieldManagementCreateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(createState.message),
              ),
            );
          } else if (createState is FieldManagementLoading) {
            EasyLoading.show(status: "Creating farm...");
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._buildSetUpHeader(), // Header remains fixed
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildSetUpBody(), // Make only the body scrollable
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                  text: "Continue",
                  onPressed: () {
                    if (_currentIndex == 0 &&
                        (farmName.isEmpty ||
                            countryValue.isEmpty ||
                            stateValue.isEmpty ||
                            cityValue.isEmpty)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text("Please fill in all required fields")),
                      );
                    } else {
                      setState(() {
                        if (_currentIndex < 2) {
                          _currentIndex++;
                        } else {
                          _fieldManagementBloc.add(FieldManagementEventCreate(
                              field: Field(
                            name: farmName,
                            area: "$stateValue, $cityValue, $countryValue",
                          )));
                        }
                      });
                    }
                  }),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSetUpBody() {
    return Column(
      children: [
        if (_currentIndex == 0) _buildSetUpStep1(),
        if (_currentIndex == 1) _buildSetUpStep2(),
        if (_currentIndex == 2) _buildSetUpStep3(),
      ],
    );
  }

  Widget _buildSetUpStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SetUpTextField(
          title: "Farm name",
          hintText: "Enter your farm name",
          onChanged: (value) {
            setState(() {
              farmName = value;
            });
          },
        ),
        Text("Location", style: AppTextStyle.defaultBold()),
        const SizedBox(height: 5),
        CSCPicker(
          flagState: CountryFlag.DISABLE,
          onCountryChanged: (country) {
            setState(() {
              countryValue = country;
            });
          },
          onStateChanged: (state) {
            setState(() {
              stateValue = state ?? ""; // Use empty string if state is null
            });
          },
          onCityChanged: (city) {
            setState(() {
              cityValue = city ?? ""; // Use empty string if city is null
            });
          },
        ),
        const SizedBox(height: 10),
        const SetUpDropDownMenu(title: "Farm type", items: [
          "Crop Farm",
          "Livestock",
        ]),
        const SizedBox(height: 10),
        // const SetUpTextField(
        //   title: "Farm size (m2)",
        //   hintText: "200",
        // ),
        const SizedBox(height: 10),
        const SetUpDropDownMenu(title: "Crop type", items: [
          "Tomatoes",
          "Paddy",
          "Corn",
          "Cabbage",
          "Carrot",
        ]),
      ],
    );
  }

  Widget _buildSetUpStep2() {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ToggleSelectionItem(
              title: "Weather APIs",
              description:
                  "Integrate weather APIs to get the most accurate weather forecast for your farm"),
          SizedBox(height: 10),
          ToggleSelectionItem(
              title: "Soil moisture",
              description:
                  "Soil sensors and analysis tools offer precise details on soil health factors like moisture, nutrients, pH and compaction."),
          SizedBox(height: 10),
          ToggleSelectionItem(
              title: "Satellite imagery services (Soon)",
              isDisable: true,
              description:
                  "Satellite and drone AI help the app monitor health and spo early issues like diseases or pest."),
          SizedBox(height: 10),
          ToggleSelectionItem(
              title: "Predictive Analytics for Yield Optimization (Soon)",
              isDisable: true,
              description:
                  "Satellite and drone AI help the app monitor health and spo early issues like diseases or pest."),
          SizedBox(height: 10),
          ToggleSelectionItem(
              title: "Pest Management and Control (Soon)",
              isDisable: true,
              description:
                  "App integrate AI pest detection for real-time alerts on crops threat form sensor."),
        ],
      ),
    );
  }

  Widget _buildSetUpStep3() {
    return Column(
      children: [
        const SetUpDropDownMenu(
            title: "Yields Target", items: ["1000", "2000", "3000"]),
        const SizedBox(height: 10),
        const SetUpDropDownMenu(
            title: "Sustgainablity",
            items: ["water usage", "soil health", "crop yield"]),
        const SizedBox(height: 10),
        StatefulBuilder(
          builder: (context, setState) {
            String selectedIrrigation = "";

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Irriagation method",
                    style: AppTextStyle.defaultBold(
                      color: AppColor.secondaryColor,
                    )),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedIrrigation = "Drip irrigation";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedIrrigation == "Drip irrigation"
                                  ? AppColor.primaryColor
                                  : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: selectedIrrigation == "Drip irrigation"
                                ? AppColor.primaryColor.withOpacity(0.1)
                                : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              "Drip irrigation",
                              style: AppTextStyle.defaultBold(
                                color: selectedIrrigation == "Drip irrigation"
                                    ? AppColor.primaryColor
                                    : AppColor.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedIrrigation = "Sprinkler irrigation";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  selectedIrrigation == "Sprinkler irrigation"
                                      ? AppColor.primaryColor
                                      : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: selectedIrrigation == "Sprinkler irrigation"
                                ? AppColor.primaryColor.withOpacity(0.1)
                                : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              "Sprinkler irrigation",
                              style: AppTextStyle.defaultBold(
                                color:
                                    selectedIrrigation == "Sprinkler irrigation"
                                        ? AppColor.primaryColor
                                        : AppColor.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        const SetUpDropDownMenu(title: "Havert Time", items: [
          "30 days after planting",
          "60 days after planting",
          "90 days after planting"
        ]),
      ],
    );
  }

  List<Widget> _buildSetUpHeader() {
    return [
      const SizedBox(height: 50),
      Row(
        children: [
          InkWell(
            onTap: () {
              if (_currentIndex > 0) {
                setState(() {
                  _currentIndex--;
                });
              } else {
                context.pop();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                CupertinoIcons.arrow_left,
                color: AppColor.secondaryColor,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title[_currentIndex],
            style: AppTextStyle.mediumBold(
              color: AppColor.secondaryColor,
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      // Add the indicator below the AppBar
      SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 5,
                width: _currentIndex == index
                    ? 20
                    : 10, // Active indicator is wider
                decoration: BoxDecoration(
                  color: _currentIndex >= index
                      ? AppColor.primaryColor
                      : Colors.grey[300], // Active indicator color
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            );
          }),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        subTitle[_currentIndex],
        style: AppTextStyle.defaultBold(color: AppColor.secondaryColor),
      ),
    ];
  }
}
