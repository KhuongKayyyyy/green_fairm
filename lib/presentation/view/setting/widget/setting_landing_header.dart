import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/widget/grey_button.dart';

class SettingLandingHeader extends StatelessWidget {
  const SettingLandingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.55,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImage.background),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.55,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.white.withOpacity(0.5),
            ],
          )),
        ),
        Positioned(
          top: 80,
          left: MediaQuery.of(context).size.width * 0.5 - 35,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              AppImage.appIcon,
              width: 60,
            ),
          ),
        ),
        Positioned(
            bottom: 20, left: 10, right: 10, child: _buildSampleFarm(context)),
      ],
    );
  }

  Widget _buildSampleFarm(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Khu vườn trên mây",
                style: AppTextStyle.mediumBold(color: AppColor.secondaryColor),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {},
                child: const Icon(
                  CupertinoIcons.pencil,
                  color: AppColor.secondaryColor,
                  size: 25,
                ),
              ),
              const Spacer(),
              GreyButton(
                  child: const Row(
                    children: [
                      Text("More detail"),
                      SizedBox(width: 5),
                      Icon(
                        CupertinoIcons.chevron_right,
                        size: 20,
                      )
                    ],
                  ),
                  onPressed: () {})
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildSampleInfo("Crop health", "Good"),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSampleInfo("Planting Date", "8/3/2003"),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSampleInfo("Harvest Date", "in 2 months"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSampleInfo(String informationType, String information) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        gradient: informationType == "Crop health"
            ? LinearGradient(
                colors: [AppColor.primaryColor.withOpacity(0.5), Colors.white],
                end: Alignment.bottomLeft,
                begin: Alignment.topCenter,
              )
            : null,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(informationType,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  information,
                  softWrap: true,
                  style: AppTextStyle.defaultBold(
                      color: informationType == "Crop health"
                          ? AppColor.primaryColor
                          : Colors.grey),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
