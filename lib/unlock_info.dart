import 'package:flutter/material.dart';

class UnlockInfo extends StatelessWidget {
  final double requiredAmount;
  final String currency;

  const UnlockInfo({
    Key? key,
    this.requiredAmount = 55.0,
    this.currency = 'KWD',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 180,
        maxWidth: 230,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'To unlock, your savings should exceed this amount:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$requiredAmount $currency',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 180,
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Container(
                width: 170,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Container(
                width: 160,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.09),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '?',
                    style: TextStyle(
                      fontSize: 96,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withOpacity(0.8),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
