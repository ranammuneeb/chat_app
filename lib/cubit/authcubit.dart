import 'dart:async';

import 'package:chat_app/cubit/authstate.dart';
import 'package:chat_app/repositries/authrepo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Authcubit extends Cubit<Authstate>{
  final Authrepo _authrepositry;
  StreamSubscription<User?>? authstatesubscription;
   Authcubit({
    required Authrepo authRepository,
  })  : _authrepositry = authRepository,
        super(const Authstate()) {
    _init();
  }
  
  void _init(){
    emit(state.copyWith(status:AuthStatus.initial));

    authstatesubscription=_authrepositry.authStateChanges.listen((user)async{
      if(user!=null)
      {
        try {
          final userdata= await _authrepositry.getUserData(user.uid);
          emit(state.copyWith(status: AuthStatus.authenticated,user: userdata,));
        } catch (e) {
          emit(state.copyWith(status: AuthStatus.error,error: e.toString()));
        }
      }
      else{
        emit(state.copyWith(status: AuthStatus.unauthenticated,user: null));
      }
    });
  }

  Future<void> sigin
  (
    {
      required email,
      required password,
    }
  )
  async {
    try {

      
      emit(state.copyWith(
        status: AuthStatus.loading,
        
      ));

      final user2= await _authrepositry.signin(email: email, password: password);
       emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user2,
        
      ));
      
    } catch (e) {
      emit(state.copyWith(
        error:e.toString() ,
        user: null,
      ));
    }

  }



  Future<void> signup
  (
    {
      required email,
      required password,
      required fullName,
      required phoneNumber,
      required username
    }
  )
  async {
    try {

      
      emit(state.copyWith(
        status: AuthStatus.loading,
        
      ));

      final user2= await _authrepositry.signup(fullName: fullName, username: username, email: email, phoneNumber: phoneNumber, password: password);
       emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user2,
        
      ));
      
    } catch (e) {
      emit(state.copyWith(
        error:e.toString() ,
        user: null,
      ));
    }

  }

  Future<void> signout() async{

    try {
      _authrepositry.signout();
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        user: null,
      ));
      
    } catch (e) {
       emit(state.copyWith(
        error:e.toString() ,
        user: null,
      ));
    }
  }



}