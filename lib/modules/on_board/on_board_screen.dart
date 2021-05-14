import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/share/component/component.dart';
import 'package:shop_app/share/network/local/cash-helper.dart';
import 'package:shop_app/share/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardModel {
  final String img;
  final String title;
  final String body;
  OnBoardModel({@required this.img, @required this.title, @required this.body});
}

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  var onBoardingController = PageController();

  bool isLast = false;

  List modelList = [
    OnBoardModel(
      img: 'assets/images/shopping-clipart.png',
      title: 'OnBoard Title 1',
      body: 'OnBoard Body 1',
    ),
    OnBoardModel(
      img: 'assets/images/shopping-clipart.png',
      title: 'OnBoard Title 2',
      body: 'OnBoard Body 2',
    ),
    OnBoardModel(
      img: 'assets/images/shopping-clipart.png',
      title: 'OnBoard Title 3',
      body: 'OnBoard Body 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                endOnBoard();
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white
                )
              ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                if (index == modelList.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              physics: BouncingScrollPhysics(),
              controller: onBoardingController,
              itemBuilder: (context, index) =>
                  buildingBoardingItem(modelList[index]),
              itemCount: 3,
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Row(
            children: [
              SmoothPageIndicator(

                controller: onBoardingController,
                count: modelList.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: AccentColor,
                ),
              ),
              Spacer(),
              FloatingActionButton(
                child: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  if (isLast) {
                   endOnBoard();
                  } else {
                    onBoardingController.nextPage(
                      duration: Duration(
                        milliseconds: 750,
                      ),
                      curve: Curves.easeInToLinear,
                    );
                  }
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget buildingBoardingItem(OnBoardModel model) => Column(
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.img),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            model.body,
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      );

  void endOnBoard(){
    CashHelper.saveData("onBoard", true).then((value) {
      navigateAndFinish(context, Login());
    });
  }
}
