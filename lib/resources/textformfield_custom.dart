import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_resourse.dart';
import 'srting_resourse.dart';

class TextFormFieldCustom extends StatefulWidget {
  final String? titleText;
  final String? hintText;
  final AlignmentGeometry? titleAlign;
  final TextEditingController textController;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final bool? obscureText;
  final Color? fillColor;
  final Color? labelColor;
  final bool? readOnly;
  final EdgeInsets? contentPadding;
  final EdgeInsets? margin;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? enabled;
  final bool isShowLable;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final Function()? onTap;
  final BoxShadow? boxShadow;
  final FocusNode? focusNode;
  final String? autofillHints;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputAction? textInputAction;

  const TextFormFieldCustom({
    Key? key,
    this.titleText,
    this.hintText,
    this.titleAlign,
    required this.textController,
    this.keyboardType,
    this.maxLines,
    this.maxLength,
    this.textCapitalization,
    this.obscureText,
    this.readOnly,
    this.suffixIcon,
    this.prefixIcon,
    this.enabled,
    this.validator,
    this.onChanged,
    this.contentPadding,
    this.margin,
    this.fontWeight,
    this.fontFamily,
    this.floatingLabelBehavior,
    this.onTap, this.boxShadow, this.textInputFormatter, this.focusNode, this.fillColor, this.isShowLable=false, this.labelColor, this.autofillHints, this.textInputAction,
  }) : super(key: key);

  @override
  TextFormFieldCustomState createState() => TextFormFieldCustomState();
}

class TextFormFieldCustomState extends State<TextFormFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget.isShowLable)Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(widget.hintText??'',style: TextStyle(height: 1,color: widget.labelColor!=null?widget.labelColor:ColorRes.blackColor,fontSize: 16,fontFamily: StringRes.fontPoppins),),
        ),
        Container(
          margin: widget.margin??EdgeInsets.only(bottom: 15,top: 0),
          child: TextFormField(
            focusNode: widget.focusNode,
            controller: widget.textController,
            obscureText: widget.obscureText ?? false,
            autofillHints:[widget.autofillHints??""],
            keyboardType: widget.keyboardType??TextInputType.text,
            readOnly: widget.readOnly ?? false,
            maxLines: (widget.maxLines == null) ? 1 : widget.maxLines,
            textCapitalization:widget.textCapitalization ?? TextCapitalization.none,
            validator: widget.validator??(val){
              if(val!.trim().isEmpty)
                return "Please Enter ${widget.hintText}";
              else
                return null;
            },
            textInputAction: widget.textInputAction??TextInputAction.next,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            enabled: widget.enabled,
            maxLength: widget.maxLength,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: widget.fontWeight??FontWeight.normal,
              fontFamily: widget.fontFamily??StringRes.fontPoppins
            ),
            inputFormatters: widget.textInputFormatter??[],
            decoration: InputDecoration(
              labelText: widget.titleText,
              hintText: widget.hintText,
              counterText: "",
              filled: false,
              isDense: true,
              errorMaxLines: 3,
              floatingLabelBehavior: widget.floatingLabelBehavior??FloatingLabelBehavior.auto,
              contentPadding: widget.contentPadding ?? EdgeInsets.fromLTRB(20, 15, 10, 15),
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              fillColor: widget.fillColor ?? Color(0xffeeeeee),
              errorStyle: const TextStyle(
                color: Colors.red,
              ),
              labelStyle: TextStyle(color: Colors.black,fontFamily: StringRes.fontPoppins,fontSize: 18),
              hintStyle: TextStyle(color: ColorRes.hintColor,fontSize: 14,fontWeight: FontWeight.w300),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 0.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 0.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 0.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 0.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
