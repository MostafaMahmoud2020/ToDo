import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/provider.dart';
import '../../shared/styles/colors.dart';

class ShowThemeSheet extends StatefulWidget {
  const ShowThemeSheet({super.key});

  @override
  State<ShowThemeSheet> createState() => _ShowThemeSheetState();
}

class _ShowThemeSheetState extends State<ShowThemeSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(.34),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          border: Border.all(color: Colors.transparent)),
      height: MediaQuery.of(context).size.height * .25,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  provider.changeTheme(ThemeMode.light);
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Text(
                      "Light",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: provider.modeApp == ThemeMode.light
                              ? Colors.black
                              : whiteColor),
                    ),
                    Spacer(),
                    provider.modeApp == ThemeMode.light
                        ? Icon(
                            Icons.done,
                            color: blackColor,
                          )
                        : Container()
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 100,
              endIndent: 100,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  provider.changeTheme(ThemeMode.dark);
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Text(
                      "Dark",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: provider.modeApp == ThemeMode.dark
                              ? blackColor
                              : whiteColor),
                    ),
                    Spacer(),
                    provider.modeApp == ThemeMode.dark
                        ? Icon(
                            Icons.done,
                            color: blackColor,
                          )
                        : Container()
                    //Icon(Icons.done)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
