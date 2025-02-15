import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:latlong2/latlong.dart';

class FarmFromSatelite extends StatefulWidget {
  final Field field;
  const FarmFromSatelite({super.key, required this.field});

  @override
  State<FarmFromSatelite> createState() => _FarmFromSateliteState();
}

class _FarmFromSateliteState extends State<FarmFromSatelite> {
  MapController mapController = MapController();
  double lat = 51.5007;
  double long = -0.1246;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    List<Location> locations = await locationFromAddress(widget.field.area!);
    lat = locations[0].latitude;
    long = locations[0].longitude;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController.move(LatLng(lat, long), 18);
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          // Wrap FlutterMap in an Expanded widget to give it bounded height
          Expanded(
              child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: FlutterMap(
                  mapController: mapController,
                  options: const MapOptions(
                    initialZoom: 5,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                      // urlTemplate:
                      //     'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',

                      userAgentPackageName: "com.example.green_fairm",
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 20,
                right: 80,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    CupertinoIcons.photo_camera_solid,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    CupertinoIcons.share_solid,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          )),
          InkWell(
            onTap: () {
              context.pop();
            },
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: AppColors.white,
              ),
              child: const Center(
                child: Text(
                  "Back",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
