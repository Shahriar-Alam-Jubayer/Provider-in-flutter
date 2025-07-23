import 'package:flutter/material.dart';

class ListMapProvider extends ChangeNotifier{

  // List<Map<string,dynamic>> _mData = [];
  final List<Map<String,dynamic>> _mData = [];
  List<Map<String,dynamic>> getData() => _mData; // => means return
  ///events
  void addData(Map<String,dynamic>data){
    _mData.add(data);
    notifyListeners();
  }
  void updateData(Map<String,dynamic> updateData, int index){
    _mData[index] = updateData;
    notifyListeners();
  }
  void deleteData(int index){
    _mData.removeAt(index);
    notifyListeners();
  }
}