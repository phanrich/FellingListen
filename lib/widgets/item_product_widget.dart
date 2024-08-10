import 'package:felling_listen/main.dart';
import 'package:felling_listen/widgets/item_btn_cart_widget.dart';
import 'package:felling_listen/widgets/item_image_widget.dart';
import 'package:flutter/material.dart';

class ItemProductWidget extends StatelessWidget {
  final int index;
  final ManagerAnimation manager;
  const ItemProductWidget({super.key , required this.index , required this.manager});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child:  Column(children: [
        Expanded(flex: 3, child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ItemImageWidget(index: index, manager: manager,),
        )),
        Expanded(flex:1, child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ItemButtonCartWidget(index:index,manager: manager,),
        )),

      ],),
    );

  }
}
