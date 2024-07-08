import 'package:flutter/cupertino.dart';
import 'package:supermarket/features/Home/presentation/widgets/exclusive_offer_widget.dart';

class ExclusiveOfferWidgetListView extends StatelessWidget {
  const ExclusiveOfferWidgetListView({super.key, required this.products});

  final List products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ExclusiveOfferWidget(
              product: products[index],
            ),
          );
        },
      ),
    );
  }
}
