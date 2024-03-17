import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Sửa cú pháp của constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SafeArea(
        child: Scaffold(
          body: MyHomePage(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key); // Sửa cú pháp của constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Hi, Phạm Xuân Hiếu",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3D3D3D)),
              ),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black45,
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.notifications_on_outlined,
                  size: 32,
                  color: Color(0xff4A4A4A),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFFAFAFA)),
            alignment: Alignment.center,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('asset/calendar.png',width: 100,),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Thời khóa biểu"),
                        Text(
                          "16 tháng 3",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent),
                        child: const Text('Lịch Thi',
                            style: TextStyle(color: Colors.white)))
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Không có lịch! "),
                    Text(
                      "Xem thêm TKB",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          const SizedBox(
            width: double.maxFinite,
            child: Text('Thông báo gần đây',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFFAFAFA)),
            alignment: Alignment.center,
            child: const Column(
              children: [
                Text(
                  'THÔNG BÁO V/v mở, không mở các lớp học phần trong học kì 2 năm học 2023-2024 cho sinh viên Đại học các khóa',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      size: 16,
                    ),
                    Text(
                      ' 03:30 02/02/2024',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const SizedBox(
            width: double.maxFinite,
            child: Text('Tiện ích',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 300,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 0.5,
                mainAxisExtent: 140
              ),
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return GridItem(index: index);
              },
            ),
          )
        ],
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final int index;
  final List<Data> listData = [
    Data(Icons.payments_outlined, 'Tài chính'),
    Data(Icons.bar_chart, 'Kết quả học phần'),
    Data(Icons.description_outlined, 'Học Phần'),
    Data(Icons.school, 'Tốt nghiệp'),
    Data(Icons.phone, 'DV một cửa'),
    Data(Icons.book, 'Đánh giá rèn luyện'),
    Data(Icons.question_mark, 'Hỏi đáp'),
    Data(Icons.edit, 'Khảo sát')
  ];

  GridItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            listData[index].iconData,
            size: 50,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 10,),
        Text(
          listData[index].name,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

final class Data {
  final IconData iconData;
  final String name;

  Data(this.iconData, this.name);
}
