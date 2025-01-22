import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  String _selectedButton = '';

  void _onButtonTap(String button) {
    setState(() {
      _selectedButton = button;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110, // Increased height to accommodate enlarged elements
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
            padding:
                const EdgeInsets.fromLTRB(54, 8, 54, 4), // Adjusted padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem('Games',
                    'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYL'),
                _buildHomeButton(),
                _buildNavItem('Goals',
                    'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYN'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, String iconPath) {
    bool isSelected = _selectedButton == label;
    return GestureDetector(
      onTap: () => _onButtonTap(label),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        transform: isSelected
            ? Matrix4.translationValues(0, -10, 0)
            : Matrix4.identity(),
        decoration: isSelected
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange,
              )
            : null,
        padding: EdgeInsets.all(isSelected ? 12 : 0),
        constraints: BoxConstraints(
          minHeight: 80,
          maxHeight: 100,
          maxWidth: 100,
        ), // Constrain the size
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              iconPath,
              width: isSelected ? 48 : 40,
              height: isSelected ? 48 : 40,
              color: isSelected ? Colors.white : Colors.black,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: isSelected ? 18 : 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeButton() {
    bool isSelected = _selectedButton == 'Home';
    return GestureDetector(
      onTap: () => _onButtonTap('Home'),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        transform: isSelected
            ? Matrix4.translationValues(0, -10, 0)
            : Matrix4.identity(),
        width: isSelected ? 80 : 70,
        height: isSelected ? 80 : 70,
        padding: const EdgeInsets.all(8),
        decoration: isSelected
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange,
              )
            : BoxDecoration(
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYM',
              width: isSelected ? 48 : 40,
              height: isSelected ? 48 : 40,
              color: isSelected ? Colors.white : Colors.black,
            ),
            const SizedBox(height: 4),
            Text(
              'Home',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: isSelected ? 18 : 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
