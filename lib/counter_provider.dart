import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier{
  int _counter=0;
  //get value using single function
  int get count {
    return _counter;
  }

  //events
  void incrementCount(){
    _counter++;
    notifyListeners();
  }
  void reset(){
    _counter = 0;
    notifyListeners();
  }
  void decrementCount(){
    if(_counter>0){
      _counter--;
      notifyListeners();
    }
  }

}