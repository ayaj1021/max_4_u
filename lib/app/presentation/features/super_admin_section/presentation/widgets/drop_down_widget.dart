// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:max_4_u/app/model/load_data_model.dart';
// import 'package:max_4_u/app/styles/app_colors.dart';

// class DropDownWidget extends StatelessWidget {
//   const DropDownWidget({super.key, required this.categoryList, this.value});
//   final List<Product> categoryList;
//     final Product? value;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       height: 52.h,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: AppColors.whiteColor,
//         border: Border.all(
//           color: const Color(0xffCBD5E1),
//         ),
//       ),
//       child: categoryList.isNotEmpty ? DropdownButton<Product>(
//         value: value,
        
//         items: 
        
        
//         categoryList.first.map<DropdownMenuItem<Product>>((e)=> 
//         DropdownMenuItem(child: Row(
//           children: [

//           ],
//         ))
//         ), 
      
      
//       onChanged: (v){},)
//     );
//   }
// }
