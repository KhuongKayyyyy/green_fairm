import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/data/model/water_history.dart';
import 'package:green_fairm/presentation/bloc/water_history/water_history_bloc.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/water_history_item.dart';

class WaterHistoryPage extends StatefulWidget {
  final List<WaterHistory> waterHistories;
  const WaterHistoryPage({super.key, required this.waterHistories});

  @override
  State<WaterHistoryPage> createState() => _WaterHistoryPageState();
}

class _WaterHistoryPageState extends State<WaterHistoryPage> {
  late WaterHistoryBloc _waterHistoryBloc;
  @override
  void initState() {
    super.initState();
    _waterHistoryBloc = WaterHistoryBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Water History",
                style: AppTextStyle.mediumBold(color: AppColors.secondaryColor),
              ),
              const Spacer(),
              BlocListener<WaterHistoryBloc, WaterHistoryState>(
                bloc: _waterHistoryBloc,
                listener: (context, deleteState) {
                  if (deleteState is WaterHistoryClearAllSuccess) {
                    EasyLoading.showSuccess("Clear all water history success");
                    setState(() {
                      widget.waterHistories.clear();
                    });
                  } else if (deleteState is WaterHistoryError) {
                    EasyLoading.showError("Clear all water history failure");
                  } else if (deleteState is WaterHistoryLoading) {
                    EasyLoading.show(status: "Clearing all water history");
                  }
                },
                child: InkWell(
                    onTap: () {
                      _showDeleteConfirmationDialog();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(0, 1),
                            )
                          ]),
                      child: Center(
                        child: Text(
                          "Clear All",
                          style: AppTextStyle.defaultBold(
                              color: AppColors.primaryColor),
                        ),
                      ),
                    )),
              )
            ],
          ),
          const SizedBox(height: 10),
          if (widget.waterHistories.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  "Your water history will be displayed here",
                  style: AppTextStyle.defaultBold(),
                ),
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.waterHistories.length,
                      itemBuilder: (context, index) {
                        return WaterHistoryItem(
                          waterHistory:
                              widget.waterHistories.reversed.toList()[index],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            "Delete Water History",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Are you sure you want to delete all water history? This action cannot be undone.",
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text("Delete"),
              onPressed: () {
                if (widget.waterHistories.isNotEmpty) {
                  _waterHistoryBloc.add(WaterHistoryClearAllRequested(
                    fieldId: widget.waterHistories.first.fieldId!,
                  ));
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
