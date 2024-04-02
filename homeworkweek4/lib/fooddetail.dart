import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:homeworkweek4/data.dart';

class FoodDetail extends StatefulWidget {
  const FoodDetail({super.key});

  static const String routeName = '/second';

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  late Meal food;
   bool isvisible = true;
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    food = ModalRoute.of(context)!.settings.arguments as Meal;
    _controller.addListener(() {
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          isvisible = true;
        });
      } else if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          isvisible = false;
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          food.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF272A32),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SingleChildScrollView(
              controller: _controller,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/bgr.png'), fit: BoxFit.cover),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 750,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: 150,
                            left: -100,
                            right: -100,
                            child: Container(
                                height: 6000,
                                decoration: BoxDecoration(
                                  border: const Border(
                                      top: BorderSide(
                                          color: Color(0xFF2a2b2d), width: 10)),
                                  color: const Color(0xFF272A32),
                                  borderRadius: BorderRadius.circular(1000),
                                )),
                          ),
                          Positioned(
                              top: 70,
                              left: 0,
                              right: 0,
                              child: SingleChildScrollView(
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(food.imageUrl),
                                        radius: 120,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(food.title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center),
                                      const Text(
                                        'This is my kind of breakfast egg sandwich and it takes under 5 minutes to make',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xff686F82),
                                          fontSize: 14,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  const Icon(
                                                    Icons.monetization_on,
                                                    color: Color(0xFF686F82),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    food.affordability.name,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF686F82)),
                                                  )
                                                ],
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.timelapse,
                                                    color: Color(0xFF686F82)),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  food.duration.toString(),
                                                  style: const TextStyle(
                                                      color: Color(0xFF686F82)),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.shopping_bag,
                                                    color: Color(0xFF686F82)),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  food.complexity.name,
                                                  style: const TextStyle(
                                                      color: Color(0xFF686F82)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 60,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Ingredient',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            '${food.ingredients.length} item',
                                            style: const TextStyle(
                                              color: Color(0xff686F82),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        height: 100,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: food.ingredients.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0x0ff2c2f3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  food.ingredients[index],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                      const Text('Step:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          )),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: food.steps.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color(0x0ff2c2f3),
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: Text(
                              '- ${food.steps[index]}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              )),
          addFood(
            isvisible: isvisible,
            food: food,
          )
        ],
      ),
    );
  }
}

class addFood extends StatelessWidget {
  final bool isvisible;
  final Meal food;

  const addFood({super.key, required this.isvisible, required this.food});

  @override
  Widget build(BuildContext context) {
    return (isvisible == true)
        ? Positioned(
            bottom: -620,
            left: -100,
            right: -100,
            child: Column(
              children: [
                Text(
                  food.complexity.name,
                  style: const TextStyle(
                      color: Color(0xfff96f67),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  height: 700,
                  width: 700,
                  alignment: Alignment.topCenter,
                  decoration: const BoxDecoration(
                      color: Color(0xfff96f67),
                      borderRadius: BorderRadius.all(Radius.circular(100000))),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white, size: 50),
                    onPressed: () {},
                  ),
                )
              ],
            ))
        : Container();
  }
}
