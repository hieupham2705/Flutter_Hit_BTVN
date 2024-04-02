import 'package:flutter/material.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.wechat_sharp,
                    color: Colors.white,
                    size: 40,
                  ))
            ],
            backgroundColor: Colors.red,
            title: const Text(
              'Lịch sử hiến máu',
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
          ),
          body: const MyHomePage(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        children: [
          const Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://cdn.tuoitre.vn/thumb_w/480/471584752817336320/2023/5/10/iu6-1683694373791472731774.png'),
              ),
              Positioned(
                  bottom: -10,
                  right: -10,
                  child: ClipRRect(
                    clipBehavior: Clip.none,
                    child: Icon(
                      Icons.camera_alt,
                    ),
                  ))
            ],
          ),
          const Text('Phạm Xuân Hiếu'),
          TextButton(
            onPressed: () {},
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.greenAccent)),
            child: const Text(
              'Mức 2',
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xFFEFEFEF),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, int index) {
                    return ListItem(index: index);
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final int index;
  final List<Data> listData = <Data>[
    Data('25/1/2024', 'Trung tâm hội nghị quốc gia', '350 ml (Toàn phần)'),
    Data('25/1/2024', 'Trung tâm hội nghị quốc gia', '350 ml (Toàn phần)'),
    Data('25/1/2024', 'Trung tâm hội nghị quốc gia', '350 ml (Toàn phần)'),
    Data('25/1/2024', 'Trung tâm hội nghị quốc gia', '350 ml (Toàn phần)')
  ];

  ListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(20),
            border:
                const Border(left: BorderSide(color: Colors.red, width: 10))),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                width: 100,
                color: const Color(0xFFF6F6F6),
                child: Text(
                  'Lần ${index + 1}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listData[index].day,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.ac_unit_outlined),
                        Text(
                          ' ${listData[index].capacity}',
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        )
                      ],
                    ),
                    Text(listData[index].place,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey))
                  ],
                )),
            const Expanded(
                flex: 1,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey,
                ))
          ],
        ));
  }
}

final class Data {
  final String day;
  final String place;
  final String capacity;

  Data(this.day, this.place, this.capacity);
}
