import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/palette.dart';

class PickerButton extends StatelessWidget {
  final void Function(int) onSelectedItemChanged;
  final int initValue;
  final String? unit;
  final List genList;

  const PickerButton({
    required this.onSelectedItemChanged,
    required this.initValue,
    required this.genList,
    this.unit = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Text(
        '${genList[initValue]}$unit',
        style: const TextStyle(
          fontSize: 22,
        ),
      ),
      onPressed: () => Get.bottomSheet(
        Container(
          height: 240,
          child: CupertinoPicker(
            scrollController:
                FixedExtentScrollController(initialItem: initValue),
            onSelectedItemChanged: onSelectedItemChanged,
            squeeze: 1.2,
            useMagnifier: false,
            itemExtent: 50,
            children: [
              ...genList.map((value) {
                return Center(
                  child: Text(
                    '$value$unit',
                  ),
                );
              })
            ],
          ),
        ),
        backgroundColor: Palette.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}

class PickerButtonMany extends StatelessWidget {
  final List<void Function(int)> onSelectedItemChanged;
  final List<int> initValue;
  final List<String?> unit;
  final List<List> genList;

  const PickerButtonMany({
    required this.onSelectedItemChanged,
    required this.initValue,
    required this.genList,
    required this.unit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final genText = List.generate(genList.length,
            (index) => '${genList[index][initValue[index]]}${unit[index]}')
        .toString();
    final subTitle =
        genText.substring(1, genText.length - 1).split(',').join(' ');

    return CupertinoButton(
      child: Text(
        subTitle,
        style: const TextStyle(
          fontSize: 22,
        ),
      ),
      onPressed: () => Get.bottomSheet(
        Row(
          children: List.generate(
            genList.length,
            (index) => SizedBox(
              height: 240,
              width: MediaQuery.of(context).size.width / 2,
              child: CupertinoPicker(
                scrollController:
                    FixedExtentScrollController(initialItem: initValue[index]),
                onSelectedItemChanged: onSelectedItemChanged[index],
                squeeze: 1.2,
                useMagnifier: false,
                itemExtent: 50,
                children: [
                  ...genList[index].map((value) {
                    return Center(
                      child: Text(
                        '$value${unit[index]}',
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Palette.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}

class DatePickerButton extends StatelessWidget {
  final void Function(DateTime) onDateTimeChanged;
  final String initDateStr;
  const DatePickerButton(
      {required this.onDateTimeChanged, required this.initDateStr, super.key});

  @override
  Widget build(BuildContext context) {
    final initDate = DateTime.parse(initDateStr);
    final textDate = formatDate(initDate, [yyyy, '.', mm, '.', dd]);

    return CupertinoButton(
      child: Text(
        textDate,
        style: const TextStyle(
          fontSize: 22,
        ),
      ),
      onPressed: () => Get.bottomSheet(
        SizedBox(
          height: 240,
          child: CupertinoDatePicker(
            minimumYear: 1900,
            maximumYear: DateTime.now().year,
            initialDateTime: initDate,
            maximumDate: DateTime.now(),
            onDateTimeChanged: onDateTimeChanged,
            mode: CupertinoDatePickerMode.date,
            dateOrder: DatePickerDateOrder.ymd,
          ),
        ),
        backgroundColor: Palette.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}
