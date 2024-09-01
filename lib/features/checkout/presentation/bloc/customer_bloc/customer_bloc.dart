// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
// import 'package:supermarket/features/checkout/domain/entities/create_customer.dart';
// import 'package:supermarket/features/checkout/domain/usecase/payment_usecase.dart';

// part 'customer_event.dart';
// part 'customer_state.dart';

// class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
//   final PaymentUsecase paymentUsecase;
//   CustomerBloc({required this.paymentUsecase}) : super(CustomerInitial()) {
//     on<CreateCustomerEvent>(_createCustomer);
//   }

//   Future<void> _createCustomer(
//       CreateCustomerEvent event, Emitter<CustomerState> emit) async {
//     emit(CustomerLoading());
//     final result = await paymentUsecase.createCustomer(event.name);
//     result.fold(
//       (failure) => emit(CustomerError(message: failure.toString())),
//       (success) => emit(CustomerLoaded(customer: success)),
//     );
//   }
// }
