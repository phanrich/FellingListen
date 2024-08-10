import 'package:felling_listen/main.dart';
import 'package:felling_listen/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class ItemImageWidget extends StatelessWidget {
  final int index;
  final ManagerAnimation manager;
  const ItemImageWidget({super.key , required this.index , required this.manager});

  @override
  Widget build(BuildContext context) {
    print(manager.imageSize);
    return Container(
      key: manager.imageKey[index],
      decoration: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(20)
    ),);

  }
}
