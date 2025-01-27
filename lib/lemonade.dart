import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';

class LemonadeGame extends StatefulWidget {
  @override
  _LemonadeGameState createState() => _LemonadeGameState();
}

class _LemonadeGameState extends State<LemonadeGame> {
  int _currentIndex = 0;
  late AudioPlayer _backgroundPlayer;
  final AudioPlayer _effectPlayer = AudioPlayer();
  late VideoPlayerController _videoController;
  bool _showVideo = false;

  // List of all images
  final List<String> _images = List.generate(
    16, // 16 PNG images (1 to 16)
    (index) => 'assets/images/lemonade/${index + 1}.png',
  )..add('assets/images/lemonade/17.png'); // Add 17.png as the final image

  @override
  void initState() {
    super.initState();
    _initializeAudio();
    _initializeVideo();
  }

  /// Initialize and play background music
  Future<void> _initializeAudio() async {
    try {
      _backgroundPlayer = AudioPlayer();
      await _backgroundPlayer.setReleaseMode(ReleaseMode.loop); // Loop music
      await _backgroundPlayer.play(AssetSource('audio/background_music.mp3'));
    } catch (e) {
      print('Error initializing audio: $e');
    }
  }

  /// Initialize the video player
  void _initializeVideo() {
    _videoController =
        VideoPlayerController.asset('assets/images/lemonade/17.mp4')
          ..addListener(() {
            if (_videoController.value.isInitialized &&
                _videoController.value.position >=
                    _videoController.value.duration) {
              // Video has ended, show 17.png
              setState(() {
                _showVideo = false; // Hide video
                _currentIndex =
                    _images.length - 1; // Point to the final image (17.png)
              });
            }
          })
          ..initialize().then((_) {
            setState(() {}); // Update UI after initialization
          });
  }

  @override
  void dispose() {
    _backgroundPlayer.dispose(); // Dispose of the background player
    _effectPlayer.dispose(); // Dispose of the effects player
    _videoController.dispose(); // Dispose of the video player
    super.dispose();
  }

  /// Play a sound effect
  Future<void> _playEffect(String soundFile) async {
    try {
      await _effectPlayer.play(AssetSource('audio/$soundFile'));
    } catch (e) {
      print('Error playing effect: $e');
    }
  }

  /// Move to the next image
  Future<void> _nextImage() async {
    if (_currentIndex < _images.length - 1) {
      int duration = 0;

      // Handle sound effects for specific images
      switch (_currentIndex + 1) {
        case 6:
          duration = await _playEffectWithDuration('cut.mp3'); // Cut sound
          break;
        case 11:
        case 13:
          duration = await _playEffectWithDuration('poure.mp3'); // Pour sound
          break;
        case 15:
          duration = await _playEffectWithDuration('sugar.mp3'); // Sugar sound
          break;
        case 9:
          _playEffect('squeeze.mp3'); // Squeeze sound
          break;
        case 16:
          setState(() {
            _showVideo = true; // Show video on 16.png
          });
          _videoController.play(); // Play video
          return;
        default:
          _handleSoundEffects();
          break;
      }

      // Delay transition for the duration of the sound
      if (duration > 0) {
        await Future.delayed(Duration(milliseconds: duration));
      }

      setState(() {
        _currentIndex++;
      });
    } else {
      // Do nothing if we're at the last image
      print("Reached the end of the images");
    }
  }

  /// Play a sound effect and return its duration
  Future<int> _playEffectWithDuration(String soundFile) async {
    try {
      await _effectPlayer.play(AssetSource('audio/$soundFile'));
      Duration? duration = await _effectPlayer.getDuration();
      return duration?.inMilliseconds ?? 2000;
    } catch (e) {
      print('Error playing effect: $e');
      return 2000; // Default duration
    }
  }

  /// Handle sound effects for specific images
  void _handleSoundEffects() {
    switch (_currentIndex + 1) {
      case 1:
      case 2:
      case 3:
      case 4:
      case 7:
        _playEffect('click.mp3'); // Click sound
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _currentIndex < _images.length // Ensure index is valid
            ? (_showVideo
                ? (_videoController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: VideoPlayer(_videoController),
                      )
                    : CircularProgressIndicator())
                : GestureDetector(
                    onTap: () {
                      if (_currentIndex == _images.length - 1) {
                        // Exit when the user taps on 17.png
                        Navigator.pop(context);
                      } else {
                        _nextImage(); // Otherwise, move to the next image
                      }
                    },
                    child: Image.asset(
                      _images[_currentIndex],
                      fit: BoxFit.cover,
                    ),
                  ))
            : Text('Error: Invalid index'), // Fallback for invalid index
      ),
    );
  }
}
