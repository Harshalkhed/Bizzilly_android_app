import 'package:flutter/material.dart';

class GridView1 extends StatefulWidget {
  @override
  _GridView1State createState() => _GridView1State();
}

class _GridView1State extends State<GridView1> {
  @override
  Widget build(BuildContext context) {
    singleCard(cardtext) {
      return GestureDetector(
          // onTap: () {
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (_) => SelectCategoryPage()));
          // },
          child: Card(
        color: Colors.deepPurple[800],
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(25)),
        margin: EdgeInsets.all(20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                cardtext,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ));
    }

    return Container(
      child: GridView.count(
        crossAxisSpacing: 5,
        crossAxisCount: 2,
        children: <Widget>[
          singleCard('Marathi / मराठी'),
          singleCard('Punjabi / पंजाबी'),
          singleCard('Gujarati / ગુજરાતી'),
          singleCard('Bengali / বাংলা'),
          singleCard('N/A'),
        ],
      ),
    );
  }
}
