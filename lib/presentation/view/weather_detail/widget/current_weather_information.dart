import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/helper.dart';

class CurrentWeatherInformation extends StatelessWidget {
  const CurrentWeatherInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 3),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(
              color: Colors.white.withOpacity(0.15),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Today, ${Helper.getFormattedDate()}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "24 °C",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: const Offset(3, 3),
                          blurRadius: 15,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Windy",
                    style:
                        AppTextStyle.defaultBold(color: Colors.white).copyWith(
                      shadows: [
                        Shadow(
                          offset: const Offset(3, 3),
                          blurRadius: 20,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const Icon(CupertinoIcons.wind, color: Colors.white),
                      const SizedBox(width: 5),
                      Text(
                        "Wind",
                        style: AppTextStyle.defaultBold(color: Colors.white),
                      ),
                      const Spacer(),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      const Spacer(),
                      SizedBox(
                          width: 70,
                          child: Text(
                            "12 km/h",
                            style:
                                AppTextStyle.defaultBold(color: Colors.white),
                          )),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const Icon(CupertinoIcons.drop, color: Colors.white),
                      const SizedBox(width: 5),
                      Text(
                        "Hum ",
                        style: AppTextStyle.defaultBold(color: Colors.white),
                      ),
                      const Spacer(),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 70,
                        child: Text(
                          "54 %",
                          style: AppTextStyle.defaultBold(color: Colors.white),
                        ),
                      ),
                      const Spacer(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
