import 'package:flutter/material.dart';

class SavingsInfo extends StatelessWidget {
  final double savingsAmount;
  final String currency;
  final VoidCallback onAddToSavings;

  const SavingsInfo({
    Key? key,
    this.savingsAmount = 33.870,
    this.currency = 'KWD',
    required this.onAddToSavings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 110,
      ),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Savings Text
          const Text(
            'Savings',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),

          // Amount Row
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                savingsAmount.toStringAsFixed(3),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                currency,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.65),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Add To Savings Button
          ElevatedButton(
            onPressed: onAddToSavings,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFF5A44D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(178, 39),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: const Text(
              '+ Add To Savings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
