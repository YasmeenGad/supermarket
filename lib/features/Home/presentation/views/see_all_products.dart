import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/features/Home/presentation/widgets/exclusive_offer_widget.dart';

class SeeAllProducts extends StatelessWidget {
  const SeeAllProducts(
      {super.key, required this.products, required this.title});

  final List products;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: darkColor,
          ),
        ),
        title: Text(
          '${title}',
          style: AppStyles.styleSemiBold20(context).copyWith(color: darkColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: GridView.builder(
                itemCount: products.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 0.69,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, AppRoutes.productDeatailsRoute,arguments: products[index]);
                    },
                    child: ExclusiveOfferWidget(
                      product: products[index],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
