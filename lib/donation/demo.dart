// Column(
//               children: [
//                 Padding(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//                   child: Row(
//                     children: [
//                       Text(
//                         "MyRegistrations",
//                         style: CustomFont().subtitleText,
//                       ),
//                       SizedBox(width: 8.w),
//                       Container(
//                         height: 20.h,
//                         width: 20.w,
//                         decoration: BoxDecoration(
//                           color: Colors.black12,
//                           borderRadius: BorderRadius.all(Radius.circular(30)),
//                         ),
//                         child: Center(
//                           child: Text(
//                             myRegistrations.length.toString(),
//                             style: CustomFont().subtitleText,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 ListView.builder(
//                   padding: EdgeInsets.symmetric(horizontal: 16.w),
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: myRegistrations.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: EdgeInsets.symmetric(vertical: 6.h),
//                       child: InkWell(
//                         onTap: () {
//                           // Handle onTap action if needed
//                         },
//                         child: Container(
//                           padding: EdgeInsets.all(16),
//                           height: 200.h,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(color: Colors.black26),
//                             borderRadius: BorderRadius.circular(10.r),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 myRegistrations[index].name,
//                                 style: CustomFont().subtitleText,
//                               ),
//                               Text(
//                                 myRegistrations[index].location,
//                                 style: CustomFont().bodyText,
//                               ),
//                               SizedBox(height: 15.h),
//                               Text("Requirements"),
//                               Divider(
//                                 thickness: 2,
//                                 color: Colors.black12,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     "Men: ",
//                                     style: CustomFont().subtitleText,
//                                   ),
//                                   Text(myRegistrations[index]
//                                       .fulfilledMenDresses
//                                       .toString()),
//                                   Text("/"),
//                                   Text(myRegistrations[index]
//                                       .requiredMenDresses
//                                       .toString()),
//                                   SizedBox(
//                                     height: 75.h,
//                                     child: VerticalDivider(
//                                       thickness: 2,
//                                       color: Colors.black12,
//                                     ),
//                                   ),
//                                   Text(
//                                     "Women: ",
//                                     style: CustomFont().subtitleText,
//                                   ),
//                                   Text(myRegistrations[index]
//                                       .fulfilledWomenDresses
//                                       .toString()),
//                                   Text("/"),
//                                   Text(myRegistrations[index]
//                                       .requiredWomenDresses
//                                       .toString()),
//                                   SizedBox(
//                                     height: 75.h,
//                                     child: VerticalDivider(
//                                       thickness: 2,
//                                       color: Colors.black26,
//                                     ),
//                                   ),
//                                   Text(
//                                     "Kids: ",
//                                     style: CustomFont().subtitleText,
//                                   ),
//                                   Text(myRegistrations[index]
//                                       .fulfilledKidsDresses
//                                       .toString()),
//                                   Text("/"),
//                                   Text(myRegistrations[index]
//                                       .requiredKidsDresses
//                                       .toString()),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             );