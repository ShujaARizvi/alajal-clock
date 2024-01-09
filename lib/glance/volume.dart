import 'package:flutter/material.dart';
import 'package:volume_controller/volume_controller.dart';

class VolumeControl extends StatefulWidget {
  const VolumeControl({super.key});

  @override
  State<VolumeControl> createState() => _VolumeControlState();
}

class _VolumeControlState extends State<VolumeControl> {
  double _volumeValue = 1.0;

  @override
  void initState() {
    super.initState();
    // Listen to system volume change
    VolumeController().listener((volume) {
      setState(() => _volumeValue = volume);
    });
  }

  @override
  void dispose() {
    VolumeController().removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          const Icon(
            Icons.volume_down,
            color: Colors.white,
            size: 24,
          ),
          Transform.rotate(
            angle: -0,
            child: SliderTheme(
              data: SliderThemeData(
                thumbColor: Colors.red, // Color of the thumb
                activeTrackColor:
                    Colors.white, // Color of the active portion of the track
                inactiveTrackColor:
                    Colors.grey, // Color of the inactive portion of the track
                overlayColor: Colors.red.withOpacity(
                    0.2), // Color of the overlay (when thumb is pressed)
                valueIndicatorColor: Colors.red, // Color of the value indicator
                trackHeight: 32.0, // Height of the track
                thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 0.0), // Rounded thumb shape
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
              ),
              child: Slider(
                // activeColor: Colors.white,
                value: _volumeValue,
                // label: 'Volume',
                onChanged: (value) => setState(() {
                  _volumeValue = value;

                  VolumeController().setVolume(_volumeValue);
                }),
              ),
            ),
          ),
          const Icon(
            Icons.volume_up,
            color: Colors.white,
            size: 24,
          ),
        ],
      ),
    );
  }
}
