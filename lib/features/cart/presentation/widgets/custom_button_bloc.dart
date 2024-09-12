import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supermarket/core/constants/api_keys.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/features/cart/presentation/bloc/checkout_bloc/checkout_bloc.dart';
import 'package:supermarket/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:supermarket/features/checkout/data/models/paypal_item_model.dart';
import 'package:supermarket/features/checkout/data/models/paypal_model.dart';
import 'package:supermarket/features/checkout/domain/entities/create_customer.dart';
import 'package:supermarket/features/checkout/presentation/bloc/payment_bloc/payment_bloc.dart';

class CustomButtonBloc extends StatelessWidget {
  final dynamic amount;
  final Customer? customer;
  final String orderId;
  const CustomButtonBloc(
      {super.key,
      required this.amount,
      required this.customer,
      required this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          // successDialog(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.paymentSuccessRoute,
            arguments: customer,
            (Route<dynamic> route) => false,
          );
        }
      },
      builder: (context, state) {
        return Container(
          width: MediaQuery.sizeOf(context).width,
          child: Center(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.5,
              child: GestureDetector(
                onTap: () {
                  context
                      .read<CheckoutBloc>()
                      .add(Checkout(orderId: orderId, paymentMethod: 'Visa'));
                  context.read<PaymentBloc>().add(
                        MakePaymentEvent(
                          paymentIntentInputModel: PaymentIntentInputModel(
                            amount: amount,
                            currency: 'USD',
                            customerId: '${customer?.id}',
                          ),
                        ),
                      );

                  // paypal payment method

                  // var transactionsData = getTransactionsData();
                  // ExcutePaypalPayment(context, transactionsData);
                },
                child: CustomButton(
                  isLoading: state is PaymentLoading,
                  text: "Continue",
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void successDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset(
                        Assets.imageSuccess,
                        // width: 269,
                        // height: 240,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your Order has been accepted',
                        style: AppStyles.styleSemiBold28(context)
                            .copyWith(color: darkColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your items have been placed and are on their way to being processed',
                        style: AppStyles.styleMedium16(context)
                            .copyWith(color: secondaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                      // Navigator.pushNamedAndRemoveUntil(
                      //   context,
                      //   AppRoutes.homeLayoutRoute,
                      //   arguments: customer?.id,
                      //   (Route<dynamic> route) => false,
                      // ); // Navigate to the home screen
                    },
                    child: CustomButton(text: "Okay"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // paypal payment method

//   void ExcutePaypalPayment(BuildContext context,
//       ({PaypalModel amountModel, ItemsListModel itemList}) transactionsData) {
//     Navigator.of(context).push(MaterialPageRoute(
//       builder: (BuildContext context) => PaypalCheckoutView(
//         sandboxMode: true,
//         clientId: ApiKeys.clientId,
//         secretKey: ApiKeys.payPalSecretKey,
//         transactions: [
//           {
//             "amount": transactionsData.amountModel.toJson(),
//             "description": "The payment transaction description.",
//             "item_list": transactionsData.itemList.toJson(),
//           }
//         ],
//         note: "Contact us for any questions on your order.",
//         onSuccess: (Map params) async {
//           log("onSuccess: $params");
//           successDialog(context);
//         },
//         onError: (error) {
//           log("onError: $error");
//           Navigator.pop(context);
//         },
//         onCancel: () {
//           print('cancelled:');
//           Navigator.pop(context);
//         },
//       ),
//     ));
//   }

//   ({PaypalModel amountModel, ItemsListModel itemList}) getTransactionsData() {
//     var amountModel = PaypalModel(
//         total: "100",
//         currency: 'USD',
//         details: PaypalDetailsModel(
//             subtotal: "100", shipping: "0", shippingDiscount: 0));

//     List<ItemModel> items = [
//       ItemModel(name: "Apple", quantity: 4, price: '10', currency: "USD"),
//       ItemModel(name: "Pineapple", quantity: 5, price: '12', currency: "USD"),
//     ];

//     var itemList = ItemsListModel(items: items);
//     return (itemList: itemList, amountModel: amountModel);
//   }
// }
}
