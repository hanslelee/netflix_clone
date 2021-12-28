import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexflix_clone/model/model_movie.dart';
import 'package:nexflix_clone/screen/detail_screen.dart';

class LikeScreen extends StatefulWidget {
  @override
  _LikeScreenState createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  Widget _buildBody(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
        .collection('movie')
        .where('like', isEqualTo: true)
        .snapshots(),
        builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.docs);
        },
    );
  }
  Widget _buildList (BuildContext context, List<DocumentSnapshot> snapshot){
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1/1.5,
        padding: EdgeInsets.all(3),
        children: snapshot.map((data)=> _buildListItem(context, data)).toList(),
      )
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final movie = Movie.fromSnapshot(data);
    return InkWell(
        child: Image.network(movie.poster),
      onTap: () {
          Navigator.of(context).push(MaterialPageRoute<Null>(
              fullscreenDialog: true,
            builder: (BuildContext context){
                return DetailScreen(movie);
            }
          ));
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 40, 20,15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                    'images/netflix_PNG10.png',
                  fit: BoxFit.contain,
                  height:25,
                ),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    '내가 찜한 콘텐츠',
                    style: TextStyle(fontSize: 15),
                  )
                ),

              ],
            ),
            
          ),
          _buildBody(context),
        ],
      ),
    );
  }
}
