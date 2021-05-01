import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
class FindBoyAnimated extends StatefulWidget {
  @override
  _FindBoyAnimatedState createState() => _FindBoyAnimatedState();
}

class _FindBoyAnimatedState extends State<FindBoyAnimated> with TickerProviderStateMixin{
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: Duration(seconds: 3),
    )..repeat();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }
  Widget _buildBody() {
    return AnimatedBuilder(
      animation: CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
                child: Text("Finding Delivery Boy",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),)),
            _buildContainer(150 * _controller.value),
            _buildContainer(200 * _controller.value),
            _buildContainer(250 * _controller.value),
            _buildContainer(300 * _controller.value),
            _buildContainer(350 * _controller.value),
            Align(child: Image.asset("images/deliveryBoy.png", height: 44,)),
          ],
        );
      },
    );
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kThemeColor.withOpacity(1 - _controller.value),
      ),
    );
  }
}
