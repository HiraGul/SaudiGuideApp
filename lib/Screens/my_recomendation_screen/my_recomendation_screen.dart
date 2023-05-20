// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:saudi_guide/Cubits/my_recomendation_repo/my_recomendation_cubit.dart';
// import 'package:saudi_guide/Models/chat_model.dart';
// import 'package:saudi_guide/Utils/colors.dart';
//
// class MyRecommendationScreen extends StatefulWidget {
//   const MyRecommendationScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MyRecommendationScreen> createState() => _MyRecommendationScreenState();
// }
//
// class _MyRecommendationScreenState extends State<MyRecommendationScreen> {
//
//   List<RecommendationModel> items =[
//
//     RecommendationModel(title: 'Food', message: 'I want you to recommend me some good traditional food in Saudi Arabia. The food should be traditional, and it should be cheap. Only give me the names of the foods. Give the top 5 best food names.'),
//     RecommendationModel(title: 'Tourist', message: 'I want you to recommend me some best place to visit in saudi arabic, With the name '),
//
//
//   ];name
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(height: 80.sp,),
//             Expanded(child: Container(
//               child: Wrap(
//                 children: items.map((e) =>  InkWell(
//                   onTap: (){
//
//                     context.read<MyRecommendationCubit>().getMessage(message: e.message);
//
//                   },
//                   child: Container(
//                     margin: EdgeInsets.all(5.sp),
//
//                       color: AppColors.greenColor,
//                       height: 60.sp,
//                       width: 120.sp,
//                       child: Center(
//                         child: Text(e.title,style: GoogleFonts.cairo(
//                             color: Colors.white,
//                             fontSize: 20.sp
//                         ),),
//                       )),
//                 ),).toList(),
//               ),
//             ),),
//             Expanded(child: BlocBuilder<MyRecommendationCubit, MyRecomendationState>(
//   builder: (context, state) {
//   if(state is MyRecommendationLoading){
//     return const Center(child: CircularProgressIndicator(),);
//   }else if(state is MyRecommendationLoaded){
//     return Padding(
//       padding:  EdgeInsets.symmetric(horizontal: 15.sp),
//       child: Text(state.message),
//     );
//   }else{
//     return Container();
//   }
//   },
// ),),
//           ],
//         ),
//       ),
//     );
//   }
// }
