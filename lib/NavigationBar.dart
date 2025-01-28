import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  final Function(String) onTabSelected;

  const NavigationBar({Key? key, required this.onTabSelected})
      : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  String _selectedTab = 'Home'; // Default tab

  void _onTabTap(String tab) {
    setState(() {
      _selectedTab = tab;
    });
    widget.onTabSelected(tab); // Notify parent widget
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // Set initial padding to prevent animation
    return MediaQuery(
      data: mediaQuery.copyWith(
        padding: mediaQuery.padding.copyWith(bottom: 0),
        viewPadding: mediaQuery.padding.copyWith(bottom: 0),
        viewInsets: mediaQuery.viewInsets.copyWith(bottom: 0),
      ),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100, // Reduced from 120
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
                  _buildNavItem('Games', Icons.videogame_asset),
                  _buildNavItem('Home', Icons.home),
                  _buildNavItem('Goals', Icons.flag),
                ],
              ),
            ),
            Container(
              height: mediaQuery.padding.bottom,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, IconData icon) {
    bool isSelected = _selectedTab == label;

    return GestureDetector(
      onTap: () => _onTabTap(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: isSelected
            ? Matrix4.translationValues(0, -6, 0) // Reduced from -8
            : Matrix4.identity(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 55, // Reduced from 65
              height: 55, // Reduced from 65
              decoration: isSelected
                  ? const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange, // Orange background for selected
                    )
                  : null, // No background for unselected
              child: Center(
                child: Icon(
                  icon,
                  size: isSelected ? 36 : 32, // Reduced from 42/36
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 4), // Reduced from 6
            Text(
              label,
              style: TextStyle(
                fontSize: isSelected ? 18 : 16, // Reduced from 20/18
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.orange : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
