// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../domain/usecases/login_usecase.dart';
// import 'auth_event.dart';
// import 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final LoginUseCase loginUseCase;

//   AuthBloc(this.loginUseCase) : super(AuthInitial()) {

//     on<LoginWithApiEvent>((event, emit) async {
//       emit(AuthLoading());
//       try {
//         final user = await loginUseCase.loginWithApi(event.email, event.password);
//         emit(AuthSuccess(user));
//       } catch (e) {
//         emit(AuthFailure(e.toString()));
//       }
//     });

//     on<LoginWithFirebaseEvent>((event, emit) async {
//       emit(AuthLoading());
//       try {
//         final user = await loginUseCase.loginWithFirebase(event.email, event.password);
//         emit(AuthSuccess(user));
//       } catch (e) {
//         emit(AuthFailure(e.toString()));
//       }
//     });
//   }
// }
