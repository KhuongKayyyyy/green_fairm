import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/field_overview.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/field_monitoring.dart';
import 'package:green_fairm/presentation/widget/action_button_icon.dart';

class FieldDetailPage extends StatefulWidget {
  final Field field;
  const FieldDetailPage({super.key, required this.field});

  @override
  State<FieldDetailPage> createState() => _FieldDetailPageState();
}

class _FieldDetailPageState extends State<FieldDetailPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 240 && !_showTitle) {
        setState(() {
          _showTitle = true;
        });
      } else if (_scrollController.offset <= 240 && _showTitle) {
        setState(() {
          _showTitle = false;
        });
      }
    });
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
            expandedHeight: 250,
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
                    "${widget.field.type!} Field",
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
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  FieldOverview(field: widget.field),
                  const SizedBox(height: 15),
                  const FieldMonitoring(),
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
}
