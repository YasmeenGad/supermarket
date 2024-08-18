import 'package:flutter/material.dart';
import 'package:supermarket/core/utils/app_routes.dart';
import 'package:supermarket/core/widgets/custom_button.dart';
import 'package:supermarket/features/checkout/presentation/widgets/custom_credit_card.dart';
import 'package:supermarket/features/checkout/presentation/widgets/payment_methods.dart';

class PaymentDetailsViewBody extends StatefulWidget {
  const PaymentDetailsViewBody({super.key});

  @override
  State<PaymentDetailsViewBody> createState() => _PaymentDetailsViewBodyState();
}

class _PaymentDetailsViewBodyState extends State<PaymentDetailsViewBody> {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
     AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: PaymentMethodsListView(),
        ),
        SliverToBoxAdapter(
          child: CustomCreditCard(
            autovalidateMode: autovalidateMode,
            formKey: formKey,),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                child: GestureDetector(
                  onTap: (){
                    if(formKey.currentState!.validate()){
                      formKey.currentState!.save();
                      Navigator.pushNamed(context, AppRoutes.paymentSuccessRoute);
                    }else{
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {
                        
                      });
                    }
                  },
                  child: const CustomButton(text: 'Complete Payment',)),
              )),
        )
      ],
    );
  }
}
