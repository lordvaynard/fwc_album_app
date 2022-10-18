import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

mixin Loader<T extends StatefulWidget> on State <T>{ //mixin bloqueia onde pode ser utilizado, pode utilizar tudo do state por herança

  var isOpen = false;
  void showLoader(){
    if(!isOpen){
      isOpen = true;
      showDialog(
        context: context, //context vem do state, e só pode usar essa classe dentro de um estado
        builder: (_){
            return LoadingAnimationWidget.threeArchedCircle(
              color: Colors.white,
              size: 60,
            );
        });//Abre uma dialog
    }
  }

  void hideLoader(){
    if(isOpen){
      isOpen = false;
      Navigator.of(context).pop(); //fecha dialog
    }
  }
}
