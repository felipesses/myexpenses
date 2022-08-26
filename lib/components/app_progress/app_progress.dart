import 'package:flutter/material.dart';
import 'package:myexpenses/styles/colors.dart';

Widget appProgress = Center(
  child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(primary),
  ),
);
