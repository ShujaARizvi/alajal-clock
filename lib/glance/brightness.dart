import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrightnessControl extends StatefulWidget {
  const BrightnessControl({super.key});

  @override
  State<BrightnessControl> createState() => _BrightnessControlState();
}

class _BrightnessControlState extends State<BrightnessControl> {
  List<String> brightnessLevels = ['Auto', 'Low', 'Medium', 'High'];
  int currentBrightnessLevelIdx = 0;

  @override
  void initState() {
    loadBrightessLevelIdx();
    setBrightness();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentBrightnessLevelIdx =
              (currentBrightnessLevelIdx + 1) % brightnessLevels.length;
        });
        setBrightness();
        setBrightessLevelIdxInPrefs(currentBrightnessLevelIdx);
      },
      child: Stack(
        children: [
          Icon(
            getIconByBrightnessLevel(),
            color: Colors.white,
            size: 54.0,
          ),
          Container(
            transform: Matrix4.translationValues(0.0, 55.0, 0.0),
            child: const Text(
              'Brightness',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  IconData getIconByBrightnessLevel() {
    IconData brightnessIcon = Icons.brightness_auto_rounded;

    switch (currentBrightnessLevelIdx) {
      case 0:
        brightnessIcon = Icons.brightness_auto_rounded;
        break;
      case 1:
        brightnessIcon = Icons.brightness_4_rounded;
        break;
      case 2:
        brightnessIcon = Icons.brightness_6_rounded;
        break;
      case 3:
        brightnessIcon = Icons.brightness_7_rounded;
        break;
    }

    return brightnessIcon;
  }

  Future<void> setBrightness() async {
    try {
      double brightness = getBrightnessByBrightnessLevel();

      if (brightness == 0) {
        await ScreenBrightness().resetScreenBrightness();
      } else {
        await ScreenBrightness().setScreenBrightness(brightness);
      }
    } catch (e) {
      throw 'Failed to set brightness';
    }
  }

  double getBrightnessByBrightnessLevel() {
    double brightness = 0;

    switch (currentBrightnessLevelIdx) {
      case 0:
        brightness = 0;
        break;
      case 1:
        brightness = 0.33;
        break;
      case 2:
        brightness = 0.67;
        break;
      case 3:
        brightness = 1.0;
        break;
    }

    return brightness;
  }

  Future<void> loadBrightessLevelIdx() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentBrightnessLevelIdx = prefs.getInt('brightness_level_idx') ?? 0;
      setBrightness();
    });
  }

  Future<void> setBrightessLevelIdxInPrefs(int brightnessLevelIdx) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('brightness_level_idx', brightnessLevelIdx);
  }
}
