import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../sub/question_page.dart';
import 'dart:convert';
import 'package:firebase_analytics/firebase_analytics.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  // JSON파일을 비동기로 로드하는 함수
  Future<String> loadAsset() async {
    return await rootBundle.loadString('res/api/list.json');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>( // Future 타입 명시
        future: loadAsset(), // future 속성에서 loadAsset() 함수 호출을 통해 json 파일들 비동기(aync)로 읽고 문자열로 반환
        builder: (context, snapshot) {
          //연결 상태에 따라 다른 위젯 보여주기
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            // 데이터를 가져오는 동안 CircularProgressIndicator 표시하기
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              // 데이터를 가져오기에 성공했다면
              if (snapshot.hasData) {
                Map<String, dynamic> list = jsonDecode(snapshot.data!); // 위에서 반환된 문자열을 Map 형식의 JSON 데이터로 디코딩
                return ListView.builder(
                  itemCount: list['count'],
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        // 파이어베이스 로그 이벤트 출력하기
                        try {
                          await FirebaseAnalytics.instance.logEvent(
                            name: 'test_click',
                            parameters: {
                              'test_name':
                                list['questions'][index]['title'].toString(),
                            },);
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return QuestionPage(
                                  question:
                                    list['questions'][index]['file'].toString(),
                                );
                              }));
                        } catch (e) {
                          print('Failed to log event: $e');
                        }
                      },
                      child: SizedBox(
                        height: 50,
                        child: Card(
                          child: Text(
                            list['questions'][index]['title'].toString(),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                // 오류가 발생했다면 오류 메세지 표시하기
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                // 데이터가 없다면 'No Data' 표시하기
                return const Center(
                  child: Text('No Data'),
                );
              }
            default:
              return const Center(
                child: Text('No Data'),
              );
          }
        }

      )
    );
  }
}