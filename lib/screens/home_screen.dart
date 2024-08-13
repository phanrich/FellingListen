import 'package:felling_listen/screens/detail_screen.dart';
import 'package:felling_listen/screens/list_vertical_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HoneScreen extends StatefulWidget {
  const HoneScreen({super.key});

  @override
  State<HoneScreen> createState() => _HoneScreenState();
}

class _HoneScreenState extends State<HoneScreen> with TickerProviderStateMixin{

  late final AnimationController controller = AnimationController(vsync: this);
  late final AnimationController cartController = AnimationController(vsync: this);
  late final manager = ManagerAnimation1(controller);
  late List<ItemModel> newItems = [];
  int totalQuantity = 0;
  @override
  void dispose() {
    controller.dispose();
    manager.dispose();// TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            ListVerticalScreen(manager: manager, addItem: (items){
              int tempQuantity = 0;
              for(var item in items){
                tempQuantity += item.quantity;
              }
              totalQuantity = tempQuantity;
              newItems = items;
              setState(() {});

            },),
            ListenableBuilder(
              builder: (context,_) {
                return SizedBox(
                  width: manager.avatarSize.value.width,
                  height: manager.avatarSize.value.height,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle
                    ),
                  ).animate(
                    controller: controller,
                    autoPlay: false,
                  ).scale(
                      begin: const Offset(1, 1),
                      end: Offset.zero,
                      duration: 500.ms,
                      alignment: Alignment.bottomRight,
                      delay: 100.ms
                  ),
                ).animate(
                    controller: controller,
                    autoPlay: false,
                    onComplete: (ctr){
                      ctr.reset();
                      manager.reset();
                      cartController.forward();
                    }
                ).followPath(path: manager.path , duration: 500.ms , curve: Curves.easeInCubic);
              }, listenable: manager.avatarSize,
            )
          ],
        ),
        floatingActionButton: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                key: manager.cartKey,
                onPressed: () {
                  Navigator.of(manager.cartKey.currentContext!).push(
                    MaterialPageRoute(builder: (_) => DetailScreen(items: newItems,))
                  );
                },
                child: const Icon(Icons.person)
              ),
            ),
            Positioned(
              right: 5,
              top: 0,
              child: Container(height: 20,width: 20,decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),child: Center(child: Text("${totalQuantity}")),),
            )
          ],
        ).animate(
            controller: cartController,
            autoPlay: false,
            onComplete: (ctr){
              ctr.reset();
            }
        ).moveY(begin: 0,end: -20 , duration: 500.ms).shake(),
      ),
    );
  }
}

class ManagerAnimation1 {
  final AnimationController controller;

  ManagerAnimation1(this.controller);

  var avatarKey = List.generate(10, (index) => GlobalKey());
  var cartKey = GlobalKey();

  ValueNotifier avatarSize = ValueNotifier(const Size(0, 0));
  Offset avatarPosition = Offset.zero;
  late Path path = Path();


  void dispose(){
    avatarSize.dispose();
  }

  void reset(){
    print("start reset");
    avatarSize.value = const Size(0, 0);
    avatarPosition = Offset.zero;
    path = Path();
    print("end reset");
  }

  void runAnimationAddToCart(int index){

    BuildContext avatarContext = avatarKey[index].currentContext!;
    BuildContext cardContext = cartKey.currentContext!;


    final avatarPosition = (avatarContext.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
    final cartPosition = (cardContext.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
    final cartBottomPosition = avatarContext.size!.center(cartPosition);

    avatarSize.value = avatarContext.size;

    print(avatarSize.value);
    path = Path()
      ..moveTo(avatarPosition.dx, avatarPosition.dy)
      ..lineTo(cartBottomPosition.dx - avatarContext.size!.width, cartBottomPosition.dy - avatarContext.size!.height);

    controller.forward();
  }

}
