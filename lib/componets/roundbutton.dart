import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class RoundButton extends StatelessWidget {
  String? title;
  final VoidCallback? onTap;
  double? textFontSize;
  double? height;
  double? width;

  Color? backgroundColor;
  Color? textColor;
  Color? borderColor;
  double? borderRadius;
  final bool loading;
  RoundButton(
      {super.key,
      this.backgroundColor = Colors.black,
      this.textColor = Colors.white,
      this.borderColor = Colors.white,
      this.borderRadius = 30.0,
      this.loading = false,
      required this.title,
      required this.onTap,
      this.textFontSize = 18.0,
      this.height = 45,
      this.width = 300});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            // width: 2.0,
            color: borderColor!,
          ),
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: loading
            ? Center(
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : Center(
                child: Text(
                '$title',
                style: GoogleFonts.poppins(
                    fontSize: textFontSize,
                    color: textColor,
                    fontWeight: FontWeight.w700),
              )),
      ),
    );
  }
}
