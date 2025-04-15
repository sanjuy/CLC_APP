import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final String duration;
  final String renews;
  final String? oldPrice;
  final bool isTopChoice;
  final Function() onClicked;

  const SubscriptionCard({
    required this.title,
    required this.price,
    required this.duration,
    required this.renews,
    this.oldPrice,
    this.isTopChoice = false,
    required this.onClicked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isTopChoice)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16),
              ),
              child: customText(
                title: "TOP CHOICE",
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(height: 8),
          customText(
            title: title,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            alignment: TextAlign.center,
          ),
          const SizedBox(height: 8),
          customText(
            title: duration,
            alignment: TextAlign.center,
          ),
          const SizedBox(height: 4),
          if (oldPrice != null)
            Text(
              oldPrice!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.red,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          customText(
            title: price,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            alignment: TextAlign.center,
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              onPressed: () => onClicked(),
              child: customText(title: "Subscribe now", color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: customText(
              title: renews,
              color: Colors.grey,
              fontSize: 12,
              alignment: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}
