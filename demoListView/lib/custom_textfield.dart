import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController inputEditingControler;
  final String name;
  final IconData prefixIcon;
  final bool obscureIconEyeText;
  final bool obscureIconEyeIconEye;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;

  const CustomTextField(
      {super.key,
      required this.inputEditingControler,
      required this.name,
      required this.prefixIcon,
      this.obscureIconEyeText = false,
      this.textCapitalization = TextCapitalization.none,
      required this.inputType,
       this.obscureIconEyeIconEye = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureIconEye = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      controller: widget.inputEditingControler,
      textCapitalization: widget.textCapitalization,
      maxLength: 32,
      obscureIconEyeText: widget.obscureIconEyeText,
      keyboardType: widget.inputType,
      textAlign: TextAlign.start,
      style: const TextStyle(color: Colors.black54, fontSize: 16),
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureIconEye = !obscureIconEye;
              });
            },
            padding: const EdgeInsets.all(5), // add padding to adjust icon
            icon: obscureIconEye
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(5), // add padding to adjust icon
            child: Icon(widget.prefixIcon),
          ),
          labelText: widget.name,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          isDense: true,
          counterText: '',
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          contentPadding: const EdgeInsets.all(10)),
    );
  }
}
