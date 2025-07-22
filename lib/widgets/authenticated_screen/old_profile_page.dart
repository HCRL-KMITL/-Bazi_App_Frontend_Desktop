// import 'package:bazi_app_frontend/configs/theme.dart';
// import 'package:bazi_app_frontend/models/user_model.dart';
// import 'package:bazi_app_frontend/repositories/misc_repository.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../../../repositories/hora_repository.dart';
// import '../../widgets.dart';
// import '../edit_info_widget.dart';

// class ProfileWidget extends StatefulWidget {
//   final UserModel userData;

//   const ProfileWidget({required this.userData, super.key});

//   @override
//   State<ProfileWidget> createState() => _ProfileWidgetState();
// }

// class _ProfileWidgetState extends State<ProfileWidget> {
//   final currentUser = FirebaseAuth.instance.currentUser;
  

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: SingleChildScrollView(
//       child: Padding(
//           padding: const EdgeInsets.all(10),
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Center(
//               child: Text("ข้อมูลส่วนตัว",
//                   style: Theme.of(context).textTheme.headlineLarge),
//             ),
//             const SizedBox(height: 10),
//             Container(
//               height: 135,
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).disabledColor,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(children: [
//                 Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundImage: NetworkImage(currentUser!.photoURL!),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       widget.userData.email,
//                       style: Theme.of(context).textTheme.bodySmall,
//                       softWrap: true,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(width: 10),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(widget.userData.name,
//                             style: Theme.of(context).textTheme.headlineSmall),
//                         const SizedBox(width: 5),
//                         Icon(widget.userData.gender == 0
//                             ? Icons.male
//                             : Icons.female)
//                       ],
//                     ),
//                     Text(
//                         "${MiscRepository().displayThaiDate(widget.userData.birthDate.split(" ")[0])}, ${widget.userData.birthDate.split(" ")[1].substring(0, 5)} น.",
//                         style: Theme.of(context).textTheme.bodyMedium),
//                     const Spacer(),
//                     Align(
//                       alignment: Alignment.bottomRight,
//                       child: TextButton(
//                         style: TextButton.styleFrom(
//                           backgroundColor: fcolor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => EditInfoWidget(
//                                     oldData: widget.userData,
//                                   )));
//                         },
//                         child: Text(
//                           "แก้ไขข้อมูล",
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodySmall!
//                               .copyWith(color: wColor),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ]),
//             ),
//             const SizedBox(height: 20),
//             Text("ธาตุประจำตัวและลักษณะนิสัยของคุณ",
//                 style: Theme.of(context).textTheme.headlineSmall),
//             const SizedBox(height: 20),
//             Center(
//               child: personalElementText(context,
//                   widget.userData.baziChart.dayPillar.heavenlyStem.name),
//             ),
//             FourPillarTable(chart: widget.userData.baziChart),
//             const SizedBox(height: 30),
//             Text(
//               "ลักษณะนิสัย",
//               style: Theme.of(context).textTheme.headlineSmall,
//             ),
//             textContainer(
//                 Theme.of(context).textTheme.bodySmall!,
//                 MediaQuery.of(context).size.width * 0.95,
//                 100,
//                 HoraRepository().getBaseHora(
//                         widget.userData.baziChart.dayPillar.heavenlyStem.name)[
//                     widget.userData.baziChart.dayPillar.heavenlyStem
//                         .name]["pros"]),
//             const SizedBox(height: 10),
//             Text(
//               "ข้อเสีย",
//               style: Theme.of(context).textTheme.headlineSmall,
//             ),
//             textContainer(
//                 Theme.of(context).textTheme.bodySmall!,
//                 MediaQuery.of(context).size.width * 0.95,
//                 100,
//                 HoraRepository().getBaseHora(
//                         widget.userData.baziChart.dayPillar.heavenlyStem.name)[
//                     widget.userData.baziChart.dayPillar.heavenlyStem
//                         .name]["cons"]),
//             const SizedBox(height: 10),
//             Text(
//               "อาชีพที่เหมาะสม",
//               style: Theme.of(context).textTheme.headlineSmall,
//             ),
//             textContainer(
//                 Theme.of(context).textTheme.bodySmall!,
//                 MediaQuery.of(context).size.width * 0.95,
//                 100,
//                 HoraRepository().getBaseHora(widget.userData.baziChart.dayPillar
//                     .heavenlyStem.name)["occupation"]),
//           ])),
//     ));
//   }
// }
