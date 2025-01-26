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

  /// Move to the next image
  void _nextImage() {
    if (_currentIndex < _images.length - 1) {
      _handleSoundEffects(); // Play sound effects based on the image
      setState(() {
        _currentIndex++;
      });
      _handleTimerImages(); // Check if the current image needs a timer
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
      case 9:
      case 16:
        _playEffect('click.mp3'); // Play click sound
        break;
      case 6:
        _playEffect('cut.mp3'); // Play cut sound
        break;
      case 9:
        _playEffect('squeeze.mp3'); // Play squeeze sound
        break;
      case 11:
      case 13:
        _playEffect('poure.mp3'); // Play pour sound
        break;
      case 15:
        _playEffect('sugar.mp3'); // Play sugar sound
        break;
      case 16:
        _playEffect('sparkle.mp3'); // Play sparkle sound
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
