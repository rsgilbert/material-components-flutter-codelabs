import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shrine/model/product.dart';


const double _kFlingVelocity = 2;

class Backdrop extends StatefulWidget {
  final Category currentCategory;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop({ 
    required this.currentCategory,
    required this.frontLayer,
    required this.backLayer,
    required this.frontTitle,
    required this.backTitle,
    Key? key
  }) : super(key: key);

  @override 
  _BackdropState createState() => _BackdropState();

}

class _BackdropState extends State<Backdrop>
  with SingleTickerProviderStateMixin {
    final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  late AnimationController _controller;

  @override 
  void initState(){
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 1,
      vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override 
  void didUpdateWidget(Backdrop old) {
    super.didUpdateWidget(old);
    if(widget.currentCategory != old.currentCategory || !_frontLayerVisible) {
      _toggleBackdropLayerVisibility();
    }
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }


  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
      0, layerTop, 0, layerTop-layerSize.height),
      end: const RelativeRect.fromLTRB(0, 0, 0, 0)).animate(_controller.view);

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible
        ),
        PositionedTransition(
          rect: layerAnimation, 
        child: _FrontLayer(
          onTap: _toggleBackdropLayerVisibility,
          child: widget.frontLayer
        )),
      ],
    );
  }

  @override 
  Widget build(BuildContext context) {
    var appBar = AppBar(
      elevation: 0,
      titleSpacing: 0,
      leading: IconButton(
        icon: const ImageIcon(AssetImage('assets/diamond.png')),
        onPressed: _toggleBackdropLayerVisibility,
      ),
      title: const Text("SHRINE", style: TextStyle(color: Colors.white))
    );
    return Scaffold(
      appBar: appBar,
      body:LayoutBuilder(builder: _buildStack)
    );
  }
}

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({
    Key? key,
    this.onTap,
    required this.child
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onTap;


  @override 
  Widget build(BuildContext context) {
    return Material(
      elevation: 16,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50))
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // GestureDetector(
          //   behavior: HitTestBehavior.opaque,
          //   onTap: onTap,
          //   child: Container(
          //     height: 40,
          //     alignment: AlignmentDirectional.centerStart,
          //   )
          // ),
          Expanded(child: child)
        ],
      )
    );
  }
}




