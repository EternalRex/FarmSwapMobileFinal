import "package:flutter/material.dart";
import "package:intl/intl.dart";

class Registration2TextField extends StatefulWidget {
  const Registration2TextField({
    super.key,
    required this.controller,
    required this.inputType,
    this.isPassword,
    this.maxCharacters,
    required this.isPasswordVisible,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final TextInputType inputType;
  final bool? isPassword;
  final int? maxCharacters;
  final bool isPasswordVisible;
  final Widget? suffixIcon;

  @override
  State<Registration2TextField> createState() => _Registration2TextFieldState();
}

class _Registration2TextFieldState extends State<Registration2TextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      obscureText: widget.isPasswordVisible,
      maxLength: widget.maxCharacters,
      decoration: (widget.isPassword == true)
          ? InputDecoration(
              suffixIcon: widget.suffixIcon,
            )
          : const InputDecoration(),
    );
  }
}

class Registration2TextDateField extends StatefulWidget {
  const Registration2TextDateField({
    super.key,
  });

  @override
  State<Registration2TextDateField> createState() => _Registration2TextDateFieldState();
}

class _Registration2TextDateFieldState extends State<Registration2TextDateField> {
  DateTime registerdate2 = DateTime.now();
  String registrationdates = "Please select a date";

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: registrationdates,
        prefix: IconButton(
          onPressed: () {
            _selectDate2();
          },
          icon: const Icon(Icons.calendar_month),
        ),
      ),
    );
  }

  /*For selecting registration date */
  Future<void> _selectDate2() async {
    DateTime initialDate = registerdate2 ?? DateTime.now();
    String formattedDate = DateFormat('MMMM dd, yyyy').format(initialDate);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          initialDate, // Set the initial date to the current date or registerdate2 if not null
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null && pickedDate != registerdate2) {
      setState(() {
        registrationdates = formattedDate;
        //Provider.of<UserDetailsProvider>(context, listen: false).setBirthdate(registerdate2);
        registerdate2 = pickedDate;
      });
    }
  }
}
