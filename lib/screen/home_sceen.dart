import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexflix_clone/model/model_movie.dart';
import 'package:nexflix_clone/widget/box_slider.dart';
import 'package:nexflix_clone/widget/carousel_slider.dart';
import 'package:nexflix_clone/widget/circle_slider.dart';

//영화의 데이터를 백엔드에서 가져와야하기 때문에 stateful위젯으로 만든다.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> streamData;

  @override
  void initState() {
    super.initState();
    streamData = firestore.collection("movie").snapshots();
    //이때 movie는 firestore에서 작성한 컬렉션 이름
  }

  Widget _fetchData(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('movie').snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();
        // 데이터를 못가져왔다면 로딩화면띄우고
        return _buildBody(context, snapshot.data.docs);
        //데이터를 가져왔다면 _buildBody함수를 호출하여 실제 위젯을 만든다.
      },
    );
  }
  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Movie> movies = snapshot.map((d)=> Movie.fromSnapshot(d)).toList();
    //map을 통해 우리가 다룰수 있는 Movie모델로 바꿔서 이걸 리스트에 넣어준디
    return ListView(
      children: [
        Stack(
          children: [
            CarouselImage(movies),
            TopBar(),
          ],),
        CircleSlider(movies),
        BoxSlider(movies),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20,7,20,7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Image.asset(
          'images/netflix_PNG10.png',
          fit: BoxFit.contain,
          height: 25,
        ),
        Container(
            padding: EdgeInsets.only(right:1),
            child: Text(
              'TV 프로그램',
              style: TextStyle(
                fontSize: 14,
              ),
            )
        ),
        Container(
            padding: EdgeInsets.only(right:1),
            child: Text(
              '영화',
              style: TextStyle(
                fontSize: 14,
              ),
            )
        ),
        Container(
            padding: EdgeInsets.only(right:1),
            child: Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(
                fontSize: 14,
              ),
            )
        ),
      ],),
    );
  }
}
