import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  String _selectedButton = 'Home'; // Default selected button

  void _onButtonTap(String button) {
    setState(() {
      _selectedButton = button;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 90, // Fixed height for navigation bar
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Color(0xFFDADADA),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                'Games',
                'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYL',
              ),
              _buildNavItem(
                'Home',
                'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYM',
              ),
              _buildNavItem(
                'Goals',
                'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYN',
              ),
            ],
          ),
        ),
        Container(
          height: 20, // Safe space at the bottom
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _buildNavItem(String label, String iconUrl) {
    bool isSelected = _selectedButton == label;
    return GestureDetector(
      onTap: () => _onButtonTap(label),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60, // Fixed width for all icons
            height: 60, // Fixed height for all icons
            decoration: isSelected
                ? const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange, // Orange background for selected
                  )
                : null, // No background for unselected
            child: Center(
              child: Image.network(
                iconUrl,
                width: 30, // Same size for all icons
                height: 30,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.orange : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
