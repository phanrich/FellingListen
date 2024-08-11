import 'package:felling_listen/screens/list_vertical_screen.dart';
import 'package:flutter/cupertino.dart';
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
            ListVerticalScreen(manager: manager,),
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
                      duration: 2.seconds,
                      alignment: Alignment.bottomRight,
                      delay: 500.ms
                  ),
                ).animate(
                    controller: controller,
                    autoPlay: false,
                    onComplete: (ctr){
                      ctr.reset();
                      manager.reset();
                      cartController.forward();
                    }
                ).followPath(path: manager.path , duration: 2.seconds , curve: Curves.easeInCubic);
              }, listenable: manager.avatarSize,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          key: manager.cartKey,
          onPressed: () {  },
          child: const Icon(Icons.person).animate(
              controller: cartController,
              autoPlay: false,
              onComplete: (ctr){
                ctr.reset();
              }
          ).moveY(begin: 0,end: -20 , duration: 500.ms).shake(),
        )
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
