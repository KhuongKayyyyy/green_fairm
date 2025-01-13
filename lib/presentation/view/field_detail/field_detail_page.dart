import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/helper.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/bloc/field_analysis/field_analysis_bloc.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/field_monitoring.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/field_overview.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/header_brief_information.dart';
import 'package:green_fairm/presentation/widget/action_button_icon.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FieldDetailPage extends StatefulWidget {
  final Field field;
  final VoidCallback onDelete;
  const FieldDetailPage(
      {super.key, required this.field, required this.onDelete});

  @override
  State<FieldDetailPage> createState() => _FieldDetailPageState();
}

class _FieldDetailPageState extends State<FieldDetailPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;
  double _opacity = 1.0;
  final FieldAnalysisBloc _fieldAnalysisBloc = FieldAnalysisBloc();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      if (offset > 330 && !_showTitle) {
        setState(() {
          _showTitle = true;
        });
      } else if (offset <= 330 && _showTitle) {
        setState(() {
          _showTitle = false;
        });
      }
      setState(() {
        _opacity = (1 - (offset / 330)).clamp(0.0, 1.0);
      });
    });
    _fieldAnalysisBloc.add(FieldAnalysisDailyAverageDataRequested(
      date: Helper.getTodayDateFormatted(),
      fieldId: widget.field.id!,
    ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            leadingWidth: 80,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: SizedBox(
                height: 40,
                width: 40,
                child: ActionButtonIcon(
                    icon: Icons.arrow_back, onPressed: () => context.pop()),
              ),
            ),
            title: _showTitle
                ? Text(
                    "${widget.field.name}",
                    style: AppTextStyle.mediumBold(
                        color: AppColors.secondaryColor),
                  )
                : null,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: "fieldImage${widget.field.id}",
                child: Image.network(
                  height: MediaQuery.of(context).size.height * 0.4,
                  widget.field.imageUrl ?? AppImage.placeholder,
                  fit: BoxFit.cover,
                ),
              ),
              title: !_showTitle ? _buildExpandedInformation() : null,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  FieldOverview(
                    field: widget.field,
                    onDelete: widget.onDelete,
                  ),
                  const SizedBox(height: 15),
                  FieldMonitoring(
                    field: widget.field,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Opacity _buildExpandedInformation() {
    return Opacity(
      opacity: _opacity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: BlocBuilder<FieldAnalysisBloc, FieldAnalysisState>(
          bloc: _fieldAnalysisBloc,
          builder: (context, dailyAverageState) {
            if (dailyAverageState is FieldAnalysisDailyAverageDataFailure) {
              return Text(dailyAverageState.errorMessage);
            } else if (dailyAverageState
                is FieldAnalysisDailyAverageDataSuccess) {
              return Row(
                children: [
                  const SizedBox(width: 10),
                  HeaderBriefInformation(
                      icon: CupertinoIcons.thermometer,
                      title: "Temperature",
                      data: "${dailyAverageState.temperatureAverage} °C"),
                  const SizedBox(width: 10),
                  HeaderBriefInformation(
                      icon: CupertinoIcons.drop,
                      title: "Humidity",
                      data: "${dailyAverageState.humidityAverage} %"),
                  const SizedBox(width: 10),
                  HeaderBriefInformation(
                      icon: CupertinoIcons.leaf_arrow_circlepath,
                      title: "Soil Moisture",
                      data: "${dailyAverageState.soilMoistureAverage} %"),
                ],
              );
            }
            return const Skeletonizer(
              enabled: true,
              enableSwitchAnimation: true,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  HeaderBriefInformation(
                    icon: CupertinoIcons.thermometer,
                    title: "Temperature",
                    data: "0",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  HeaderBriefInformation(
                    icon: Icons.abc,
                    title: "Temperature",
                    data: "0",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  HeaderBriefInformation(
                    icon: Icons.abc,
                    title: "Temperature",
                    data: "0",
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
