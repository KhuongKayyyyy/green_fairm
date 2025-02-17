import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/core/util/helper.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/bloc/machine_learning/ml_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FieldBigItem extends StatefulWidget {
  final Field field;
  const FieldBigItem({super.key, required this.field});

  @override
  State<FieldBigItem> createState() => _FieldBigItemState();
}

class _FieldBigItemState extends State<FieldBigItem> {
  final MlBloc mlBloc = MlBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mlBloc.add(MlHealthPredictionRequested(
      date: Helper.getTodayDateFormatted(),
      fieldId: widget.field.id!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          context.pushNamed(Routes.fieldDetail,
              extra: {"field": widget.field, "onDelete": () {}});
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ], borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              children: [
                Hero(
                  tag: "fieldImage${widget.field.id}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.field.imageUrl!,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.field.name!,
                          style: AppTextStyle.defaultBold(),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: AppColors.grey,
                              size: 15,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                widget.field.area!,
                                style: AppTextStyle.defaultBold(
                                    color: AppColors.grey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 5, horizontal: 10),
                    //   decoration: BoxDecoration(
                    //     color: AppColors.lightbg.withOpacity(0.3),
                    //     borderRadius: BorderRadius.circular(5),
                    //   ),
                    //   child: Text(
                    //     widget.field.status ?? 'Good',
                    //     style: AppTextStyle.defaultBold(
                    //         color: AppColors.primaryColor),
                    //   ),
                    // )
                    _buildHealthPrediction()
                  ],
                )
              ],
            )));
  }

  Widget _buildHealthPrediction() {
    return BlocBuilder<MlBloc, MlState>(
      bloc: mlBloc,
      builder: (context, plantHealthState) {
        if (plantHealthState is MlLoading) {
          return Skeletonizer(
            enabled: true,
            enableSwitchAnimation: true,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: AppColors.black,
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ], borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Text(
                widget.field.status ?? "No status",
                style: AppTextStyle.defaultBold(
                  color: widget.field.status == "Good"
                      ? AppColors.primaryColor
                      : AppColors.secondaryColor,
                ),
              ),
            ),
          );
        } else if (plantHealthState is MlHealthPredictionSuccess) {
          if (plantHealthState.healthPredictions == -1) {
            widget.field.status = "No status";
          } else if (plantHealthState.healthPredictions < 0.3) {
            widget.field.status = "Bad";
          } else if (plantHealthState.healthPredictions <= 0.5) {
            widget.field.status = "Normal";
          } else if (plantHealthState.healthPredictions <= 0.7) {
            widget.field.status = "Good";
          } else {
            widget.field.status = "Excellent";
          }

          return Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ], borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Text(
              widget.field.status ?? "No status",
              style: AppTextStyle.defaultBold(
                color: widget.field.status == "Excellent"
                    ? Colors.green
                    : widget.field.status == "Good"
                        ? AppColors.primaryColor
                        : widget.field.status == "Normal"
                            ? Colors.orange
                            : widget.field.status == "Bad"
                                ? Colors.red
                                : AppColors.secondaryColor,
              ),
            ),
          );
        } else if (plantHealthState is MlHealthPredictionFailure) {
          return Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ], borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Text(
              "No status",
              style: AppTextStyle.defaultBold(
                color: AppColors.secondaryColor,
              ),
            ),
          );
        }
        return Skeletonizer(
          enabled: true,
          enableSwitchAnimation: true,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Text(
              widget.field.status ?? "No status",
              style: AppTextStyle.defaultBold(
                color: widget.field.status == "Good"
                    ? AppColors.primaryColor
                    : AppColors.secondaryColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
