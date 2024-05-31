import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:page_transition/page_transition.dart';

import '../layout/normal_layout.dart';
import '../shared/shared.dart';
import 'test_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NormalLayout(
      headText: 'home page',
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.3,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                ),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "https://images-intl.prod.aws.idp-connect.com/commimg/myhotcourses/institution/CH/section/myhc_342130.jpg",
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Positioned(
                              bottom: 40,
                              left: 5,
                              right: 5,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width - 20,
                                ),
                                child: Text(
                                  "Celebrating ten years of establishment",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 5,
                itemBuilder: ( context,  i) {
                  return Container(height: 120, 
                      margin: EdgeInsets.only(bottom: 15),
                      padding: EdgeInsets.all(5),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(8),
                       color: Colors.white,
                       boxShadow: [
                         BoxShadow(
                           color: blurColor,
                           spreadRadius: 1,
                           blurRadius: 1,
                           offset: Offset(1, 3), // changes position of shadow
                         ),
                       ],

                     )
                     , child: Row(
                        children: [
                          Expanded(flex: 2,child: Image.network("https://cdn.thuvienphapluat.vn/uploads/tintuc/2023/08/05/hoc-phi-nam-hoc-2023-2024.jpg",height: MediaQuery.of(context).size.height,
                              fit: BoxFit.fill)
                          ),
                          Expanded( flex:5,child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text("News App designed by Diana Tomka. Connect with them on Dribbble",style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold
                                ),),
                                Text("12-95-2024 10:20", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.grey),)
                              ],
                            ),
                          ))
                        ],
                      ));
                }),
          )
        ],
      ),
    );
  }
}
