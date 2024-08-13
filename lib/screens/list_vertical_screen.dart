import 'package:felling_listen/screens/home_screen.dart';
import 'package:flutter/material.dart';

class ListVerticalScreen extends StatefulWidget {
  final ManagerAnimation1 manager;
  final Function(List<ItemModel>) addItem;
   const ListVerticalScreen({super.key , required this.manager , required this.addItem});

  @override
  State<ListVerticalScreen> createState() => _ListVerticalScreenState();
}

class _ListVerticalScreenState extends State<ListVerticalScreen> {

   late List<ItemModel> items = [
     ItemModel(id: "1", name: "1", quantity: 1, price: 100),
     ItemModel(id: "2", name: "2", quantity: 1,price: 200),
     ItemModel(id: "3", name: "3", quantity: 1,price: 300),
     ItemModel(id: "4", name: "4", quantity: 1,price: 120),
     ItemModel(id: "5", name: "5", quantity: 1,price: 150)
   ];
   late List<ItemModel> listDemo = [];

   void addItem(String id, int quantity) {

   }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context , index){
          return Container(
            color: Colors.blueGrey,
            margin: const EdgeInsets.all(5),
            child: ListTile(
              onTap: (){
                /// selected item
                widget.manager.runAnimationAddToCart(index);
                int count = listDemo.indexWhere((element) => element.id == items[index].id);
                if(count != -1){
                  int quantity = listDemo[index].quantity;
                  quantity++;
                  ItemModel newItem = ItemModel(id: items[index].id, name: items[index].name, quantity: quantity , price: items[index].price);
                  listDemo[index] = newItem;
                  print("add items with quantity==== > ${listDemo.length}");
                }else{
                  listDemo.add(items[index]);
                  print("add items without quantity==== > $listDemo");

                }
                widget.addItem(listDemo);
                setState(() {});
              },
              leading: Container(
                key: widget.manager.avatarKey[index],
                width: 50,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle
                ),
              ),
              title: Text(items[index].name.toString().toUpperCase()),
              subtitle: Text(items[index].quantity.toString().toLowerCase()),
            ),
          );
        });
  }
}

class ItemModel {
  final String id;
  final String name;
  final int quantity;
  final int price;

  ItemModel({required this.id, required this.name, required this.quantity, required this.price});
}
