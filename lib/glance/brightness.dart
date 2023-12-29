import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';

class BrightnessControl extends StatefulWidget {
  const BrightnessControl({super.key});

  @override
  State<BrightnessControl> createState() => _BrightnessControlState();
}

class _BrightnessControlState extends State<BrightnessControl> {
  List<String> brightnessLevels = ['Auto', 'Low', 'Medium', 'High'];
  int currentBrightnessLevelIdx = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentBrightnessLevelIdx =
              (currentBrightnessLevelIdx + 1) % brightnessLevels.length;
        });
        setBrightness();
      },
      child: Icon(
        getIconByBrightnessLevel(),
        color: Colors.white,
        size: 54.0,
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
}
