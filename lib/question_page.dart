import 'package:flutter/material.dart';
import 'package:flutter_intern_task_recommend_app/reccomend_page.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  //ToDo: ここに使用する変数を定義しよう！
  double _currentSliderValue = 0;
  String? _isSelectedItem = '選択してください';

  // リスト
  final selectLists = <String>['選択してください', '肩', '首', '肩甲骨', '腰', '足'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Re.Ra.Ku'),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 2),
            Container(
              color: Colors.green,
              padding: const EdgeInsets.all(5.0),
              child: const Center(
                child: Text(
                  '以下の質問に回答で\nあなたにオススメのコースを算出します!',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const Spacer(),
            const Text('■ 本日のお疲れはどれくらいですか？', style: TextStyle(fontSize: 15)),
            const SizedBox(height: 20),
            Center(
              child: Text(
                '$_currentSliderValue',
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),
            Slider(
                min: 0,
                max: 10,
                label: '$_currentSliderValue',
                value: _currentSliderValue,
                inactiveColor: Colors.grey,
                activeColor: Colors.green,
                divisions: 10,
                onChanged: (value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                }),
            const Spacer(),
            const Text('■ 一番辛い箇所はどちらですか？', style: TextStyle(fontSize: 15)),
            const SizedBox(height: 10),
            DropdownButton<String>(
                items: selectLists
                    .map((String list) => DropdownMenuItem(
                          value: list,
                          child: Text(list),
                        ))
                    .toList(),
                // _isSelectedItem指定
                value: _isSelectedItem,
                underline: Container(
                  height: 1,
                  color: Colors.lightGreen,
                ),
                isExpanded: true,
                onChanged: (String? value) {
                  setState(() {
                    _isSelectedItem = value;
                  });
                }),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_currentSliderValue == 0) {
                    const snackBar = SnackBar(
                      content: Text('本日のお疲れを入力してください'),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (_isSelectedItem == '選択してください') {
                    const snackBar = SnackBar(
                      content: Text('一番辛い箇所を選択してください'),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecommendPage(
                          painPart: _isSelectedItem!,
                          tiredPoint: _currentSliderValue,
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  '決定',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
