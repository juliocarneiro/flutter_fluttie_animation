import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final bool busy;
  final Function func;

  LoadingButton({@required this.busy, @required this.func});

  @override
  Widget build(BuildContext context) {
    return !busy
        ? FlatButton(
            child: Text('Enviar'),
            onPressed: func,
          )
        : CircularProgressIndicator();
  }
}
