
import 'package:flutter/material.dart';

class Approute
{
  final GlobalKey<NavigatorState> navigatorkey=GlobalKey<NavigatorState>();

  NavigatorState get mynavigator=>navigatorkey.currentState!;

  
 Future<T?> push<T>(Widget page) {
    return mynavigator.push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }
  void pop<T>([T? result]) {
    return mynavigator.pop(result);
  }


  Future<T?> pushutil<T>(Widget page) {
    return mynavigator.pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      (route)=>false,
    );
  }
}


