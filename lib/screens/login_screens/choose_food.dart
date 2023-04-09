import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/models/login_model.dart';

const titleList = ['곡류', '채소류', '생선 및 해물', '견과류', '과일'];

const list = {
  //TODO: 실제 DB 데이터로 대체
  '곡류': ['보리', '귀리', '호밀', '밀', '메밀', '옥수수', '쌀', '대두'],
  '채소류': ['가지', '녹두', '강낭콩', '브로콜리', '양배추', '당근', '오이', '감자'],
  '생선 및 해물': ['미역', '멸치', '꽃게', '갑오징어', '홍합', '연어', '참치', '새우'],
  '견과류': ['아몬드', '땅콩', '잣', '호두', '마카다미아', '너트', '코코넛'],
  '과일': ['사과', '바나나', '블루베리', '포도', '자몽', '키위', '레몬', '배', '딸기', '복숭아'],
  '유제품 및 계란': ['사과', '바나나', '블루베리', '포도', '자몽', '키위', '레몬', '배', '딸기', '복숭아'],
  '육류': ['사과', '바나나', '블루베리', '포도', '자몽', '키위', '레몬', '배', '딸기', '복숭아'],
  '허브 및 향신료': ['사과', '바나나', '블루베리', '포도', '자몽', '키위', '레몬', '배', '딸기', '복숭아'],
  '기타': ['사과', '바나나', '블루베리', '포도', '자몽', '키위', '레몬', '배', '딸기', '복숭아'],
};

class ChooseFood extends StatelessWidget {
  ChooseFood({super.key, required this.formName});
  final loginData = Get.put(LoginRequestData());
  final String formName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
      constraints: const BoxConstraints(maxWidth: 640),
      child: Column(
        children: [
          Text(
              formName == 'like'
                  ? '좋아하는 음식 선택'
                  : formName == 'hate'
                      ? '싫어하는 음식 선택'
                      : '알레르기 선택',
              style: const TextStyle(
                color: Palette.main,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 10),
          Expanded(
            flex: 5,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return categoryView(
                    list.keys.toList()[index], list.values.toList()[index]);
              },
            ),
          ),
          nextButton(),
        ],
      ),
    );
  }

//   Widget chooseFood(String formName) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
//       constraints: const BoxConstraints(maxWidth: 640),
//       child: Column(
//         children: [
//           Text(formName == 'like' ? '좋아하는 음식 선택' : '싫어하는 음식 선택',
//               style: const TextStyle(
//                 color: Palette.main,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               )),
//           const SizedBox(height: 10),
//           Expanded(
//             flex: 5,
//             child: ListView.builder(
//               itemCount: list.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return categoryView(list.keys.toList()[index],
//                     list.values.toList()[index], formName);
//               },
//             ),
//           ),
//           nextButton(),
//         ],
//       ),
//     );
//   }

  Row nextButton() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            height: 70,
            child: TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  backgroundColor: Palette.main,
                ),
                child: const Text('완료',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ))),
          ),
        ),
      ],
    );
  }

  Widget categoryView(String title, List foodList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        categoryTitle(title),
        const SizedBox(height: 5),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: foodComponent(foodList[index]));
              }
              return foodComponent(foodList[index]);
            },
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Container categoryTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(left: 25),
      child: Text(
        title,
        style: const TextStyle(
          color: Palette.main,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget foodComponent(String name) {
    RxBool isSelected =
        loginData.data[formName].contains(name) ? true.obs : false.obs;

    return Obx(() => Container(
          margin: const EdgeInsets.only(right: 10),
          child: TextButton(
              onPressed: () => {
                    isSelected.value = !isSelected.value,
                    isSelected.value
                        ? loginData.data[formName].add(name)
                        : loginData.data[formName].remove(name)
                  },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                backgroundColor:
                    isSelected.value ? Palette.main : Palette.greySub,
              ),
              child: Text(name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ))),
        ));
  }
}
