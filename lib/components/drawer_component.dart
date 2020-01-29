import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:prent/screens/cart_screen.dart';
import 'package:prent/screens/mainpage.dart';
import 'package:prent/screens/webview.dart';
class MakeDrawer extends StatefulWidget {
  @override
  _MakeDrawerState createState() => _MakeDrawerState();
}

class _MakeDrawerState extends State<MakeDrawer> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      elevation: 20.0,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Container(
              height: MediaQuery.of(context).size.height*0.08,
              width: MediaQuery.of(context).size.width*0.5,
              child: Row(
        children: <Widget>[
          Image.asset('assets/icons/logo.png'),
          SizedBox(height: 10.0,),
          Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height*0.08,),
                  Text(
                    AppLocalizations.of(context).tr(
                      'logo.name',
                    ),
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        color: Color(0xff505050),
                        fontSize: 18.0),
                  ),
                  Text(
                    AppLocalizations.of(context).tr(
                      'logo.title',
                    ),
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        color: Color(0xff505050),
                        fontSize: 12.0),
                  ),
                ],
          )
        ],
      ),
            ),

            decoration: BoxDecoration(color: Colors.white),
          ),
          SizedBox(width: 5.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainPageScreen()));
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      color: Color(0xffFFCA37),
                    ),
                    SizedBox(width: 5.0,),
                    Text(
                      AppLocalizations.of(context).tr(
                        'drawer.main',
                      ),
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          color: Color(0xff505050),
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 5.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CartScreen()));
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icons/shopping-bag.png'),
                    SizedBox(width: 5.0,),
                    Text(
                      AppLocalizations.of(context).tr('drawer.cart_shopping'),
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          color: Color(0xff505050),
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 5.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WikipediaExplorer(url: 'http://p-prent.com/contact',)));
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icons/question.png'),
                    SizedBox(width: 5.0,),
                    Text(
                      AppLocalizations.of(context).tr('drawer.question'),
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          color: Color(0xff505050),
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 5.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WikipediaExplorer(url: 'http://p-prent.com/',)));
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icons/internet.png'),
                    SizedBox(width: 5.0,),
                    Text(
                      AppLocalizations.of(context).tr('drawer.visit_website'),
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          color: Color(0xff505050),
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 5.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WikipediaExplorer(url: 'http://p-prent.com/about',)));

              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icons/info.png'),
                    SizedBox(width: 5.0,),
                    Text(
                      AppLocalizations.of(context).tr('drawer.about'),
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          color: Color(0xff505050),
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
                 SizedBox(height: MediaQuery.of(context).size.height/4,),
                 InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>WikipediaExplorer(url: 'http://p-prent.com/terms',)));
                      },
                      child: Container(
                              child:
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                       AppLocalizations.of(context).tr('drawer.conditions'),
                                        style: TextStyle(fontFamily: 'Tajawal',
                                            color: Color(0xff505050),
                                            fontSize: 18.0),
                                      ),
                              ),
                            ),
                    ),
              ],
      ),
    );
  }
}
