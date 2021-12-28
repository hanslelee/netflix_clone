import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nexflix_clone/model/model_movie.dart';
import 'package:nexflix_clone/screen/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText ="";

  //이런식으로 searchScreen state를 관리해줄 수도 있다.
  //검색 위젯을 컨트롤하는 _filter가 변화를 감지하여 searchText의 상태를 변화시킨다.
  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  // 검색했을때 나오는 화면 만들기
  Widget _buildBody(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('movie').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot){
    List<DocumentSnapshot> searchResults =[];
    for(DocumentSnapshot d in snapshot){
      if(d.data().toString().contains(_searchText))
        searchResults.add(d);
    }
    return Expanded(
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1/1.5,
          padding: EdgeInsets.all(3),

          //map함수를 통해 각 아이템을 _buildListItem 함수에 넣어 호출한다.
          children: searchResults
              .map((data)=>_buildListItem(context, data))
              .toList(),
          //searchResults 리스트에서 data요소의 개수만큼 _buildListItem함수를 실행하고
          // _buildListItem함수에서 리턴값을 받을때마다
          //toList()함수를 사용하여 searchResults리스트에 넣어준다.

        ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data){
    final movie = Movie.fromSnapshot(data);
    return InkWell(
      child: Image.network(movie.poster),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<Null>(
          fullscreenDialog: true,
          builder: (BuildContext context) {
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
          Padding(
            padding: EdgeInsets.all(30),
          ),
          Container(
            color: Colors.black,
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: TextField(
                    focusNode: focusNode,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    autofocus: true,
                    controller: _filter,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white12,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white60,
                        size: 20,
                      ),
                      //커서가 있을 때 X버튼을 띄우고 아니면 빈상태로 유지
                      suffixIcon: focusNode.hasFocus
                        ?IconButton(
                        icon: Icon(
                          Icons.cancel,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _filter.clear();
                            _searchText = "";
                          });
                        },
                      )
                          :Container(),
                      hintText: '검색',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
                focusNode.hasFocus
                    ? Expanded(
                    child: FlatButton(
                      child:Text('취소', style: TextStyle(fontSize: 13),),
                      onPressed: () {
                        setState(() {
                          _filter.clear();
                          _searchText="";
                          focusNode.unfocus();
                        });
                      },
                    )
                )
                    :Expanded(
                  flex: 0,
                  child: Container(

                  ),
                )
              ],
            ),
          ),
          _buildBody(context),
        ],
      ),
    );
  }
}
