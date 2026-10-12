import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_masterclass/data/data_file.dart';

class ContainerTransformScreen extends StatefulWidget {
  const ContainerTransformScreen({super.key});

  @override
  State<ContainerTransformScreen> createState() =>
      _ContainerTransformScreenState();
}

class _ContainerTransformScreenState extends State<ContainerTransformScreen> {
  bool _isGridMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container Transform'),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () => setState(() {
              _isGridMode = !_isGridMode;
            }),
            icon: Icon(_isGridMode ? Icons.list : Icons.grid_3x3),
          ),
        ],
      ),
      body: _isGridMode
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1 / 1.25,
              ),
              itemCount: colorEnumList.length,
              itemBuilder: (context, index) => OpenContainer(
                closedBuilder: (context, action) => Column(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              colorEnumList[index % colorEnumList.length].color,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Text(
                            colorEnumList[index % colorEnumList.length].name,
                            style: TextStyle(fontWeight: FontWeight(700)),
                          ),
                          Text(
                            colorEnumList[index % colorEnumList.length].desc,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                openBuilder: (context, action) =>
                    DetailScreen(index: index % colorEnumList.length),
              ),
            )
          : ListView.separated(
              itemBuilder: (context, index) => OpenContainer(
                openBuilder: (context, action) =>
                    DetailScreen(index: index % colorEnumList.length),
                closedBuilder: (context, action) => Material(
                  child: ListTile(
                    title: Text(
                      colorEnumList[index % colorEnumList.length].name,
                    ),
                    subtitle: Text(
                      colorEnumList[index % colorEnumList.length].desc,
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    leading: Container(
                      decoration: BoxDecoration(
                        shape: .circle,
                        color:
                            colorEnumList[index % colorEnumList.length].color,
                      ),
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
              ),
              separatorBuilder: (_, _) => const SizedBox(height: 20),
              itemCount: colorEnumList.length,
            ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final int index;

  const DetailScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Screen')),
      body: Center(
        child: Column(
          spacing: 10,
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorEnumList[index].color,
                borderRadius: BorderRadius.circular(10),
              ),
              width: deviceWidth * 0.8,
              height: deviceWidth * 0.8,
            ),
            Text(colorEnumList[index].name, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
