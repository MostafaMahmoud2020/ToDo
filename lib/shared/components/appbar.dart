import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/colors.dart';

class SharedAppbar extends StatefulWidget implements PreferredSizeWidget {
  const SharedAppbar({super.key});

  @override
  State<SharedAppbar> createState() => _SharedAppbarState();

  static final appBar = AppBar();

  Size get preferredSize => appBar.preferredSize;

//Size get preferredSize => throw UnimplementedError();
}

class _SharedAppbarState extends State<SharedAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText('ToDo',
                speed: const Duration(milliseconds: 300),
                textStyle: GoogleFonts.poppins(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor)),
          ],
          repeatForever: true,
          pause: const Duration(seconds: 10),
          stopPauseOnTap: true,
        ),
      ),
    );
  }
}
