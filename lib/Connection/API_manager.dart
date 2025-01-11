import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String backendBaseUrl = "http://ec2-3-80-116-226.compute-1.amazonaws.com:5000";
const String bearerToken = "test-token";
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  static var session_key;

  Future<void> _login() async {
    final url = Uri.parse("$backendBaseUrl/login"); // 서버 URL
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken', // Bearer Token 추가
    };
    final body = jsonEncode({
      'username': _idController.text,
      'password': _passwordController.text,
    }
    );

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // 로그인 성공
        final data = jsonDecode(response.body);
        session_key = data['session_key']; // 서버가 반환한 토큰 저장
        print(session_key);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("로그인 성공: ${data['message']}")),
        );
      }
      else {
        // 로그인 실패
        final errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("로그인 실패: ${errorData['error']}")),
        );
      }
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("오류 발생: $e")),
      );
    }
  }
  Future<void> _register() async {
    final url = Uri.parse("$backendBaseUrl/register"); // 서버 URL
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken', // Bearer Token 추가
    };
    final body = jsonEncode({
      'username': _idController.text,
      'password': _passwordController.text,
    }
    );

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        // 로그인 성공
        final data = jsonDecode(response.body);
        print(data);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("로그인 성공: ${data['message']}")),
        );
      }
      else {
        // 로그인 실패
        final errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("로그인 실패: ${errorData['error']}")),
        );
      }
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("오류 발생: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: '이메일'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _login,
              child: Text('로그인'),
            ),
            ElevatedButton(
              onPressed: _register,
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }

}
