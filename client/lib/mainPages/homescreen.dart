import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 날짜 포맷을 위해 필요합니다.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homescreen(),
    );
  }
}

class Homescreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Homescreen> {
  DateTime today = DateTime.now();
  int _currentIndex = 0;
  PageController _pageController = PageController();

  // 더미 데이터
  Map<String, String?> bloodSugarData = {
    '아침공복': null,
    '아침식후': null,
    '점심식전': null,
    '점심식후': null,
    '저녁식전': null,
    '취침전': null,
  };

  List<String> pageTitles = ['오늘의 혈당', '기능 2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitles[_currentIndex], style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.lightGreenAccent,
        elevation: 0,
        centerTitle: true, // 제목을 가운데로 오게 설정
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              bloodSugarPage(),
              featurePage(),
            ],
          ),
          Positioned(
            bottom: 16.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPageIndicator(0),
                SizedBox(width: 8.0),
                _buildPageIndicator(1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    return Container(
      width: 12.0,
      height: 12.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? Colors.black : Colors.grey,
      ),
    );
  }

  Widget bloodSugarPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: <Widget>[
                Text(
                  '오늘 날짜',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Spacer(),
                Text(
                  DateFormat('yyyy년 MM월 dd일 EEE').format(today),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          ...bloodSugarData.keys.map((time) {
            final value = bloodSugarData[time];
            return BloodSugarCard(
              time: time,
              value: value ?? '측정 필요',
              isMeasured: value != null,
              onAddPressed: () => _showInputDialog(context, time),
            );
          }).toList(),
          Spacer(),
          Row(
            children: [
              Icon(Icons.info, color: Colors.black, size: 16.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  "공복 혈당은 8시간 이상의 금식 후 아침 공복 상태에서 측정해요. 정상인은 결과가 110mg/dL 이하로 측정되요. 식후 2시간 혈당은 식사 시작 시점부터 2시간 후 측정한 혈당을 말해요. 140mg/dL 이하가 정상이에요.",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget featurePage() {
    return Center(
      child: Text(
        '기능 2',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  void _showInputDialog(BuildContext context, String time) {
    TextEditingController _textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("오늘의 혈당 입력"),
          content: TextField(
            controller: _textFieldController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "혈당기에 적힌 숫자를 적어주세요",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('저장'),
              onPressed: () {
                setState(() {
                  bloodSugarData[time] = _textFieldController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class BloodSugarCard extends StatelessWidget {
  final String time;
  final String value;
  final bool isMeasured;
  final VoidCallback? onAddPressed;

  BloodSugarCard({required this.time, required this.value, required this.isMeasured, this.onAddPressed});

  Color _determineColor() {
    if (isMeasured) {
      int bloodSugarValue = int.tryParse(value) ?? 0;
      if ((time == '아침공복' && bloodSugarValue > 110) ||
          (time != '아침공복' && bloodSugarValue > 140)) {
        return Colors.red;
      } else {
        return Colors.lightBlue;
      }
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      color: _determineColor(),
      child: ListTile(
        title: Text(
          time,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        trailing: isMeasured
            ? Text(
          value,
          style: TextStyle(color: Colors.black, fontSize: 32),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(width: 8.0),
            IconButton(
              icon: Icon(Icons.add, size: 25, color: Colors.black),
              onPressed: onAddPressed,
            ),
          ],
        ),
      ),
    );
  }
}
