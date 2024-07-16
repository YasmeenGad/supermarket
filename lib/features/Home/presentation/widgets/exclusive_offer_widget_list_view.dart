import 'package:flutter/cupertino.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/features/Home/presentation/widgets/exclusive_offer_widget.dart';

class ExclusiveOfferWidgetListView extends StatelessWidget {
  const ExclusiveOfferWidgetListView({super.key, required this.products});

  final List products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, AppRoutes.productDeatailsRoute,arguments: products[index]);
              },
              child: ExclusiveOfferWidget(
                product: products[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
