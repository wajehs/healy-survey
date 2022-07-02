import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healy_survey/components/constant/style/common.dart';

class CustomInputFieldWidget extends StatelessWidget {
  final String? hintLabel;
  final TextEditingController controller;
  final FocusScopeNode? focusScopeNode;
  final bool? isobscureText, autoFocus, isRequired;
  final IconData? suffixIcon, prefixIcon;
  final Function()? onSuffixActionClick, onPrefixActionClick;
  final Function(String)? onChangeText;
  final Function()? onTapAction;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final int? maxLine;
  final bool? isNoTopBorder, isNoBottomBorder;

  const CustomInputFieldWidget(
      {Key? key,
      required this.controller,
      this.hintLabel,
      this.focusScopeNode,
      this.isobscureText,
      this.suffixIcon,
      this.onSuffixActionClick,
      this.onChangeText,
      this.autoFocus,
      this.isRequired,
      this.onTapAction,
      this.inputFormatters,
      this.textInputType,
      this.validator,
      this.maxLine,
      this.prefixIcon,
      this.textInputAction,
      this.isNoTopBorder,
      this.isNoBottomBorder,
      this.onPrefixActionClick})
      : super(key: key);
  Widget _buildInfo(BuildContext context) {
    return Container(
        decoration: inputFieldStyle,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: TextFormField(
              maxLines: maxLine,
              controller: controller,
              validator: validator ??
                  (value) {
                    if (isRequired != null && isRequired!) {
                      if (value!.isEmpty) {
                        return 'This field required...';
                      }
                    }
                    return null;
                  },
              onTap: onTapAction,
              inputFormatters: inputFormatters,
              onChanged: onChangeText,
              keyboardType: textInputType ?? TextInputType.text,
              textInputAction: textInputAction,
              obscureText: isobscureText ?? false,
              autofocus: autoFocus ?? false,
              enableSuggestions: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(
                  15,
                ),
                filled: true,
                fillColor: Colors.white,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  height: 1.7,
                ),
                hintText: hintLabel,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.zero,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.zero,
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return _buildInfo(context);
  }
}
