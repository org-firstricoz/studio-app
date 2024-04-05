// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class StudioAppBar extends StatelessWidget {
//   const StudioAppBar({
//     super.key,
//     required this.title,
//     this.centerTitle = true,
//     required this.actions,
//   });

//   final String title;
//   final bool centerTitle;
//   final List<Widget>? actions;

//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     ColorScheme colorScheme = Theme.of(context).colorScheme;
//     return AppBar(
//         backgroundColor: colorScheme.secondary,
//         scrolledUnderElevation: 0,
//         elevation: 0,
//         forceMaterialTransparency: true,
//         title: Text(
//           title,
//           style: textTheme.titleLarge!.copyWith(
//             fontWeight: FontWeight.w600,
//             fontSize: 18,
//             // color: colorScheme.onPrimary
//           ),
//         ),
//         centerTitle: centerTitle,
//         leading: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: GestureDetector(
//             onTap: () {
//               context.pop();
//             },
//             child: CircleAvatar(
//               // radius: 30,
//               backgroundColor: colorScheme.onBackground.withOpacity(0.1),
//               child: Icon(Icons.arrow_back, color: colorScheme.background),
//             ),
//           ),
//         ),
//         actions: actions);
//   }
// }
