// // import 'package:flutter/material.dart';

// // class NavigationBar extends StatefulWidget {
// //   final Function(String) onTabSelected;

// //   const NavigationBar({Key? key, required this.onTabSelected})
// //       : super(key: key);

// //   @override
// //   _NavigationBarState createState() => _NavigationBarState();
// // }

// // class _NavigationBarState extends State<NavigationBar> {
// //   String _selectedTab = 'Home'; // Default tab

// //   void _onTabTap(String tab) {
// //     setState(() {
// //       _selectedTab = tab;
// //     });
// //     widget.onTabSelected(tab); // Notify parent widget
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         Container(
// //           height: 90,
// //           decoration: const BoxDecoration(
// //             color: Colors.white,
// //             border: Border(
// //               top: BorderSide(
// //                 color: Color(0xFFDADADA),
// //                 width: 1,
// //               ),
// //             ),
// //           ),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceAround,
// //             children: [
// //               _buildNavItem('Games',
// //                   'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYL'),
// //               _buildNavItem('Home',
// //                   'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYM'),
// //               _buildNavItem('Goals',
// //                   'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYN'),
// //             ],
// //           ),
// //         ),
// //         Container(height: 10, color: Colors.white), // Safe space at the bottom
// //       ],
// //     );
// //   }

// //   Widget _buildNavItem(String label, String iconUrl) {
// //     bool isSelected = _selectedTab == label;

// //     return GestureDetector(
// //       onTap: () => _onTabTap(label),
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           AnimatedContainer(
// //             duration: const Duration(milliseconds: 300),
// //             width: isSelected ? 70 : 50,
// //             height: isSelected ? 70 : 50,
// //             decoration: isSelected
// //                 ? const BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     color: Colors.orange,
// //                   )
// //                 : null,
// //             child: Center(
// //               child: AnimatedContainer(
// //                 duration: const Duration(milliseconds: 300),
// //                 width: isSelected ? 40 : 30,
// //                 height: isSelected ? 40 : 30,
// //                 child: Image.network(
// //                   iconUrl,
// //                   color: isSelected ? Colors.white : Colors.black,
// //                   fit: BoxFit.contain,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           const SizedBox(height: 4),
// //           AnimatedDefaultTextStyle(
// //             duration: const Duration(milliseconds: 300),
// //             style: TextStyle(
// //               fontSize: isSelected ? 16 : 14,
// //               fontWeight: FontWeight.w600,
// //               color: isSelected ? Colors.orange : Colors.black,
// //             ),
// //             child: Text(label),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';

// class NavigationBar extends StatefulWidget {
//   final Function(String) onTabSelected;

//   const NavigationBar({Key? key, required this.onTabSelected})
//       : super(key: key);

//   @override
//   _NavigationBarState createState() => _NavigationBarState();
// }

// class _NavigationBarState extends State<NavigationBar> {
//   String _selectedTab = 'Home'; // Default tab

//   void _onTabTap(String tab) {
//     setState(() {
//       _selectedTab = tab;
//     });
//     widget.onTabSelected(tab); // Notify parent widget
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           height: 90,
//           padding: const EdgeInsets.only(top: 8), // Push items upwards
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             border: Border(
//               top: BorderSide(
//                 color: Color(0xFFDADADA),
//                 width: 1,
//               ),
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildNavItem('Games',
//                   'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYL'),
//               _buildNavItem('Home',
//                   'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYM'),
//               _buildNavItem('Goals',
//                   'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYN'),
//             ],
//           ),
//         ),
//         Container(height: 10, color: Colors.white), // Safe space at the bottom
//       ],
//     );
//   }

//   Widget _buildNavItem(String label, String iconUrl) {
//     bool isSelected = _selectedTab == label;

//     return GestureDetector(
//       onTap: () => _onTabTap(label),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             width: isSelected ? 70 : 50,
//             height: isSelected ? 70 : 50,
//             decoration: isSelected
//                 ? const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.orange,
//                   )
//                 : null,
//             child: Center(
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 width: isSelected ? 40 : 30,
//                 height: isSelected ? 40 : 30,
//                 child: Image.network(
//                   iconUrl,
//                   color: isSelected ? Colors.white : Colors.black,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 4),
//           AnimatedDefaultTextStyle(
//             duration: const Duration(milliseconds: 300),
//             style: TextStyle(
//               fontSize: isSelected ? 16 : 14,
//               fontWeight: FontWeight.w600,
//               color: isSelected ? Colors.orange : Colors.black,
//             ),
//             child: Text(label),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 90, // Adjusted height to avoid overflow
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
              _buildNavItem('Games',
                  'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYL'),
              _buildNavItem('Home',
                  'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYM'),
              _buildNavItem('Goals',
                  'https://dashboard.codeparrot.ai/api/assets/Z43jPHTr0Kgj1uYN'),
            ],
          ),
        ),
        const SizedBox(height: 10), // Added safe space below the navigation bar
      ],
    );
  }

  Widget _buildNavItem(String label, String iconUrl) {
    bool isSelected = _selectedTab == label;

    return GestureDetector(
      onTap: () => _onTabTap(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: isSelected
            ? Matrix4.translationValues(
                0, -6, 0) // Raised effect for selected tab
            : Matrix4.identity(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50, // Fixed width for consistency
              height: 50, // Fixed height for consistency
              decoration: isSelected
                  ? const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange, // Orange background for selected
                    )
                  : null, // No background for unselected
              child: Center(
                child: Image.network(
                  iconUrl,
                  width: isSelected ? 36 : 30, // Slightly enlarge for selected
                  height: isSelected ? 36 : 30,
                  color: isSelected ? Colors.white : Colors.black,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize:
                    isSelected ? 16 : 14, // Adjust font size for selection
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
