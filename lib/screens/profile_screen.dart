import 'package:flutter/material.dart';
import 'package:tm_front/components/section_bar.dart';
import 'package:tm_front/models/profile_model.dart';
import 'package:tm_front/services/profile_service.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final Future<ProfileModel> profile =
      ProfileService.getProfile("USER0000000014");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text("프로필"),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              children: [
                const SectionBar(),
                FutureBuilder(
                    future: profile,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          //   decoration: const BoxDecoration(color: Colors.lightBlue),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  informTexts('이름', snapshot.data?.userNm),
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    height: 40,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.indigo.shade400,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                        child: Text("수정",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ))),
                                  ),
                                ],
                              ),
                              profileComponent(
                                informTexts('나이', snapshot.data!.age),
                                informTexts(
                                    '성별',
                                    // ignore: unrelated_type_equality_checks
                                    snapshot.data?.gndrCd == '10'
                                        ? "남자"
                                        : "여자"),
                              ),
                              profileComponent(
                                informTexts('신장', '${snapshot.data?.sttr}cm'),
                                informTexts('체중', '${snapshot.data?.bdwg}kg'),
                              ),
                              profileComponent(
                                informTexts(
                                    '알레르기정보', snapshot.data?.allergyInfo),
                                null,
                              ),
                              profileComponent(
                                informTexts('싫어하는 음식', snapshot.data?.hateFood),
                                informTexts('좋아하는 음식', snapshot.data?.likeFood),
                              ),
                            ],
                          ),
                        );
                      }
                      return const CircularProgressIndicator();
                    }),
                const SectionBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row profileComponent(first, second) {
    if (second == null) {
      return Row(
        children: [first],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        first,
        second,
      ],
    );
  }

  Expanded informTexts(String title, dynamic text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.indigo.shade400,
              ),
            ),
            Text(
              "$text",
              style: const TextStyle(
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
