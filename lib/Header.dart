import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String greeting;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onEditTap;

  const Header({
    Key? key,
    this.greeting = 'Good Morning, Maymoona!',
    this.onNotificationTap,
    this.onEditTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(150, 243, 142, 34),
            Color.fromARGB(150, 245, 161, 71),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              greeting,
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Row(
          //   children: [
          //     IconButton(
          //       icon: Image.network(
          //         'https://dashboard.codeparrot.ai/api/assets/Z43jJnTr0Kgj1uYE',
          //         width: 48,
          //         height: 46,
          //       ),
          //       onPressed: onEditTap,
          //       iconSize: 48,
          //     ),
          //     SizedBox(width: 8),
          //     IconButton(
          //       icon: Image.network(
          //         'https://dashboard.codeparrot.ai/api/assets/Z43jJnTr0Kgj1uYF',
          //         width: 56,
          //         height: 57,
          //       ),
          //       onPressed: onNotificationTap,
          //       iconSize: 56,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
