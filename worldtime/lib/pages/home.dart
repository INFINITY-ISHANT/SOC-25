import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late VideoPlayerController _bgController;
  Map data = {};

  @override
  void initState() {
    super.initState();
    // we’ll actually initialize _bgController later once we know data
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // only run once
    if (data.isEmpty) {
      data = ModalRoute
          .of(context)!
          .settings
          .arguments as Map;

      final bgFile = data['isdaytime']
          ? 'assets/day.mp4'
          : 'assets/night.mp4';

      _bgController = VideoPlayerController.asset(bgFile)
        ..initialize().then((_) {
          _bgController
            ..setLooping(true)
            ..play();
          setState(() {}); // now the video is ready
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    // data is already loaded in didChangeDependencies
    final isDay = data['isdaytime'] as bool;
    final textColor = isDay ? Colors.white : Colors.white;
    final buttonColor = isDay ? Colors.yellow : Colors.white;
    final bgColor = isDay ? Colors.grey : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            if (_bgController.value.isInitialized)
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _bgController.value.size.width,
                    height: _bgController.value.size.height,
                    child: VideoPlayer(_bgController),
                  ),
                ),
              ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      final result = await Navigator.pushNamed(context, '/location')
                      as Map<String, dynamic>?;    // cast to the correct type

                      if (result != null) {
                        setState(() {
                          data = {
                            'time': result['time'],
                            'location': result['location'],
                            'isdaytime': result['isdaytime'],
                            'flag': result['flag'],
                          };
                        });
                        // After data changes, reinitialize video:
                        final newBg = data['isdaytime']
                            ? 'assets/day.mp4'
                            : 'assets/night.mp4';
                        _bgController.pause();
                        _bgController.dispose();
                        _bgController = VideoPlayerController.asset(newBg)
                          ..initialize().then((_) {
                            _bgController
                              ..setLooping(true)
                              ..play();
                            setState(() {});
                          });
                      }
                    },
                    label: const Text('choose location'),
                    icon: const Icon(Icons.edit_location),
                  ),
                ),

                const SizedBox(height: 10),
                Text(
                  data['location'],
                  style: TextStyle(
                      color: textColor, fontSize: 28, letterSpacing: 2),
                ),
                Text(
                  data['time'],
                  style: TextStyle(fontSize: 66, color: textColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

