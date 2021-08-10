import 'package:flutter/material.dart';
import '../constants.dart';
import 'TrainingView.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      //bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Colors.orange[400],
              image: DecorationImage(
                image: AssetImage("assets/images/meditation_bg.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      "Video Collection",
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 10),
                    SizedBox(
                      width: size.width * .6, // it just take 60% of total width
                      child: Text(
                        "Hey kido..!!! let's start an activity. Go ahead and select a session.",
                      ),
                    ),
                    SizedBox(
                      width: size.width * .5,
                      height: 180.0, // it just take the 50% width
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: <Widget>[
                        SeassionCard(
                          seassionNum: 1,
                          press: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SessionSingle(title: "Exercise 1",video: "https://firebasestorage.googleapis.com/v0/b/mobileapphackathon-e3c33.appspot.com/o/5%20second%20countdown%20with%20sound%20effect%20(1).mp4?alt=media&token=88d7b96e-4c30-4d31-892d-97b0f38ce195",description: "Learn to do exercises within 15 seconds",tuteID: "D2GY1tW7suIJJigGo74h",ref: "https://storage.googleapis.com/mobileapphackathon-e3c33.appspot.com/Reports/D2GY1tW7suIJJigGo74h/D2GY1tW7suIJJigGo74h.csv",done: false,);
                            }));
                          },
                        ),
                        SeassionCard(
                          seassionNum: 2,
                          press: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context) {
                              return SessionSingle(title: "Exercise 2",video: "https://firebasestorage.googleapis.com/v0/b/mobileapphackathon-e3c33.appspot.com/o/5%20second%20countdown%20with%20sound%20effect%20(2).mp4?alt=media&token=f8394337-727b-4842-aa77-3efc2630ba16",description: "Be active and healthy while watching this video", tuteID: "N1qsWAK1YsDv7jk68X2o",ref: "https://storage.googleapis.com/mobileapphackathon-e3c33.appspot.com/Reports/N1qsWAK1YsDv7jk68X2o/N1qsWAK1YsDv7jk68X2o.csv",done: false,);
                            }));
                          },
                        ),
                        SeassionCard(
                          seassionNum: 3,
                          press: () {},
                        ),
                        SeassionCard(
                          seassionNum: 4,
                          press: () {},
                        ),
                        SeassionCard(
                          seassionNum: 5,
                          press: () {},
                        ),
                        SeassionCard(
                          seassionNum: 6,
                          press: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SeassionCard extends StatelessWidget {
  final int seassionNum;
  final bool isDone;
  final Function press;
  const SeassionCard({
    Key key,
    this.seassionNum,
    this.isDone = false,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth / 2 -
              10, // constraint.maxWidth provide us the available with for this widget
          // padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange[100],
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23,
                spreadRadius: -13,
                color: kShadowColor,
              ),
            ],
          ),
          child: Material(
            color: isDone ? Colors.orange[400] : Colors.yellow[600],
            child: InkWell(
              onTap: press,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 42,
                      width: 43,
                      decoration: BoxDecoration(
                        color: isDone ? Colors.white : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.orange[400]),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: isDone ? Colors.orange[400] : Colors.orange[400],
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Session $seassionNum",
                      style: Theme.of(context).textTheme.subtitle,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
