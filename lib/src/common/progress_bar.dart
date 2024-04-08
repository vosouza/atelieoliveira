import 'package:flutter/material.dart';

class ModalRoundedProgressBar extends StatefulWidget {
  final String _textMessage; // optional message to show
  final Function
      _handlerCallback; // callback that will give a handler object to change widget state.

  const ModalRoundedProgressBar({
    super.key,
    required Function(ProgressBarHandler handler,) handleCallback,
    String message = "", // some text to show if needed...
    double opacity = 0.7, // opacity default value
  })  : _textMessage = message,
        _handlerCallback = handleCallback;

  @override
  State createState() => _ModalRoundedProgressBarState();
}

//StateClass ...
class _ModalRoundedProgressBarState extends State<ModalRoundedProgressBar> {
  bool _isShowing =
      false; // member that control if a rounded progressBar will be showing or not

  @override
  void initState() {
    super.initState();
    /* Here we create a handle object that will be sent for a widget that creates a ModalRounded      ProgressBar.*/
    ProgressBarHandler handler = ProgressBarHandler();

    handler.show = show; // handler show member holds a show() method
    handler.dismiss = dismiss; // handler dismiss member holds a dismiss method
    widget._handlerCallback(handler); //callback to send handler object
  }

  @override
  Widget build(BuildContext context) {
    //return a simple stack if we don't wanna show a roundedProgressBar...
    if (!_isShowing) return const Stack();

    // here we return a layout structre that show a roundedProgressBar with a simple text message
    return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CircularProgressIndicator(),
                Text(widget._textMessage),
              ],
            ),
          );
  }

  // method do change state and show our CircularProgressBar
  void show() {
    setState(() => _isShowing = true);
  }

  // method to change state and hide our CIrcularProgressBar
  void dismiss() {
    setState(() => _isShowing = false);
  }
}

// handler class
class ProgressBarHandler {
  late Function show; //show is the name of member..can be what you want...
  late Function dismiss;
}
