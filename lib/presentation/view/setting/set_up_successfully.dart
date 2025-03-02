import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class SetUpSuccessfully extends StatelessWidget {
  final Field field;
  const SetUpSuccessfully({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 200),
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.grey[300]!,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor,
                                blurRadius: 100,
                                spreadRadius: 20,
                              )
                            ],
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.secondaryColor,
                                AppColors.primaryColor,
                              ],
                            )),
                        child: const Icon(
                          CupertinoIcons.check_mark,
                          size: 50,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Success set up your farm',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.largeBold(
                            color: AppColors.secondaryColor)),
                    const SizedBox(height: 10),
                    Text('Welcome to Green Fairm',
                        style: AppTextStyle.defaultBold(
                            color: AppColors.secondaryColor)),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  field.name!,
                                  style: AppTextStyle.defaultBold(
                                      color: AppColors.secondaryColor),
                                ),
                                Text(
                                  "Field name",
                                  style: AppTextStyle.defaultBold(
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 50,
                              width: 2,
                              color: Colors.grey[300],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  field.area!,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.defaultBold(
                                      color: AppColors.secondaryColor),
                                ),
                                Text(
                                  "Field location",
                                  style: AppTextStyle.defaultBold(
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const Spacer(),
            PrimaryButton(
                text: "Open Your Farm",
                onPressed: () {
                  context.go(Routes.fieldDetail, extra: field);
                }),
            const SizedBox(height: 10),
            PrimaryButton(
              text: "Go to home",
              onPressed: () => context.go(Routes.home),
              isReverse: true,
            ),
          ],
        ),
      ),
    );
  }
}
