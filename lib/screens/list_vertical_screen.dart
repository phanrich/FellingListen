import 'package:felling_listen/screens/home_screen.dart';
import 'package:flutter/material.dart';

class ListVerticalScreen extends StatelessWidget {
  final ManagerAnimation1 manager;
   ListVerticalScreen({super.key , required this.manager});

   final listDemo = [
    1,2,3,4,5,6,8,9,10,
    1,2,3,4,5,6,8,9,10,
    1,2,3,4,5,6,8,9,10,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context , index){
          return Container(
            color: Colors.blueGrey,
            margin: const EdgeInsets.all(5),
            child: ListTile(
              onTap: (){
                /// selected item
                manager.runAnimationAddToCart(index);
                print("run animation start");
              },
              leading: Container(
                key: manager.avatarKey[index],
                width: 50,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle
                ),
              ),
              title: Text(listDemo[index].toString().toUpperCase()),
              subtitle: Text(listDemo[index].toString().toLowerCase()),
            ),
          );
        });
  }
}
