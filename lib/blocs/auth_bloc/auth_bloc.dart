import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_supabase/repository/supabase_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SupabaseRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepository.signInWithEmail(event.email, event.password);
        emit(AuthSuccess());
      } on AuthException catch (e) {
        emit(AuthFailure(e.message));
      } catch (_) {
        emit(const AuthFailure("An unexpected error occurred"));
      }
    });
  }
}
