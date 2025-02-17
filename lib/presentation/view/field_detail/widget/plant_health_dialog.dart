import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/core/util/helper.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/bloc/machine_learning/ml_bloc.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlantHealthDialog extends StatefulWidget {
  final Field field;
  const PlantHealthDialog({super.key, required this.field});

  @override
  State<PlantHealthDialog> createState() => _PlantHealthDialogState();
}

class _PlantHealthDialogState extends State<PlantHealthDialog> {
  final MlBloc _mlBloc = MlBloc();

  @override
  void initState() {
    super.initState();
    _mlBloc.add(MlWaterNeedRequested(
        date: Helper.getTodayDateFormatted(), fieldId: widget.field.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(
            width: 5,
            color: _getStatusColor(widget.field.status!),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Plant Health',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: MediaQuery.of(context).size.width * 0.5,
                width: MediaQuery.of(context).size.height * 0.5,
                child: _getStatusImage(widget.field.status!)),
            RichText(
              text: TextSpan(
                text: 'Your plants is at ',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.field.status,
                    style: TextStyle(
                      color: _getStatusColor(widget.field.status!),
                      fontSize: 16,
                    ),
                  ),
                  const TextSpan(
                    text: ' status',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildWaterNeed(),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                      isReverse: true,
                      text: "Done",
                      onPressed: () {
                        context.pop();
                      }),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: PrimaryButton(
                        text: "See Analysis",
                        onPressed: () {
                          context.pop();
                          context.pushNamed(Routes.fieldAnalysis,
                              extra: widget.field);
                        })),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterNeed() {
    return BlocBuilder<MlBloc, MlState>(
      bloc: _mlBloc,
      builder: (context, state) {
        if (state is MlWaterNeedSuccess) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: RichText(
              text: TextSpan(
                text: 'Next watering should be in ',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: _formatTime(state.waterNeed),
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is MlWaterNeedFailure) {
          return const Text('Failed to fetch water need prediction data.');
        }
        return const Skeletonizer(
            child: Text("Loading water need prediction data..."));
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Excellent':
        return AppColors.primaryColor;
      case 'Good':
        return Colors.green;
      case 'Normal':
        return Colors.orange;
      case 'Bad':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  Image _getStatusImage(String status) {
    switch (status) {
      case 'Excellent':
        return Image.asset(AppImage.excellentPlant);
      case 'Good':
        return Image.asset(AppImage.goodPlant);
      case 'Normal':
        return Image.asset(AppImage.goodPlant);
      case 'Bad':
        return Image.asset(AppImage.badPlant);
      default:
        return Image.asset(AppImage.badPlant);
    }
  }

  String _formatTime(double time) {
    int totalMinutes = time.round();
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;
    return '$hours hour ${minutes.toString().padLeft(2, '0')} minute';
  }
}
