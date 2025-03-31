import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/subscription_plans/subscription_card_view.dart';
import 'package:clc_app/subscription_plans/subscription_controller.dart';
import 'package:flutter/material.dart';

class SubscriptionPlansScreen extends StatelessWidget {
  final Function? onSuccess;
  const SubscriptionPlansScreen({super.key, this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Subscription Plans"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 1,
          childAspectRatio: 1.5,
          children: [
            SubscriptionCard(
              title: "ChowLucky Plus Weekly",
              price: "\$1",
              duration: "For the first 8 weeks, pay just",
              renews: "Renews \$2 per week",
              onClicked: () {
                SubscriptionController.instance.makePayment(1, (vl) {
                  if (vl) {
                    showSuccessPopup(context, () {
                      Navigation.pop(context: context);
                      onSuccess!();
                    });
                  } else {
                    showFailurePopup(context);
                  }
                });
                // Navigation.push(
                //     context: context,
                //     moveTo: CreditCardFormScreen(amount: "\$0.88"));
              },
            ),
            SubscriptionCard(
              title: "ChowLucky Plus Special",
              price: "\$38",
              duration: "Pay just",
              renews: "Renews at \$48.88 every 6 months",
              oldPrice: "\$48",
              onClicked: () {
                SubscriptionController.instance.makePayment(38, (vl) {
                  if (vl) {
                    showSuccessPopup(context, () {
                      onSuccess!();
                      Navigation.pop(context: context);
                    });
                  } else {
                    showFailurePopup(context);
                  }
                });
                // Navigation.push(
                //     context: context,
                //     moveTo: CreditCardFormScreen(amount: "\$38.88"));
              },
            ),
            SubscriptionCard(
              title: "ChowLucky Plus Annual",
              price: "\$58",
              duration: "Pay just",
              renews: "Renews \$78 per year",
              oldPrice: "\$97",
              isTopChoice: true,
              onClicked: () {
                SubscriptionController.instance.makePayment(58, (vl) {
                  if (vl) {
                    showSuccessPopup(context, () {
                      onSuccess!();
                      Navigation.pop(context: context);
                    });
                  } else {
                    showFailurePopup(context);
                  }
                });
                // Navigation.push(
                //     context: context,
                //     moveTo: CreditCardFormScreen(amount: "\$58.88"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
