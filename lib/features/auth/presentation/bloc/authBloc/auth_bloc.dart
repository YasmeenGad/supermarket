// lib/presentation/bloc/auth/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/auth/domain/usecases/login_usecase.dart';
import 'package:supermarket/features/auth/domain/usecases/register_usecase.dart';
import '../../../domain/entities/user.dart';



part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase login;
  final RegisterUsecase register;

  AuthBloc({required this.login, required this.register}) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
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
    final result = await register(event.username, event.email, event.password);

    result.fold(
      (failure) => emit(AuthFailure(failure.toString())),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
