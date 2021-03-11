import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nexflix_clone/model/model_movie.dart';
import 'package:nexflix_clone/screen/detail_screen.dart';

// 단순히 화면 보여주는게 다가 아니라 찜하기 등 인터랙션이 필요해서 stateful
class CarouselImage extends StatefulWidget {
  //홈화면에서 CarouselImage로 movies를 넘겨받아야한다. 생성자 생성
  final List<Movie> movies;
  CarouselImage(this.movies); //alt+insert 단축키



  @override
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  // state로 관리해줄 변수들 선언
  List<Movie> movies;
  List<Widget> images;
  List<String> keywords;
  List<bool> likes;

  // 현재 CarouselImage에서 어느 위치에 있는지 index를 저장할 _currenPage를 만든다.
  int _currentPage = 0;
  String _currentKeyword; // _currentPage에 기록되어있는 키워드 관리


  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies.map((m)=>Image.network(m.poster)).toList();
    keywords = movies.map((m)=>m.keyword).toList();
    likes = movies.map((m)=>m.like).toList();
    _currentKeyword = keywords[0];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding:EdgeInsets.all(20),
          ),
          CarouselSlider(
            items: images,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                  _currentKeyword = keywords[_currentPage];
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0,10,0,3),
            child: Text(
              _currentKeyword,
              style: TextStyle(fontSize: 11),
            ),

          ),
          Container(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(
                  children: [
                    likes[_currentPage]
                    ? IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          setState(() {
                            likes[_currentPage] = !likes[_currentPage];
                            movies[_currentPage].reference.update(
                              {'like': likes[_currentPage]}
                            );
                          });
                        })
                        :IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          likes[_currentPage] = !likes[_currentPage];
                          movies[_currentPage].reference.update(
                              {'like': likes[_currentPage]}
                          );
                        });
                      },
                    ),
                    Text('내가 찜한 콘텐츠', style: TextStyle(fontSize: 11),)
                  ],
                )
              ),
              Container(
                padding: EdgeInsets.only(right:10),
                child: FlatButton(
                  color:Colors.white,
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: EdgeInsets.all(3),
                      ),
                      Text(
                        '재생',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right:10),
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<Null>(
                              fullscreenDialog: true,
                              builder: (BuildContext context){
                                return DetailScreen(
                                  movies[_currentPage],
                                );
                            }
                          )
                        );
                      },
                    ),
                    Text('정보', style: TextStyle(fontSize: 11)),
                  ],
                )
              ),
            ],
          ),
          ),
          Container(child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: makeIndicator(likes, _currentPage),
          ))
        ],
      )
    );
  }
}

List<Widget> makeIndicator(List list, int _currentPage){
  List<Widget> results = [];
  for(var i=0; i<list.length;i++){
    results.add(
      Container(
        width: 8,
        height: 8,
        margin:
          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == i
            ? Color.fromRGBO(255, 255, 255, 0.9)
              : Color.fromRGBO(255, 255, 255, 0.4),

        ),
      )
    );
  }

  return results;
}