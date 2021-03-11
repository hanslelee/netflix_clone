import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//main.dart에서 MoreScreen import해준다.
class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50),
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('images/profile.jpg'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                'Hansle Lee',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                'hssarah13@gmail.com'
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: FlatButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                        Icons.edit,
                      size: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Text(
                        '프로필 편집',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.grey[800],
              padding: EdgeInsets.all(17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    size: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Text(
                    '내가 찜한 콘텐츠',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2)
            ),
            Container(
              color: Colors.grey[800],
              padding: EdgeInsets.all(17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.settings,
                    size: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Text(
                    '앱 설정',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(2)
            ),
            Container(
              color: Colors.grey[800],
              padding: EdgeInsets.all(17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.question_answer,
                    size: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Text(
                    '고객 센터',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

