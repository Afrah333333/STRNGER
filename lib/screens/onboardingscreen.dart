import 'package:flutter/material.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/dart/bottomnavbar.dart';
import 'home_screen.dart';
import '../authenticate/Wrapper.dart';
import '../authenticate/login_screen.dart';
import '../constants/dart/onBoard_pages.dart';


class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({Key? key}) : super(key: key);

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  int currentindex = 0;
  late PageController _controller;
  @override
  void initState()  {
    // TODO: implement initState
    setState(() {
      _controller = PageController(initialPage: 0);
    });

    super.initState();
  }

  _storeOnboardInfo() async {
    print("Shared pref called");
    bool isViewed = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('BoardKey', isViewed);
    print(prefs.getBool('BoardKey'));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(onPressed: () {
            _storeOnboardInfo();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
             BottomNavBar()));
          },
              child: Text('skip',
              style: TextStyle(fontSize: 21,color: Colors.purple.shade200,
              fontStyle: FontStyle.italic
              ),
              )
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PageView.builder(
          itemCount: pages.length,
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int index){
            setState(() {
              currentindex = index;
            });
            },
            itemBuilder: (_,index){
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Image.asset(pages[index].img,
                    fit: BoxFit.cover,
                    ),
                ),
                Text(pages[index].title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25),),
                Text(pages[index].subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: () {
                      _storeOnboardInfo();
                      _controller.previousPage(duration: Duration(milliseconds: 300),
                          curve: Curves.bounceOut);
                    },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.all(20.0),),
                          backgroundColor: MaterialStateProperty.all(Colors.purple.shade200),
                          shadowColor: MaterialStateProperty.all(Colors.purple.shade50),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(

                              borderRadius: BorderRadius.circular(30.0)
                          ))
                      ), child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.arrow_back,color: Colors.black,),
                          const Text('back',
              style: TextStyle(fontSize: 20,color: Colors.black),),
                        ],
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: WormEffect(
                        spacing: 16,
                        dotColor: Colors.black26,
                        activeDotColor: Colors.purple.shade200
                      ),
                    ),
                    ElevatedButton(onPressed: ()  {
                      if (index == pages.length - 1) {
                         _storeOnboardInfo();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(
                                builder: (_) => HomePage()));}
                        _controller.nextPage(duration: const Duration(
                            milliseconds: 300),
                            curve: Curves.bounceIn);
                    },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.all(20.0),),
                          backgroundColor: MaterialStateProperty.all(Colors.purple.shade200),
                          shadowColor: MaterialStateProperty.all(Colors.purple.shade50),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)
                          ))
                      ),child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('next',
                    style: TextStyle(fontSize: 20,color: Colors.black),),
                          Icon(Icons.arrow_forward,color: Colors.black,)
                        ],
                      ),
                    )
                  ],
                ),

              ],
            );
            }

        ),
      ),
    );
  }
}
