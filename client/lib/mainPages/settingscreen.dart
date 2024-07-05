import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  final String userName = '사용자 이름'; // 이 부분은 추후 DB와 연결하여 사용자 데이터를 가져올 예정입니다.
  final String userAge = '사용자 나이'; // 이 부분은 추후 DB와 연결하여 사용자 데이터를 가져올 예정입니다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_circle, size: 80),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      userAge,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            _buildSettingCard(context, '개인정보 수정', Icons.person, _navigateToPersonalInfo),
            _buildSettingCard(context, '과거 데이터 조회', Icons.history, _navigateToDataHistory),
            _buildSettingCard(context, '라이센스', Icons.book, _navigateToLicense),
            _buildSettingCard(context, '문의하기', Icons.contact_mail, _navigateToContact),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }

  void _navigateToPersonalInfo() {
    // 추후 개인정보 수정 페이지로 이동
  }

  void _navigateToDataHistory() {
    // 추후 과거 데이터 조회 페이지로 이동
  }

  void _navigateToLicense() {
    // 추후 라이센스 페이지로 이동
  }

  void _navigateToContact() {
    // 추후 문의하기 페이지로 이동
  }
}
