import 'package:flutter/material.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/screens/recommend_store_screens/custom_googlemap.dart';
import 'package:tm_front/screens/recommend_store_screens/search_bar.dart';
import 'package:tm_front/screens/recommend_store_screens/store_listview.dart';

class RecommendStoreScreen extends StatelessWidget {
  RecommendStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text(
          '추천식당',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 1,
      ),
      backgroundColor: Palette.greySub2,
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              color: Palette.white,
              child: SearchBar(),
            ),
            CustomGoogleMap(),
            StoreListView(),
          ],
        )),
      ),
    );
  }
}




//   child: Container(
//     constraints: const BoxConstraints(maxWidth: 640),
//     child: Column(
//       children: [
//         const SizedBox(height: 10),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//           child: TextFieldWidget('음식점 명 입력', 'search', controller),
//         ),
//         const SizedBox(height: 20),
//         Flexible(
//           child: Container(
//             margin: const EdgeInsets.symmetric(horizontal: 20),
//             child: GridView.builder(
//                 gridDelegate:
//                     const SliverGridDelegateWithMaxCrossAxisExtent(
//                   maxCrossAxisExtent: 150,
//                   mainAxisSpacing: 4,
//                   crossAxisSpacing: 4,
//                   childAspectRatio: 0.9,
//                 ),
//                 itemCount: 9,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     decoration: BoxDecoration(
//                       color: Color.fromARGB(
//                         255,
//                         9 + (10 * index),
//                         27 + (10 * index),
//                         127 + (10 * index),
//                       ),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.rice_bowl,
//                             size: 60, color: Colors.indigo.shade100),
//                         const SizedBox(height: 12),
//                         Text(
//                           '한식',
//                           style: TextStyle(
//                               color: Colors.indigo.shade100,
//                               fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//           ),
//         )
//       ],
//     ),
//   ),
