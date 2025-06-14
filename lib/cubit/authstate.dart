import 'package:chat_app/models/usermodel.dart';
import 'package:equatable/equatable.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}
class Authstate extends Equatable{


  final String? error;
  final UserModel? user;
  final AuthStatus status;

  const Authstate({this.error, this.user, this.status=AuthStatus.initial});


   Authstate copyWith({
    AuthStatus? status,
    UserModel? user,
    String? error,
  }) {
    return Authstate(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [status,user,error];

}