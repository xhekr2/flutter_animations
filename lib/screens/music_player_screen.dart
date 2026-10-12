import 'dart:ui';

import 'package:flutter/material.dart';

import './music_player_detail_screen.dart';
import '../data/data_file.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  final ValueNotifier<double> _scroll = ValueNotifier(0.0);

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      if (_pageController.page == null) return;
      _scroll.value = _pageController.page!;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: Container(
              key: UniqueKey(),
              // key: ValueKey(_currentPage),
              decoration: BoxDecoration(
                color: colorEnumList[_currentPage].color,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          ),
          PageView.builder(
            onPageChanged: (value) => setState(() {
              _currentPage = value;
            }),
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: colorEnumList.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder(
                    valueListenable: _scroll,
                    builder: (context, value, child) {
                      final scale = 1 - (value - index).abs() * 0.1;
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    FadeTransition(
                                      opacity: animation,
                                      child: MusicPlayerDetailScreen(
                                        index: index,
                                      ),
                                    ),
                          ),
                        ),
                        child: Hero(
                          tag: index,
                          child: Transform.scale(
                            scale: scale,
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorEnumList[index].color,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.4),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: Offset(0, 8),
                                  ),
                                ],
                              ),
                              height: size.width * 0.85,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  ValueListenableBuilder(
                    valueListenable: _scroll,
                    builder: (context, value, child) {
                      final scale = 1 - (value - index).abs() * 0.5;
                      return Transform.scale(
                        scale: scale,
                        child: Text(
                          colorEnumList[index].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight(600),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}