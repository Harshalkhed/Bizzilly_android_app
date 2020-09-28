import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(31, 73, 125, 1.0),
        title: Text("About Us",style: TextStyle(fontWeight: FontWeight.bold),),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.95,
        child: ListView( 
          shrinkWrap: true,
          children: [
            Container( 
              margin: EdgeInsets.only(top:20.0),
              child: Image.asset("assets/images/Logo_Blue.png",height: 120,width: 120),
            ),
            Container( 
              margin: EdgeInsets.only(left:10.0,right:10.0,top:30.0,bottom: 20.0),
              child: Text('''\t\t\t\t\t\t\t Bizzilly- As this term itself is self explanatory, this app is a search app displaying information pertaining to various businesses. Since day one we started thinking about this app, our goal has been to connect businesses with people across the globe. In this digital era, SecureTech leads with solutions that help you achieve your goals by reaching out to the community. Our objective has been to promote new and existing businesses in your community and help them serve the people of our country. You not only help them establish but also prosper your own community. We are in every neighborhood and our local knowledge will help your business get the attention and expertise it deserves. Today, virtual working has been at its utmost importance. So why do all the driving searching for what you need? Let 'Bizzilly' do it for you, while you relax. It will do all the searching in your area and will give you the best results within 30 kms of your current location, right at your fingertips. Connect with the service provider instantly on your mobile phone and get the services you are looking for. We invest time and money in our innovation lab, searching for new technologies to help keep you one step ahead in this digital world.''',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color:Color.fromRGBO(31, 73, 125, 1.0,)),)
            )
          ],
        ),
      ),
      
    );
  }
}