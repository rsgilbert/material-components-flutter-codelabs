import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shrine/model/product.dart';

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

  Widget _buildStack() {
    return Stack(
      key: _backdropKey,
      children: <Widget>[
        widget.backLayer,
        _FrontLayer(child: widget.frontLayer),
      ],
    );
  }

  @override 
  Widget build(BuildContext context) {
    var appBar = AppBar(
      elevation: 0,
      titleSpacing: 0,
    );
    return Scaffold(
      appBar: appBar,
      body: _buildStack()
    );
  }
}

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({
    Key? key,
    required this.child
  }) : super(key: key);

  final Widget child;


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
          Expanded(child: child)
        ],
      )
    );
  }
}




