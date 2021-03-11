import 'package:flutter/material.dart';
import 'package:nexflix_clone/model/model_movie.dart';
import 'package:nexflix_clone/screen/detail_screen.dart';

// CircleSlider 위젯은 상태변화가 없다.
class CircleSlider extends StatelessWidget {
  //홈스크린 파일에서 movies를 넘겨받아야 한다. Movie를 자동 import하고 생성자로 movies를 받아온다.
  final List<Movie> movies;
  CircleSlider(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('미리보기'),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: makeCircleImages(context, movies),
            ),
            )
        ],
      ),
    );
  }

  List<Widget> makeCircleImages(BuildContext context, List<Movie> movies) {
    List<Widget> results = [];
    for(var i=0;i<movies.length;i++){
      results.add(
          InkWell(
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute<Null>(
                      fullscreenDialog: true,
                      builder: (BuildContext context){
                        return DetailScreen(
                          movies[i],
                        );
                      }
                  )
              );
            },
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(movies[i].poster),
                  radius: 48,
                ),
              )
            ),
          )
      );
    }
    return results;
  }


}
