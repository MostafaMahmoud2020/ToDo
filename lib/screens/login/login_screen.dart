import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/screens/login/login_tab.dart';
import 'package:todo/screens/login/sginup_tab.dart';
import 'package:todo/shared/components/appbar.dart';
import 'package:todo/shared/styles/colors.dart';

import '../../providers/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routeName = "LoginScreen";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        resizeToAvoidBottomInset: false,
        appBar: SharedAppbar(),
        body: Column(
          children: [
            SizedBox(
              height: 50,
              child: AppBar(
                bottom: TabBar(
                    labelStyle:
                        GoogleFonts.poppins(fontWeight: FontWeight.w700),
                    labelColor: Theme.of(context).colorScheme.onPrimary,
                    indicatorColor: primaryColor,
                    indicatorWeight: 2,
                    unselectedLabelColor: Colors.grey,
                    indicator: ShapeDecoration(
                        shape: CircleBorder(
                            side: BorderSide(
                                width: 2,
                                strokeAlign: 10,
                                color: primaryColor))),
                    tabs: [
                      Tab(
                        text: "Log in",
                      ),
                      Tab(
                        text: "Sign Up",
                      ),
                    ]),
              ),
            ),
            SizedBox(height: 10),
            // Divider(endIndent: 50,indent:50 ,thickness: 2,),
            Expanded(
                child: TabBarView(children: [
              LoginTab(),
              SignUpTab(),
            ]))
          ],
        ),
      ),
    );
  }
}
