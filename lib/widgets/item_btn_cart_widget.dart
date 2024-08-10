import 'package:felling_listen/main.dart';
import 'package:felling_listen/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class ItemButtonCartWidget extends StatelessWidget {
  final ManagerAnimation manager;
  final int index;
  const ItemButtonCartWidget({super.key, required this.index , required this.manager});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        manager.runAnimation(index);
      },
      child: Container(
        color: Colors.blue,
        child: Center(child: Text("Add to cart" , style: TextStyle(color: Colors.white),),),),
    );
  }
}
