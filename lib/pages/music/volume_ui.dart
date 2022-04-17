import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// TODO
// we need to custimize this to our own needs if possible

class VolumeSlider extends StatelessWidget {
  final _volume = ValueNotifier<int>(100);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text(
          "Sound",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        Expanded(
          child: ValueListenableBuilder<int>(
            // constant updating applied to volume
            valueListenable: _volume,
            builder: (context, volume, _) {
              return Slider(
                inactiveColor: Colors.transparent,
                activeColor: Theme.of(context).colorScheme.onSurface,
                value: volume.toDouble(),
                // attributes of slider
                min: 0.0,
                max: 100.0,
                divisions: 20,
                // this is the indicator # of current position on slider
                label: '$volume',
                onChanged: (value) {
                  _volume.value = value.round();
                  context.ytController.setVolume(volume);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
