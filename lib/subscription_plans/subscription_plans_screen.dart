import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/subscription_plans/credit_card_screen.dart';
import 'package:clc_app/subscription_plans/subscription_card_view.dart';
import 'package:flutter/material.dart';

class SubscriptionPlansScreen extends StatelessWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Subscription Plans"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 1,
          // crossAxisSpacing: 8.0,
          // mainAxisSpacing: 8.0,
          childAspectRatio: 1.5,
          children: [
            SubscriptionCard(
              title: "ChowLucky Plus Weekly",
              price: "\$0.88",
              duration: "For the first 8 weeks, pay just",
              renews: "Renews \$1.88 per week",
              onClicked: () {
                Navigation.push(
                    context: context,
                    moveTo: CreditCardFormScreen(amount: "\$0.88"));
              },
            ),
            SubscriptionCard(
              title: "ChowLucky Plus Special",
              price: "\$38.88",
              duration: "Pay just",
              renews: "Renews at \$48.88 every 6 months",
              oldPrice: "\$48.88",
              onClicked: () {
                Navigation.push(
                    context: context,
                    moveTo: CreditCardFormScreen(amount: "\$38.88"));
              },
            ),
            SubscriptionCard(
              title: "ChowLucky Plus Annual",
              price: "\$58.88",
              duration: "Pay just",
              renews: "Renews \$78 per year",
              oldPrice: "\$97.76",
              isTopChoice: true,
              onClicked: () {
                Navigation.push(
                    context: context,
                    moveTo: CreditCardFormScreen(amount: "\$58.88"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
