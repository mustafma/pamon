import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

typedef Null ValueChangeCallback(String value);

class DropDownFormFieldValidation extends StatefulWidget {
  final ValueChangeCallback onValueChanged;
  final String hint;
  final TextEditingController controller;
  final Function validator;
  final Color containerColor;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final FormFieldSetter<String> onSaved;
  final bool enabled;
  final String initialValue;
  final bool obscureText;

  DropDownFormFieldValidation({
    Key key,
    @required this.hint,
    this.controller,
    @required this.onValueChanged,
    this.enabled = true,
    this.onSaved,
    this.keyboardType,
    this.textCapitalization,
    this.validator,
    this.containerColor,
    this.initialValue,
    this.obscureText,
  }) : super(key: key);

  @override
  _DropDownFormFieldValidationState createState() => _DropDownFormFieldValidationState();
}

class _DropDownFormFieldValidationState extends State<DropDownFormFieldValidation> {
  TextEditingController valueController;
  @override
  void initState() {
    super.initState();
    valueController = widget.controller ?? TextEditingController.fromValue(TextEditingValue(text: widget.initialValue ?? ""));
    valueController.addListener(() {
      widget.onValueChanged(valueController.text);
    });
  }

String _myActivity;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        color: Theme.of(context).backgroundColor,
        
        child:DropDownFormField(
        
        titleText: 'סוג משתמש',
        
        hintText: 'בחר סוג משתמש',
        
        value: _myActivity,
                  onSaved: (value) {
                    setState(() {
                      _myActivity = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _myActivity = value;
                    });
                  },
                  dataSource: [
                    {
                      "display": "Running",
                      "value": "Running",
                    },
                    {
                      "display": "Climbing",
                      "value": "Climbing",
                    },
                    {
                      "display": "Walking",
                      "value": "Walking",
                    },
                    {
                      "display": "Swimming",
                      "value": "Swimming",
                    },
                    {
                      "display": "Soccer Practice",
                      "value": "Soccer Practice",
                    },
                    {
                      "display": "Baseball Practice",
                      "value": "Baseball Practice",
                    },
                    {
                      "display": "Football Practice",
                      "value": "Football Practice",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                )),

  
    );
  }
}