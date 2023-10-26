// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todo/layout/home_layout.dart';
//
// import '../../providers/provider.dart';
// import '../../shared/styles/colors.dart';
//
// class ShowLanguageSheet extends StatelessWidget {
//   const ShowLanguageSheet({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<MyProvider>(context);
//     return Container(
//       height: MediaQuery.of(context).size.height * .3,
//       decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.surface,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//           border: Border.all(color: Colors.transparent)),
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: InkWell(
//                 onTap: () {
//                   provider.changeLanguage("en");
//                   provider.iconFlag = true;
//                   Navigator.pop(context);
//                   Navigator.pushNamedAndRemoveUntil(context, HomeLayout.routeName, (route) => false);
//                 },
//                 child: Row(
//                   children: [
//                     Text(
//                       "english",
//                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: provider.iconFlag
//                               ? Theme.of(context).colorScheme.onSecondary
//                               : Theme.of(context).colorScheme.onPrimary),
//                     ),
//                     Spacer(),
//                     provider.iconFlag ? Icon(Icons.done) : Container()
//                   ],
//                 ),
//               ),
//             ),
//             Divider(
//               color: primaryColor,
//               thickness: 1,
//               indent: 100,
//               endIndent: 100,
//             ),
//             Expanded(
//               child: InkWell(
//                 onTap: () {
//                   provider.changeLanguage("ar");
//                   provider.iconFlag = false;
//                   Navigator.pop(context);
//                   Navigator.pushNamedAndRemoveUntil(context, HomeLayout.routeName, (route) => false);
//                 },
//                 child: Row(
//                   children: [
//                     Text(
//                       "arabic",
//                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: provider.iconFlag
//                               ? Theme.of(context).colorScheme.onPrimary
//                               : Theme.of(context).colorScheme.onSecondary),
//                     ),
//                     Spacer(),
//                     provider.iconFlag ? Container() : Icon(Icons.done)
//                     //Icon(Icons.done)
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
