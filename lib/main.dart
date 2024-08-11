import 'package:felling_listen/screens/home_screen.dart';
import 'package:felling_listen/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const HoneScreen());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(vsync: this);
  late final AnimationController cartController = AnimationController(vsync: this);
  late final manager = ManagerAnimation(controller);

  @override
  void dispose() {
    controller.dispose();
    manager.dispose();
    super.dispose();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        body: Stack(children: [
          ProductListScreen(manager:manager),
          ListenableBuilder(
            listenable: manager.imageSize,
            builder: (context ,_){
              return SizedBox(
                height: manager.imageSize.value.height,
                width: manager.imageSize.value.width,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)
                  ),).animate(autoPlay: false , controller: controller).scale(
                    begin: const Offset(1, 1),
                    end: Offset.zero,
                    duration: 2.seconds,
                    alignment: Alignment.bottomRight,
                    delay: 500.ms
                ),
              ).animate(
                  autoPlay: false,
                  controller: controller,
                  onComplete: (controller){
                    controller.reset();
                    manager.reset();
                    cartController.forward();

                  }
              ).followPath(path: manager.path ,duration: 2.seconds, curve: Curves.easeIn);
            },
          ),
          Center(
              child: Container(
                key: manager.myKey,
                color: Colors.red, width: 20,height: 20,)),
        ],),
        floatingActionButton:FloatingActionButton(key: manager.cartKey, onPressed: () {}, child: const Icon(Icons.add_shopping_cart).animate(
            autoPlay: false,
            controller: cartController,
            onComplete: (controller){
              controller.reset();
            }
        ).moveY(
            begin: 0,
            end: -20,
            duration: 500.ms
        ).shake(),)
      ),
    );
  }
}

class ManagerAnimation {

  ManagerAnimation(this.imageController);
  var imageKey = List.generate(20, (index) => GlobalKey());
  var cartKey = GlobalKey();
  var myKey = GlobalKey();
  late final AnimationController imageController ;
  late ValueNotifier imageSize = ValueNotifier(const Size(0,0));
  late Offset imagePosition = Offset.zero;
  late Path path = Path();

  void dispose(){
    imageSize.dispose();
  }

  void reset(){
    imageSize.value = Size.zero;
    imagePosition = Offset.zero;
    path = Path();
  }

  void runAnimation(int index){
    final imageContext = imageKey[index].currentContext;
    final myPosition = (myKey.currentContext!.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
    final cartPosition = (cartKey.currentContext!.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
    final cartBottomPosition = myKey.currentContext!.size!.center(cartPosition);
    final imagePosition = (imageContext!.findRenderObject() as RenderBox).localToGlobal(Offset.zero);

    imageSize.value = imageContext.size;
    print(imageSize.value);
    path = Path()
      ..moveTo(imagePosition.dx, imagePosition.dy)
      ..relativeLineTo(-20, -20)
      ..lineTo(cartBottomPosition.dx - imageContext.size!.width  , cartBottomPosition.dy - imageContext.size!.height );

    imageController.forward();
  }
}



