import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  //영화 모델에 들어갈 요소들을 final형태로 만든다.
  final String title;
  final String keyword;
  final String poster; //영화 poster url
  final bool like; // 영화 찜했는지
  final DocumentReference reference;

  // Movie클래스에 대한 fromMap()메소드 정의
  Movie.fromMap(Map<String, dynamic> map, {this.reference})
  : title = map['title'],
    keyword = map['keyword'],
    poster = map['poster'],
    like = map['like'];

  // DocumentSnapshot을 작성하고 라이브러리 자동 임포트
  Movie.fromSnapshot(DocumentSnapshot snapshot)
  : this.fromMap(snapshot.data(), reference: snapshot.reference);


  //인스턴스를 출력할때 편하기위해
  @override
  String toString() =>"Movie<$title: $keyword>";

}