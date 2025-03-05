import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:flutter/material.dart';

class RewardCard extends StatelessWidget {
  final Reward reward;

  const RewardCard({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            SizedBox(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      reward.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  customText(title: "Selera Delight", color: Colors.grey)
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 175,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    maxLines: 2,
                    isSingleLine: true,
                    title: reward.title,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 8),
                  customText(
                      title: reward.description,
                      fontSize: 14,
                      color: Colors.black54),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(3),
                    value: reward.progress,
                    backgroundColor:
                        !reward.isPaid ? primeColor : Colors.grey[300],
                    minHeight: 6,
                  ),
                ],
              ),
            ),
            reward.isPaid
                ? Image.asset("ribbon.png".directory(), scale: 20)
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

class Reward {
  final String imageUrl;
  final String title;
  final String description;
  final String subtitle;
  final double progress;
  final int maxPoints;
  final int currentPoints;
  final bool isPaid;

  Reward({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.subtitle,
    required this.progress,
    required this.maxPoints,
    required this.currentPoints,
    this.isPaid = false,
  });
}
