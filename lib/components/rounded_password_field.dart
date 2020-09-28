import 'package:flutter/material.dart';
import 'package:bizzilly/components/text_field_container.dart';
import 'package:bizzilly/utilities/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  final hinText;
  const RoundedPasswordField({Key key, this.onChanged, this.hinText})
      : super(key: key);
  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool passwordVisible;
  var i;

  @override
  void initState() {    
    super.initState();
    i = Icon(Icons.visibility_off);
    passwordVisible = true;
  }

  void _showPopupMenu() async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(1000, 1000, 1000, 0),
      items: [
        PopupMenuItem<String>(child: const Text('Doge'), value: 'Doge'),
        PopupMenuItem<String>(child: const Text('Lion'), value: 'Lion'),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: passwordVisible,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: widget.hinText,
          icon: GestureDetector(
            onTap: () {
              _showPopupMenu();
            },
            child: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                if (i.toString() == Icon(Icons.visibility_off).toString()) {
                  i = Icon(Icons.visibility);
                } else {
                  i = Icon(Icons.visibility_off);
                }
                passwordVisible = !passwordVisible;
              });
            },
            icon: i,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
