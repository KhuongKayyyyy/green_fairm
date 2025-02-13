import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

class TemperatureMonitoring extends StatelessWidget {
  final double currentTemperature; // Nhiệt độ hiện tại
  const TemperatureMonitoring({super.key, required this.currentTemperature});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            "Temperature - Environment Measured",
            style: AppTextStyle.defaultBold(),
          ),
          const SizedBox(height: 20),

          // Vạch nhiệt độ
          Column(
            children: [
              Row(
                children: [
                  // Min Value (0°C)
                  const Text(
                    "0°C",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(width: 5),

                  // Vạch nhiệt độ chính
                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        // Thanh gradient
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.blue, // Màu lạnh (0°C)
                                Colors.yellow, // Màu trung bình (25°C)
                                Colors.red, // Màu nóng (50°C)
                              ],
                              stops: [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),

                        // Chấm tròn hiển thị nhiệt độ
                        Positioned(
                          left: (currentTemperature / 50) *
                              MediaQuery.of(context).size.width *
                              0.75, // Tính toán vị trí chấm
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),

                  // Max Value (50°C)
                  const Text(
                    "50°C",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "$currentTemperature°C",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              _buildTemperatureStatus(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureStatus() {
    String status;
    Color statusColor;
    IconData statusIcon;

    if (currentTemperature < 25) {
      status = "Cold";
      statusColor = Colors.blue;
      statusIcon = Icons.ac_unit;
    } else if (currentTemperature >= 25 && currentTemperature <= 30) {
      status = "Normal";
      statusColor = AppColors.primaryColor;
      statusIcon = Icons.check_circle;
    } else if (currentTemperature >= 31 && currentTemperature <= 40) {
      status = "Kinda hot";
      statusColor = Colors.orange;
      statusIcon = Icons.warning;
    } else {
      // currentTemperature > 40
      status = "Super hot";
      statusColor = Colors.red;
      statusIcon = Icons.dangerous;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Icon(
            statusIcon,
            color: statusColor,
          ),
          const SizedBox(width: 5),
          Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
