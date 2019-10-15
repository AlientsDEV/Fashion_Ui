import 'package:fashion_ui/tradition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  PageController _pageController;
  double pageControllerPage = 0.0;
  final int _numPages = 3;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.75,);
  }


  _getScale(int index) {
    double scale = 1.1 - (pageControllerPage - index).abs();
    return scale < 0.9 ? 0.9 :scale;
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(bottom: 20.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/city.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken)
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 215.0,
              child: NotificationListener(
                onNotification: (onNotification){
                  setState(() {
                    pageControllerPage = _pageController.page;
                  });
                  return false;
                },

                child: PageView.builder(
                  //shrinkWrap: true,
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: list_fashion.length,
                  itemBuilder: (context,index) =>
                    Transform.scale(
                      scale: _getScale(index),
                      child: SingleItem(index)
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget SingleItem(int index){
    return Container(
      margin: EdgeInsets.all(12.0),
      height: 200.0,
      width: 180.0,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(list_fashion[index].imgPath),
            fit: BoxFit.cover
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child :Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.all(15.0),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  list_fashion[index].name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(height: 2.0,),
                RatingBar(
                  initialRating: 3,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 10.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.blue,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 10.0,),
                Text(
                  'Ten the hastened steepest feelings pleasant few surprise property. An brother he do colonel against minutes uncivil.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
