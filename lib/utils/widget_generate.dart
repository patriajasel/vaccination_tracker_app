import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GenerateWidget {
  TextField createTextField(
      TextEditingController controller,
      String labelText,
      bool isReadOnly,
      bool enabled,
      bool obscure,
      bool forNumbers,
      bool isValidated,
      {Function? function,
      String? hintText,
      Icon? prefixIcon,
      Icon? suffixIcon,
      Function? updateTextField,
      int? maxLength}) {
    return TextField(
        expands: false,
        obscureText: obscure,
        readOnly: isReadOnly ? true : false,
        enabled: enabled,
        controller: controller,
        maxLength: forNumbers == true ? maxLength : null,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        buildCounter: (context,
            {required currentLength, required isFocused, maxLength}) {
          return null;
        },
        inputFormatters:
            forNumbers == true ? [FilteringTextInputFormatter.digitsOnly] : [],
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
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: () {
                    function!();
                  },
                  icon: suffixIcon)
              : null,

          prefixIcon: prefixIcon,

          hintStyle: const TextStyle(color: Colors.grey),

          // Border Styles
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: isValidated == true ? Colors.cyan.shade400 : Colors.red,
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
                  .cyan.shade700, // White border when the field is focused
              width: 2.0, // Optional: you can increase the border width
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
