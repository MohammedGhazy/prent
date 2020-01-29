import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:prent/screens/mainpage.dart';
import 'package:easy_localization/easy_localization.dart';
class AfterSplashScreen extends StatefulWidget {
  @override
  _AfterSplashScreenState createState() => _AfterSplashScreenState();
}

class _AfterSplashScreenState extends State<AfterSplashScreen> {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    Widget buildItem(String image,String text){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width*0.6,
              child: Text(text,style: TextStyle(fontFamily: 'Tajawal',fontSize: 25.0,color: Colors.black,),)),
          Image.asset(
            image,height: 250.0,width: 250.0,
          ),
        ],
      );
    }
    return EasyLocalizationProvider(
      data: data,
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.cover,
              )
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 2 + 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 1.0,
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                               bottomLeft: (Radius.circular(190.0)),
                                bottomRight: (Radius.circular(190.0)))),
                        child: Carousel(
                          images: [
                            buildItem('assets/images/1.png', 'نعدك بكل ما يلزمك'),
                            buildItem('assets/images/2.png', 'يتوفر لدينا جميع الطابعات'),
                            buildItem('assets/images/3.png', 'دعم فني دوري مجاني'),
                          ],
                          dotIncreasedColor: Colors.orange,
                          dotSize: 12.0,
                          dotSpacing: 15.0,
                          dotColor: Color(0xffFFCA37),
                          indicatorBgPadding: 5.0,
                          dotBgColor: Colors.transparent,
                          borderRadius: true,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 10.0, top: 15.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width / 3 + 20.0,
                                color: Color(0xffFFCA37),
                                child: FlatButton(
                                    color: Color(0xffFFCA37),
                                    child: Text(
                                      'العربيه',
                                      style:
                                      TextStyle(fontSize: 20.0, color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MainPageScreen()));
                                      this.setState(() {
                                        data.changeLocale(Locale("ar", "DZ"));
                                        print(Localizations.localeOf(context).languageCode);
                                      });
                                    }
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 10.0, top: 15.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width / 3 + 20.0,
                                color: Color(0xffFFCA37),
                                child: FlatButton(
                                  color: Color(0xffFFCA37),
                                  child: Text(
                                    'English',
                                    style:
                                    TextStyle(fontSize: 20.0, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MainPageScreen()));
                                    this.setState(() {
                                      data.changeLocale(Locale("en", "US"));
                                      print(Localizations.localeOf(context).languageCode);
                                    });
                                  },
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 30.0,)
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
