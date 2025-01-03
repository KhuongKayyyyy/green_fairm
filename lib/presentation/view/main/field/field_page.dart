import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_setting.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/presentation/bloc/field_management/field_management_bloc.dart';
import 'package:green_fairm/presentation/widget/app_search_bar.dart';
import 'package:green_fairm/presentation/widget/field_big_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FieldPage extends StatefulWidget {
  const FieldPage({super.key});

  @override
  State<FieldPage> createState() => _FieldPageState();
}

class _FieldPageState extends State<FieldPage> {
  FieldManagementBloc fieldManagementBloc = FieldManagementBloc();
  var userId = "";
  @override
  void initState() {
    // TODO: implement initState
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
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Hello, ",
                            style: AppTextStyle.mediumBold(
                                color: AppColors.white)),
                        TextSpan(
                            text:
                                "${FirebaseAuth.instance.currentUser!.displayName}",
                            style: AppTextStyle.mediumBold(
                                color: AppColors.accentColor)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const AppSearchBar(),
                  const SizedBox(height: 20),
                ],
              ),
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Your Fields",
                                style: AppTextStyle.defaultBold(
                                    color: AppColors.white)),
                            Text(
                              "xx fields",
                              style: AppTextStyle.defaultBold(
                                  color: AppColors.accentColor),
                            )
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 150),
                              itemCount: FakeData.fakeFields.length,
                              itemBuilder: (context, index) {
                                return FieldBigItem(
                                  field: FakeData.fakeFields[index],
                                );
                              },
                            )),
                      ],
                    ),
                  );
                } else if (fileldState is FieldManagementGetByUserIdSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Your Fields",
                              style: AppTextStyle.defaultBold(
                                  color: AppColors.white)),
                          const Spacer(),
                          Text(
                            "${fileldState.fields.length} fields",
                            style: AppTextStyle.defaultBold(
                                color: AppColors.accentColor),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 150),
                            itemCount: fileldState.fields.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: FieldBigItem(
                                  field: fileldState.fields[index],
                                ),
                              );
                            },
                          )),
                    ],
                  );
                }
                return Skeletonizer(
                  enableSwitchAnimation: true,
                  enabled: true,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Your Fields",
                              style: AppTextStyle.defaultBold(
                                  color: AppColors.white)),
                          Text(
                            "xx fields",
                            style: AppTextStyle.defaultBold(
                                color: AppColors.accentColor),
                          )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 150),
                            itemCount: FakeData.fakeFields.length,
                            itemBuilder: (context, index) {
                              return FieldBigItem(
                                field: FakeData.fakeFields[index],
                              );
                            },
                          )),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
