import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFDADADA),
            width: 1,
          ),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(54, 16, 54, 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem('Games',
                    'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYL'),
                const SizedBox(width: 100), // Space for center button
                _buildNavItem('Goals',
                    'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYN'),
              ],
            ),
          ),
          Positioned(
            top: -40,
            child: _buildHomeButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, String iconPath) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(
          iconPath,
          width: 48,
          height: 48,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildHomeButton() {
    return Container(
      width: 84,
      height: 84,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF38E22),
            Color(0xFFF5A147),
            Color(0xFFF6AE60),
            Color(0xFFF49734),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYM',
            width: 48,
            height: 48,
          ),
          const SizedBox(height: 8),
          const Text(
            'Home',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
