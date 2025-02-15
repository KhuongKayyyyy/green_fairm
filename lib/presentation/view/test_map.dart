import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TestMap extends StatefulWidget {
  const TestMap({super.key});

  @override
  State<TestMap> createState() => _TestMapState();
}

class _TestMapState extends State<TestMap> {
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    // Schedule the move after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController.move(const LatLng(51.5007, -0.1246), 16);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: const MapOptions(
              initialZoom: 5,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                // attributionBuilder: (_) {
                //   return const Text(
                //     "© Esri, Maxar, Earthstar Geographics, CNES/Airbus DS, GeoEye",
                //     style: TextStyle(fontSize: 10),
                //   );
                // },
                userAgentPackageName: "com.example.green_fairm",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
