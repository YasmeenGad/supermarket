import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/auth/domain/usecases/login_usecase.dart';
import 'package:supermarket/features/auth/domain/usecases/register_usecase.dart';
import 'package:supermarket/features/auth/domain/usecases/sendCode_and_verify_otp_usecase.dart';
import 'package:supermarket/features/auth/presentation/bloc/authBloc/auth_event.dart';



part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase login;
  final RegisterUsecase register;
  final SendOtpUsecase sendCode;
  final VerifyOtpUsecase verifyOtp;
  final ResetPasswordUsecase resetPassword;

  AuthBloc({required this.sendCode,required this.verifyOtp,required this.resetPassword, required this.login, required this.register}) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<SendResetCodeEvent>(_onSendResetCodeEvent);
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
    on<ResetPasswordEvent>(_onResetPasswordEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await login(event.email, event.password);

    result.fold(
      (failure) => emit(AuthFailure(failure.toString())),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await register(event.userName, event.email, event.password);

    result.fold(
      (failure) => emit(AuthFailure(failure.toString())),
      (message) => emit(AuthSuccess(message)),
    );


  }
   Future<void> _onSendResetCodeEvent(SendResetCodeEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingResetPassword());
    final result = await sendCode(event.email);
    result.fold(
      (failure) => emit(AuthFailureResetPassword(failure.toString())),
      (message) => emit(AuthSuccessResetPassword(message)),
    );
  }
  Future<void> _onVerifyOtpEvent(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingResetPassword());
    final result = await verifyOtp(event.otp);
    result.fold(
      (failure) => emit(AuthFailureResetPassword(failure.toString())),
      (token) => emit(AuthSuccessResetPassword(token)),
    );
  }
 Future<void> _onResetPasswordEvent(ResetPasswordEvent event, Emitter<AuthState> emit) async {
  emit(AuthLoadingResetPassword());
  final result = await resetPassword(event.token, event.newPassword);
  result.fold(
    (failure) => emit(AuthFailureResetPassword(failure.toString())),
    (token) => emit(AuthSuccessResetPassword(token)),
  );
}
}
