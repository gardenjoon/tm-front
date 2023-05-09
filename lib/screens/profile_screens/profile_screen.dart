import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tm_front/components/rowlists/columnlist_changable.dart';
import 'package:tm_front/components/rowlists/rowlist_changable.dart';
import 'package:tm_front/components/rowlists/rowlist_selectable.dart';
import 'package:tm_front/components/section_bar.dart';
import 'package:tm_front/models/login_model.dart';
import 'package:tm_front/services/shared_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final isProfile = false.obs;

  final getStorage = GetStorage();
  final loginData = Get.put(LoginRequestData());

  final fitnessList = ['생년월일', '성별', '신장', '체중'];
  final activityList = ['hardTimes', 'softTimes', 'walkTimes'];

  @override
  void initState() {
    _fetchFoodInform();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const ProfileAppBar(),
                  const RowDivider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RowListChangable(
                      fitnessList: fitnessList,
                    ),
                  ),
                  const RowDivider(),
                  FutureBuilder(
                      future: _fetchFoodInform(),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: RowListSelectable(
                              loginData: snapshot.data.data,
                              buttonTitle: '선택',
                              isDivider: false,
                            ),
                          );
                        }
                        return const CircularProgressIndicator();
                      })),
                  const RowDivider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ColumnListChangable(
                      activityList: activityList,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ));
  }

  Future<dynamic> _fetchFoodInform() async {
    final componentLists = [
      await SharedService.loadData('like'),
      await SharedService.loadData('hate'),
      await SharedService.loadData('allergy'),
    ];
    loginData.data['like'] = componentLists[0];
    loginData.data['hate'] = componentLists[1];
    loginData.data['allergy'] = componentLists[2];
    return loginData;
  }
}

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: const Text(
            '정원준',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const Icon(Icons.settings_rounded, size: 32)),
      ],
    );
  }
}
