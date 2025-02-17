import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/core/util/helper.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/bloc/machine_learning/ml_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FieldSmallItem extends StatefulWidget {
  final Field field;
  final VoidCallback onDelete;
  const FieldSmallItem(
      {super.key, required this.field, required this.onDelete});

  @override
  State<FieldSmallItem> createState() => _FieldSmallItemState();
}

class _FieldSmallItemState extends State<FieldSmallItem> {
  final MlBloc mlBloc = MlBloc();

  @override
  void initState() {
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
            extra: {"field": widget.field, "onDelete": widget.onDelete});
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.height * 0.18,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: "fieldImage${widget.field.id}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Skeletonizer(
                      enabled: widget.field.imageUrl == null ||
                          widget.field.imageUrl!
                              .isEmpty, // Skeleton active when no image URL
                      child: FadeInImage.assetNetwork(
                        placeholder: AppImage.placeholder, // Placeholder image
                        image: widget.field.imageUrl ??
                            AppImage.placeholder, // Fallback image
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppImage.placeholder, // Fallback image for errors
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: _buildHealthPrediction(),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(widget.field.name ?? "No type",
                style:
                    AppTextStyle.defaultBold(color: AppColors.secondaryColor)),
            const SizedBox(height: 4),
            Text(widget.field.area ?? "No area",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.grey)),
          ],
        ),
      ),
    );
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
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
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
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
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
