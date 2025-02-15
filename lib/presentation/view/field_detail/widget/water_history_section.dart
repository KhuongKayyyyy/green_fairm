import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/data/model/water_history.dart';
import 'package:green_fairm/presentation/bloc/water_history/water_history_bloc.dart';
import 'package:green_fairm/presentation/view/field_detail/water_history_page.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/water_history_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class WaterHistorySection extends StatefulWidget {
  final Field field;
  const WaterHistorySection({super.key, required this.field});

  @override
  State<WaterHistorySection> createState() => _WaterHistorySectionState();
}

class _WaterHistorySectionState extends State<WaterHistorySection> {
  List<WaterHistory> _waterHistories = [];
  late WaterHistoryBloc _waterHistoryBloc;

  @override
  void initState() {
    super.initState();
    _waterHistoryBloc = WaterHistoryBloc();
    _waterHistoryBloc.add(WaterHistoryRequested(fieldId: widget.field.id!));
    // _fetchWaterHistory();
  }

  // void _fetchWaterHistory() async {
  //   List<WaterHistory> histories = await WaterHistoryRepository()
  //       .fetchWaterHistoryByFieldId(widget.field.id!);
  //   setState(() {
  //     _waterHistories =
  //         histories; // Update local state instead of widget.waterHistories
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Water History",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                  onTap: () {
                    // _fetchWaterHistory();
                    setState(() {
                      _waterHistoryBloc.add(
                          WaterHistoryRequested(fieldId: widget.field.id!));
                    });
                  },
                  child: const Icon(
                    CupertinoIcons.refresh,
                    color: AppColors.primaryColor,
                  )),
              const Spacer(),
              InkWell(
                onTap: () {
                  // _fetchWaterHistory();
                  _onSeeAll();
                },
                child: const Text(
                  "See All",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          BlocBuilder<WaterHistoryBloc, WaterHistoryState>(
            bloc: _waterHistoryBloc,
            builder: (context, fetchState) {
              if (fetchState is WaterHistoryLoading) {
                return Skeletonizer(
                    enabled: true,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return WaterHistoryItem(
                            waterHistory: FakeData.fakeWaterHistories[index],
                          );
                        },
                      ),
                    ));
              } else if (fetchState is WaterHistoryLoaded) {
                _waterHistories = fetchState.waterHistories;
                if (fetchState.waterHistories.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Your water history will be displayed here",
                        style: AppTextStyle.defaultBold(color: Colors.grey),
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: fetchState.waterHistories.length > 5
                          ? 5
                          : fetchState.waterHistories.length,
                      itemBuilder: (context, index) {
                        return WaterHistoryItem(
                          waterHistory: fetchState.waterHistories[index],
                        );
                      },
                    ),
                  );
                }
              } else if (fetchState is WaterHistoryError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Error loading water history",
                      style: AppTextStyle.defaultBold(color: Colors.red),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  void _onSeeAll() {
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) => WaterHistoryPage(
        waterHistories: _waterHistories, // Use local state
      ),
    );
  }
}
