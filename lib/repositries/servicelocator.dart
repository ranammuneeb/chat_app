import 'package:chat_app/cubit/authcubit.dart';
import 'package:chat_app/repositries/authrepo.dart';
import 'package:chat_app/repositries/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';


final  getit=GetIt.instance;


Future<void> servicelocator() async{
  getit.registerLazySingleton(()=>Approute());
  getit.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getit.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getit.registerLazySingleton(()=>Authrepo());
  getit.registerFactory(
    ()=>Authcubit(
    authRepository: Authrepo(),
  ));
}