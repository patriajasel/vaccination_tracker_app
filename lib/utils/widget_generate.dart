import 'package:flutter/material.dart';

class GenerateWidget {
  TextField createTextField(
    TextEditingController controller,
    String labelText,
    bool suffixIcon,
    bool enabled,
    bool obscure, {
    Function? function,
    String? hintText,
    Icon? prefixIcon,
  }) {
    return TextField(
        controller: controller,
        expands: false,
        obscureText: obscure,
        readOnly: suffixIcon ? true : false,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,

          // Label style size
          labelStyle: TextStyle(
              letterSpacing: 2,
              fontFamily: "DmSerif",
              color: enabled != true ? Colors.grey : Colors.grey.shade800,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
          suffixIcon: suffixIcon
              ? IconButton(
                  onPressed: () {
                    function!();
                  },
                  icon: const Icon(Icons.calendar_month))
              : null,

          prefixIcon: prefixIcon,

          hintStyle: const TextStyle(color: Colors.grey),

          // Border Styles
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.blue.shade900,
                width: 2.0 // White border for the enabled state
                ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.blueGrey,
                width: 2.0 // White border for the enabled state
                ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors
                  .blue.shade900, // White border when the field is focused
              width: 2.0, // Optional: you can increase the border width
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red, // Red border for the error state
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red, // Red border when focused with error
              width: 2.0,
            ),
          ),
        ),
        style: TextStyle(
          letterSpacing: 2,
          fontFamily: "DmSerif",
          color: enabled != true ? Colors.grey : Colors.grey.shade800,
          fontSize: 16.0,
          fontWeight: FontWeight.bold, // Text color set to white
        ));
  }
}
