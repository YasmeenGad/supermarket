import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/auth/domain/usecases/auth_usecase.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_event.dart';
import 'package:supermarket/features/checkout/domain/entities/create_customer.dart';
import 'package:supermarket/features/checkout/domain/usecase/payment_usecase.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;
  final PaymentUsecase paymentUsecase;

  AuthBloc({
    required this.authUsecase,
    required this.paymentUsecase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<SendResetCodeEvent>(_onSendResetCodeEvent);
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
    on<ResetPasswordEvent>(_onResetPasswordEvent);
    on<CreateCustomerEvent>(_createCustomer);
    on<NavigateToLoginEvent>(_onNavigateToLoginEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authUsecase.login(event.email, event.password);

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authUsecase.register(event.userName, event.email, event.password);

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (message) {
        // Register successful, now create a customer
        add(CreateCustomerEvent(name: event.userName));
      },
    );
  }

  Future<void> _createCustomer(CreateCustomerEvent event, Emitter<AuthState> emit) async {
    emit(CustomerLoading());
    final result = await paymentUsecase.createCustomer(event.name);

    result.fold(
      (failure) => emit(CustomerError(message: failure.toString())),
      (customer) {
        emit(CustomerLoaded(customer: customer));
        add(NavigateToLoginEvent());
      },
    );
  }

  Future<void> _onNavigateToLoginEvent(NavigateToLoginEvent event, Emitter<AuthState> emit) async {
    // You may not need to handle navigation here; it's typically done in the UI.
  }

  Future<void> _onSendResetCodeEvent(SendResetCodeEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingResetPassword());
    final result = await authUsecase.sendOtp(event.email);
    result.fold(
      (failure) => emit(AuthFailureResetPassword(failure.toString())),
      (message) => emit(AuthSuccessResetPassword(message)),
    );
  }

  Future<void> _onVerifyOtpEvent(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingResetPassword());
    final result = await authUsecase.verifyOtp(event.otp);
    result.fold(
      (failure) => emit(AuthFailureResetPassword(failure.toString())),
      (token) => emit(AuthSuccessResetPassword(token)),
    );
  }

  Future<void> _onResetPasswordEvent(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingResetPassword());
    final result = await authUsecase.resetPassword(event.token, event.newPassword);
    result.fold(
      (failure) => emit(AuthFailureResetPassword(failure.toString())),
      (token) => emit(AuthSuccessResetPassword(token)),
    );
  }
}
