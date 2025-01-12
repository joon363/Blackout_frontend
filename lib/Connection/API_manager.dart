import 'dart:convert';
import 'package:bremen/route/route_constants.dart';
import 'package:bremen/themes.dart';
import 'package:bremen/Connection/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
export 'package:provider/provider.dart';
import 'package:dio/dio.dart';
const String backendBaseUrl = "http://ec2-3-80-116-226.compute-1.amazonaws.com:5000";
const String bearerToken = "test-token";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final TextEditingController idController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();
  static Future<void> login(BuildContext context) async {

    final globalState = Provider.of<GlobalState>(context, listen: false);
    final dio = Dio();
    final cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    final url = Uri.parse("$backendBaseUrl/login"); // 서버 URL
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken', // Bearer Token 추가
    };
    final body = jsonEncode({
      'username': idController.text,
      'password': passwordController.text,
    }
    );

    try {
      final response = await dio.post(
        "$backendBaseUrl/login",
        data: body,
        options: Options(headers: headers), 
      );

      if (response.statusCode == 200) {
        print("set-cookie: ${response.headers['set-cookie']}");
        final cookies = await cookieJar.loadForRequest(Uri.parse("$backendBaseUrl/login"));
        final sessionCookie = cookies.firstWhere((cookie) => cookie.name == 'session');
        globalState.session = sessionCookie.value;
        print(globalState.session);
        Navigator.pushReplacementNamed(
          context,
          homePageRoute
        );

      }
      else {
        // 로그인 실패
        final errorData = response.data;
        print("로그인 실패: ${errorData['error']}");
      }
    }
    catch (e) {
      print("오류 발생: $e");
    }
  }
  Future<void> _register() async {
    final url = Uri.parse("$backendBaseUrl/register"); // 서버 URL
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken', // Bearer Token 추가
    };
    final body = jsonEncode({
      'username': idController.text,
      'password': passwordController.text,
    }
    );

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        // 로그인 성공
        final data = jsonDecode(response.body);
        print("회원가입 성공");
      }
      else {
        // 로그인 실패
        final errorData = jsonDecode(response.body);
        print("회원가입 실패");
      }
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("오류 발생: $e")),
      );
    }
  }
  @override
  void initState() {
    super.initState();
    idController.text = 'bremen';
    passwordController.text = 'bremen';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey, // 배경색 (이미지 로드 안 됐을 때 표시)
              borderRadius: BorderRadius.circular(defaultBorderRadius), // 모서리를 둥글게
              image: DecorationImage(
                //colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                image: Image.asset('assets/images/login_cover.png').image,
                // 로컬 이미지 경로
                fit: BoxFit.cover, // 이미지를 박스 크기에 맞게 자르기
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: idController,
                  style: PTextStyle(Colors.white, PFontStyle.label, regularInter),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: 'ID',
                    labelStyle: PTextStyle(Colors.white, PFontStyle.label, regularInter),
                    filled: false, // 배경을 채우기
                    fillColor: Colors.transparent, // 배경색 하얀색으로 설정
                    focusColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.white), // 테두리 색
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.white), // 테두리 색
                    ),

                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  style: PTextStyle(Colors.white, PFontStyle.label, regularInter),
                  obscureText: true,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: 'PW',
                    labelStyle: PTextStyle(Colors.white, PFontStyle.label, regularInter),
                    filled: false, // 배경을 채우기
                    fillColor: Colors.transparent, // 배경색 하얀색으로 설정
                    focusColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.white), // 테두리 색
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.white), // 테두리 색
                    ),

                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: defaultPadding,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        login(context);
                      },
                      child: PText("로그인", PFontStyle.label, primaryColor, semiboldInter),
                    ),
                    ElevatedButton(
                      onPressed: _register,
                      child: PText("회원가입", PFontStyle.label, primaryColor, semiboldInter),
                    ),
                  ],
                ),

              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  homePageRoute
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: Colors.white, // 버튼 배경색 하얀색으로 설정
                backgroundColor: Colors.white, // 버튼 텍스트 색상 (여기서는 검정색)
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // 패딩
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // 둥근 모서리
                ),
              ),
              child: PText("skip", PFontStyle.label, primaryColor, semiboldInter),
            ),
          )
        ],
      )
    );
  }

}
