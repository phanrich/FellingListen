import 'package:felling_listen/screens/list_vertical_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final List<ItemModel> items;

  const DetailScreen({super.key, required this.items});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late List<ItemModel> newItems = [];

  late int total = 0;

  totalPrice(){
    for(var item in newItems){
      total += item.price;
    }
    setState(() {
    });
  }
  @override
  void initState() {
    super.initState();
    newItems = widget.items;
    totalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: newItems.isNotEmpty
            ? Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                    itemBuilder: (context, index) => Container(
                        color: (index % 2) == 0 ? Colors.amber : Colors.blueGrey,
                        margin: const EdgeInsets.only(top: 5),
                        child: ListTile(
                          title: Text(newItems[index].name),
                          subtitle: Text(newItems[index].quantity.toString()),
                          leading: Text(newItems[index].price.toString()),
                        )),
                    itemCount: newItems.length,
                  ),
                Center(child: Text("Total: ${total}"),),
              ],
            )
            : const Center(
                child: Text("no data"),
              ));
  }
}
