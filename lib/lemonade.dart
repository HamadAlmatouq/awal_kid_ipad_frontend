import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class LemonadeGame extends StatefulWidget {
  @override
  _LemonadeGameState createState() => _LemonadeGameState();
}

class _LemonadeGameState extends State<LemonadeGame> {
  int _currentIndex = 0;
  late AudioPlayer _backgroundPlayer;
  final AudioPlayer _effectPlayer =
      AudioPlayer(); // Separate player for sound effects

  // List of all images
  final List<String> _images = List.generate(
    16,
    (index) => 'assets/images/lemonade/${index + 1}.png',
  );

  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  /// Initialize and play background music
  Future<void> _initializeAudio() async {
    try {
      _backgroundPlayer = AudioPlayer();
      await _backgroundPlayer
          .setReleaseMode(ReleaseMode.loop); // Loop background music
      await _backgroundPlayer.play(AssetSource('audio/background_music.mp3'));
    } catch (e) {
      print('Error initializing audio: $e');
    }
  }

  @override
  void dispose() {
    _backgroundPlayer.dispose(); // Dispose of the background player
    _effectPlayer.dispose(); // Dispose of the effects player
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

  /// Play a sound effect and return its duration
  Future<int> _playEffectWithDuration(String soundFile) async {
    try {
      await _effectPlayer.play(AssetSource('audio/$soundFile'));
      Duration? duration = await _effectPlayer.getDuration();
      return duration?.inMilliseconds ??
          2000; // Get the sound's duration in milliseconds or default to 2000
    } catch (e) {
      print('Error playing effect: $e');
      return 2000; // Default duration if something goes wrong
    }
  }

  /// Move to the next image
  Future<void> _nextImage() async {
    if (_currentIndex < _images.length - 1) {
      int duration = 0;

      // Handle sound effects and timers for specific images
      switch (_currentIndex + 1) {
        case 6:
          duration =
              await _playEffectWithDuration('cut.mp3'); // Align with cut sound
          break;
        case 11:
        case 13:
          duration = await _playEffectWithDuration(
              'poure.mp3'); // Align with pour sound
          break;
        case 15:
          duration = await _playEffectWithDuration(
              'sugar.mp3'); // Align with sugar sound
          break;
        case 9:
          _playEffect('squeeze.mp3'); // Play immediately
          break;
        case 16:
          _playEffect('sparkle.mp3'); // Play immediately
          break;
        default:
          _handleSoundEffects(); // Play other sound effects
          break;
      }

      // Delay the transition for the duration of the sound (if applicable)
      if (duration > 0) {
        await Future.delayed(Duration(milliseconds: duration));
      }

      setState(() {
        _currentIndex++;
      });
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
        _playEffect('click.mp3'); // Play click sound
        break;
    }
  }

  /// Handle automatic transitions for specific images
  void _handleTimerImages() {
    // Images with timers: 6.png, 11.png, 13.png, 15.png
    if ([6, 11, 13, 15].contains(_currentIndex + 1)) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted && _currentIndex < _images.length - 1) {
          _nextImage(); // Automatically move to the next image
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _nextImage, // Tap anywhere to move to the next image
        child: Center(
          child: Image.asset(
            _images[_currentIndex],
            fit: BoxFit.cover, // Ensure the image covers the screen
          ),
        ),
      ),
    );
  }
}
