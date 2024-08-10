import 'package:felling_listen/main.dart';
import 'package:felling_listen/widgets/item_product_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductListScreen extends StatelessWidget {
  final ManagerAnimation manager;

  const ProductListScreen({super.key ,  required this.manager});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      childAspectRatio: .7,
      children: List<Widget>.generate(20, (index) {
        return  ItemProductWidget(index: index, manager: manager,);
      }),
    );

  }
}

