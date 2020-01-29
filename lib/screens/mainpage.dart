import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:prent/components/drawer_component.dart';
import 'package:prent/components/product_container_home_page.dart';
import 'package:prent/components/cart_button.dart';
import 'package:prent/screens/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:prent/provider_service/product_service.dart';
import 'package:carousel_pro/carousel_pro.dart';

class MainPageScreen extends StatefulWidget {
  @override
  _MainPageScreenState createState() => _MainPageScreenState();
}
class _MainPageScreenState extends State<MainPageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget buildCarousel(String image){
   return Container(
     color: Colors.white,
      width: MediaQuery.of(context).size.width,
     height: 300.0,
     child: Image.asset(image),


    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
        backgroundColor: Color(0xfff4f4f4),
        drawer: MakeDrawer(),
        appBar: AppBar(
          leading: InkWell(
            onTap: (){
                  _scaffoldKey.currentState.openDrawer();
            },
              child: Image.asset('assets/icons/drawer.png')),
            backgroundColor: Color(0xffFFCA37),
            actions: <Widget>[
              shoppingCartIconButton(context),
            ],
            centerTitle: true,
            title:InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchScreen()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width*3.5,
                decoration: BoxDecoration(
                    color: Color(0xffF7B600),
                    borderRadius: BorderRadius.circular(15.0),
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(AppLocalizations.of(context).tr('home_page.search'),style: TextStyle(color: Colors.white,fontSize: 15.0),),
                    Icon(Icons.search)
                  ],

              ),
            )
        ),),
        body: FutureBuilder(
          future: Provider.of<Category>(context, listen: false).fetchData(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapShot.error != null) {
                return Center(
                  child: Image.asset('assets/images/no.png',height: 150.0,width: 150.0,color: Color(0xffF7B600)),
                );
              } else {
                { return  Consumer<Category>(
                    builder: (context, data, child) => Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          children: <Widget>[
                            SizedBox(height: 10.0,),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: Carousel(
                                dotBgColor: Colors.transparent,
                                boxFit: BoxFit.cover,
                                dotColor: Color(0xffF7B600),
                                dotIncreasedColor: Color(0xffF7B600),
                                dotSize: 6.0,
                                images: [
                                  buildCarousel('assets/images/image1.jpg'),
                                  buildCarousel('assets/images/image2.gif'),
                                  buildCarousel('assets/images/image3.jpg'),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: data.subCat.data.length,
                                itemBuilder: (context, index) {
                                  return SubCategory(
                                    title: data.subCat.data[index].name,
                                    models: data.subCat.data[index].models,
                                    id: data.subCat.data[index].id,
                                  );
                                }
                            ),
                          ],
                        )
                    ));}
              }
            }
          },
        ));
  }
}
