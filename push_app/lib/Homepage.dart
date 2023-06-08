import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:push_app/notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _hourList = List.generate(25, (i) => i);
  final _minuteList = List.generate(61, (i) => i);
  final _secondList = List.generate(61, (i) => i);
  late TextEditingController testText = TextEditingController();
  late String pushText = "";
  late DateTime testTime = DateTime.now();
  late int min = 0;
  late DateTime dt2 = DateTime.now();
  late Timer _timer;
  // 이 아래로 picker result
  late int pickerhour;
  late int pickerminute;
  late int pickesecond;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // 1초가 지날 때마다 DateTime.now() 현재 시간으로 갱신.
      setState(() {
        testTime = DateTime.now();
      });
    });
    FlutterLocalNotification.init();
    Future.delayed(const Duration(seconds: 3),
        FlutterLocalNotification.requestNoticationPermission());
    super.initState();
  }

  // kmaple(sibuncho) {
  //   String sibuncho = "";
  //   // late int testkkk = 0;
  //   CupertinoPicker(
  //     itemExtent: 24,
  //     onSelectedItemChanged: (value) {
  //       setState(() {
  //         // year = years[value];
  //       });
  //     },
  //     children: _hourList.map((e) => Text('$e $sibuncho')).toList(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push Test"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: testText,
              onChanged: (text) {
                pushText = testText.text;
              },
              textAlignVertical: TextAlignVertical.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      FlutterLocalNotification.showNotication(pushText);
                    },
                    child: const Text("알림 보내기")),
                TextButton(
                  onPressed: () {
                    setState(() {
                      min = min + 1;
                      dt2 = testTime.add(Duration(minutes: min));
                      // 상태를 초기화 해줘야 바뀌지 ㅇㅇ.
                    });
                  },
                  child: Text("$min"),
                )
              ],
            ),
            Container(
              color: Colors.white,
              width: 200,
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CupertinoPicker(
                      itemExtent: 24,
                      onSelectedItemChanged: (value) {
                        setState(() {
                          // year = years[value];
                        });
                      },
                      children: _hourList.map((e) => Text('$e 시')).toList(),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CupertinoPicker(
                      itemExtent: 24,
                      onSelectedItemChanged: (value) {
                        setState(() {
                          // year = years[value];
                        });
                      },
                      children: _minuteList.map((e) => Text('$e 분')).toList(),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CupertinoPicker(
                      itemExtent: 24,
                      onSelectedItemChanged: (value) {
                        setState(() {
                          // year = years[value];
                        });
                      },
                      children: _secondList.map((e) => Text('$e 초')).toList(),
                    ),
                  ),
                ],
              ),
            ),
            // Text("${timer2}"),
            Text("${testTime.hour}시 ${testTime.minute} 분 ${testTime.second} 초"),
            Text("${dt2.minute}")
          ],
        ),
      ),
    );
  }
}
