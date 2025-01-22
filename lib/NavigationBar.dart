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
          height: 100, // Adjusted height for the navigation bar
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
          height: 10, // Safe space below the navigation bar
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _buildNavItem(String label, String iconUrl) {
    bool isSelected = _selectedButton == label;

    return GestureDetector(
      onTap: () => _onButtonTap(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: isSelected
            ? Matrix4.translationValues(0, -10, 0) // Raise tab when selected
            : Matrix4.identity(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isSelected ? 70 : 60, // Circle enlarges when selected
              height: isSelected ? 70 : 60,
              decoration: isSelected
                  ? const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange, // Orange circle for selected tab
                    )
                  : null,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isSelected ? 40 : 30, // Icon enlarges when selected
                  height: isSelected ? 40 : 30,
                  child: Image.network(
                    iconUrl,
                    color: isSelected ? Colors.white : Colors.black,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: isSelected ? 16 : 14, // Enlarge text for selected tab
                fontWeight: FontWeight.w700, // Make text bolder
                color: isSelected ? Colors.orange : Colors.black,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
