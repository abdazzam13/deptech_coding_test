import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;

  CustomTextFormField({
    required this.label,
    required this.controller,
    required this.isPassword,
    required this.validator,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: widget.validator,
        decoration: InputDecoration(
          suffixIcon: widget.isPassword ? InkWell(
            child: Icon(
              _isObscureText ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
            ),
            onTap: () {
              setState(() {
                _isObscureText = !_isObscureText;
              });
            },
          ) : null,
          labelText: widget.label,
          floatingLabelStyle: TextStyle(color: Colors.lightBlueAccent),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        controller: widget.controller,
        obscureText: widget.isPassword ? _isObscureText : false,
      ),
    );
  }
}
