import 'package:flutter/material.dart';
import 'package:myexpenses/styles/colors.dart';

class AppButton extends StatelessWidget {
  final bool disabled;
  final Color backgroundColor;
  final bool busy;
  final Widget? leading;
  final void Function()? onPressed;
  final bool outline;
  final bool elevatedIcon;
  final bool arrowIcon;
  final IconData? icon;
  final bool text;
  final Color textColor;
  final String title;
  final double? fontSize;

  const AppButton({
    Key? key,
    required this.title,
    this.disabled = false,
    this.backgroundColor = black,
    this.busy = false,
    this.leading,
    this.onPressed,
    this.icon,
    this.fontSize,
    this.textColor = primary,
  })  : outline = false,
        text = false,
        elevatedIcon = false,
        arrowIcon = false,
        super(key: key);

  const AppButton.elevatedIcon({
    Key? key,
    required this.title,
    this.backgroundColor = primary,
    this.busy = false,
    this.disabled = false,
    this.icon,
    this.leading,
    this.fontSize,
    this.onPressed,
    this.textColor = primary,
  })  : outline = false,
        text = false,
        elevatedIcon = true,
        arrowIcon = false,
        super(key: key);

  const AppButton.outline({
    Key? key,
    required this.title,
    this.backgroundColor = primary,
    this.leading,
    this.icon,
    this.onPressed,
    this.fontSize,
    this.textColor = primary,
  })  : busy = false,
        disabled = false,
        outline = true,
        elevatedIcon = false,
        text = false,
        arrowIcon = false,
        super(key: key);

  const AppButton.text({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.transparent,
    this.leading,
    this.icon,
    this.fontSize,
    this.onPressed,
    this.textColor = primary,
  })  : busy = false,
        disabled = false,
        outline = false,
        elevatedIcon = false,
        arrowIcon = false,
        text = true,
        super(key: key);

  const AppButton.arrowIcon({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.transparent,
    this.leading,
    this.icon,
    this.onPressed,
    this.fontSize,
    this.textColor = primary,
  })  : busy = false,
        disabled = false,
        outline = false,
        elevatedIcon = false,
        arrowIcon = true,
        text = false,
        super(key: key);

  GestureDetector _outline() {
    return GestureDetector();
  }

  ElevatedButton _raised() {
    return ElevatedButton(
      child: Container(
        child: !busy
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leading != null) leading!,
                  if (leading != null) SizedBox(width: 4),
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize ?? 16,
                    ),
                  )
                ],
              )
            : SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(textColor),
                ),
                height: 16,
                width: 16,
              ),
      ),
      onPressed: busy || disabled ? null : onPressed ?? () => {},
      style: ElevatedButton.styleFrom(
        primary: busy || disabled ? grey : backgroundColor,
        minimumSize: Size(128, 48),
        padding: EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }

  ElevatedButton _arrowIcon() {
    return ElevatedButton(
      child: Container(
        child: !busy
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize ?? 16,
                    ),
                  ),
                  Icon(
                    icon,
                    color: textColor,
                    size: 20,
                  ),
                ],
              )
            : SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(textColor),
                ),
                height: 16,
                width: 16,
              ),
      ),
      onPressed: busy || disabled ? null : onPressed ?? () => {},
      style: ElevatedButton.styleFrom(
        primary: busy || disabled ? grey : backgroundColor,
        minimumSize: Size(128, 58),
        padding: EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }

  ElevatedButton _raisedIcon() {
    return ElevatedButton.icon(
      icon: Icon(
        icon,
        size: 18,
      ),
      label: Container(
        child: !busy
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leading != null) leading!,
                  if (leading != null) SizedBox(width: 4),
                  Text(title,
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize ?? 16,
                      ))
                ],
              )
            : SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(textColor),
                ),
                height: 16,
                width: 16,
              ),
      ),
      onPressed: busy || disabled ? null : onPressed ?? () => {},
      style: ElevatedButton.styleFrom(
        primary: busy || disabled ? grey : backgroundColor,
        minimumSize: Size(110, 38),
        padding: EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }

  TextButton _text() {
    return TextButton(
      child: Container(
        child: !busy
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leading != null) leading!,
                  if (leading != null) SizedBox(width: 4),
                  Text(title,
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize ?? 16,
                      ))
                ],
              )
            : SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(textColor),
                ),
                height: 16,
                width: 16,
              ),
      ),
      onPressed: busy || disabled ? null : onPressed ?? () => {},
      style: ElevatedButton.styleFrom(
        primary: busy || disabled ? grey : backgroundColor,
        minimumSize: Size(128, 48),
        padding: EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (outline) return _outline();
    if (text) return _text();
    if (elevatedIcon) return _raisedIcon();
    if (arrowIcon) return _arrowIcon();
    return _raised();
  }
}
