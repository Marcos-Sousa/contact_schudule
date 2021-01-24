import 'package:flutter/material.dart';

class PageManager{
  PageManager(this._controlerPage);

  PageController _controlerPage;
  int page = 0;

  void setPage(int value){
    if(value == page) return;
    page = value;
    _controlerPage.jumpToPage(page);
  }

}