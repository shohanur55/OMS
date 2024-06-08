// import 'package:easy_hr/components.dart';
// import 'package:easy_hr/src/models/pojo_classes/api_models/leave_application_model.dart';
// import 'package:easy_hr/src/views/widgets/base_components/custom_elevated_button_widget.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:tuple/tuple.dart';
//
// class CustomLeaveListTile extends StatelessWidget {
//   final AppliedLeaveApplicationModel model;
//   final Future<bool?>? Function()? onTapAccept;
//   final dynamic Function(bool? _)? onDoneAccept;
//   final Future<bool?>? Function()? onTapReject;
//   final dynamic Function(bool? _)? onDoneReject;
//
//   const CustomLeaveListTile({super.key, required this.model, this.onTapAccept, this.onDoneAccept, this.onTapReject, this.onDoneReject});
//
//   String _setDate() {
//     String res = "";
//     try {
//       // model.dateFrom.split(pattern)
//
//       DateFormat dateFormat = DateFormat("MM/dd/yyyy");
//       DateFormat finalDateFormat = DateFormat("dd MMM yyyy");
//
//       res = finalDateFormat.format(dateFormat.parse(model.dateFrom!));
//
//       if (model.dateFrom != model.dateTo) res = "$res - ${finalDateFormat.format(dateFormat.parse(model.dateTo!))}";
//     } catch (_) {}
//
//     return res;
//   }
//
//   Tuple2<String, Color> _setStatus(BuildContext context) {
//     if (model.statusCode == AppliedLeaveStatus.approved) return Tuple2("Approved", Theme.of(context).primaryColor);
//     if (model.statusCode == AppliedLeaveStatus.firstApproved) return Tuple2("First approved", defaultYellow);
//     if (model.statusCode == AppliedLeaveStatus.pending) return Tuple2("Pending", Theme.of(context).colorScheme.error);
//     return Tuple2("Rejected", Theme.of(context).shadowColor.withOpacity(0.5));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       clipBehavior: Clip.antiAlias,
//       margin: EdgeInsets.symmetric(vertical: defaultPadding / 8, horizontal: defaultPadding / 2),
//       decoration: BoxDecoration(
//         color: _setStatus(context).item2,
//         borderRadius: BorderRadius.circular(defaultPadding / 4),
//       ),
//       child: Slidable(
//         endActionPane: onTapReject != null || onDoneReject != null || onDoneAccept != null || onDoneReject != null
//             ? ActionPane(
//                 motion: const ScrollMotion(),
//                 children: [
//                   if (onTapAccept != null || onDoneAccept != null)
//                     Expanded(
//                       child: CustomElevatedButton(
//                         contentPadding: EdgeInsets.zero,
//                         borderRadius: BorderRadius.zero,
//                         height: double.infinity,
//                         onTap: onTapAccept,
//                         onDone: onDoneAccept,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.assignment_turned_in, color: Theme.of(context).canvasColor),
//                             Text("Approve", style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).canvasColor)),
//                           ],
//                         ),
//                       ),
//                     ),
//                   if (onTapReject != null || onDoneReject != null)
//                     Expanded(
//                       child: CustomElevatedButton(
//                         contentPadding: EdgeInsets.zero,
//                         backgroundColor: defaultYellow,
//                         borderRadius: BorderRadius.zero,
//                         height: double.infinity,
//                         onTap: onTapReject,
//                         onDone: onDoneReject,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.close, color: Theme.of(context).canvasColor),
//                             Text("Dismiss", style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).canvasColor)),
//                           ],
//                         ),
//                       ),
//                     )
//                 ],
//               )
//             : null,
//         child: Stack(
//           children: [
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(vertical: defaultPadding / 4, horizontal: defaultPadding / 2),
//               margin: EdgeInsets.only(right: defaultBoxHeight, bottom: borderWidth2, left: borderWidth2),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).canvasColor,
//                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(defaultPadding)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Date: ${_setDate()}", textAlign: TextAlign.start, style: Theme.of(context).textTheme.labelSmall),
//                   Text(
//                     "Status: ${_setStatus(context).item1}",
//                     style: Theme.of(context).textTheme.labelSmall?.copyWith(color: _setStatus(context).item2),
//                   ),
//                   // Reason
//                   Text("Reason: ${model.remarks}", style: Theme.of(context).textTheme.labelSmall),
//                 ],
//               ),
//             ),
//
//             //! --------------------------------------------------------------------------------------
//             Positioned(
//               right: 0,
//               top: 0,
//               bottom: 0,
//               child: Container(
//                 alignment: Alignment.center,
//                 // color: Colors.amber,
//                 width: defaultBoxHeight,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Flexible(child: Text("Days: ${model.totalDay}\n${model.leaveType}", textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: defaultPadding / 3, fontWeight: FontWeight.bold, color: Theme.of(context).shadowColor))),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
