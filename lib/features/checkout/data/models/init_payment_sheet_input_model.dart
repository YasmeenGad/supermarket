class InitPaymentSheetInputModel{
 final String paymentIntentClientSecret;
 final String customerEphemeralKeySecret;
 final String customerId;

 InitPaymentSheetInputModel({
   required this.paymentIntentClientSecret,
   required this.customerEphemeralKeySecret,
   required this.customerId
 });

}