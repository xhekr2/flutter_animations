import 'package:flutter/material.dart';

import '../data/data_file.dart';

class _MenuModel {
  final IconData iconData;
  final String text;
  final Animation<Offset> animation;

  const _MenuModel({
    required this.iconData,
    required this.text,
    required this.animation,
  });
}

class const MusicPlayerDetailScreen({super.key, required final int index})
    extends StatefulWidget {
  @override
  State<MusicPlayerDetailScreen> createState() =>
      _MusicPlayerDetailScreenState();
}

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen>
    with TickerProviderStateMixin {
  late final AnimationController _progressController;
  late final AnimationController _textSlideController;
  late final AnimationController _pausePlayController;
  late final AnimationController _menuController;

  late final IntTween _leftTime;
  late final IntTween _rightTime;

  late final Animation<Offset> _xSlideOffset;
  late final Animation<double> _screenScale;
  late final Animation<Offset> _screenOffset;

  late final Animation<double> _closeButtonOpacity;
  late final Animation<Offset> _profileSlide;
  late final Animation<Offset> _notificationsSlide;
  late final Animation<Offset> _settingsSlide;
  late final Animation<Offset> _logoutSlide;

  final Curve _menuCurve = Curves.easeInOutCubic;

  bool _isDrag = false;

  final ValueNotifier<double> _volume = ValueNotifier<double>(0.0);

  late final List<_MenuModel> _menuModel;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    )..repeat(reverse: true);

    _leftTime = IntTween(begin: 0, end: 60);
    _rightTime = IntTween(begin: 60, end: 0);

    _textSlideController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 15),
    )..repeat(reverse: true);

    _xSlideOffset = Tween<Offset>(
      begin: Offset(0.1, 0),
      end: Offset(-0.6, 0),
    ).animate(_textSlideController);

    _pausePlayController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _menuController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _screenScale = Tween<double>(begin: 1.0, end: 0.7).animate(
      CurvedAnimation(
        parent: _menuController,
        curve: Interval(0, 0.3, curve: _menuCurve),
      ),
    );

    _screenOffset = Tween<Offset>(begin: Offset.zero, end: Offset(0.5, 0))
        .animate(
          CurvedAnimation(
            parent: _menuController,
            curve: Interval(0.5, 1, curve: _menuCurve),
          ),
        );

    _closeButtonOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _menuController,
        curve: Interval(0.2, 0.4, curve: _menuCurve),
      ),
    );

    _profileSlide = Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _menuController,
            curve: Interval(0.4, 0.7, curve: _menuCurve),
          ),
        );
    _notificationsSlide = Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _menuController,
            curve: Interval(0.5, 0.8, curve: _menuCurve),
          ),
        );
    _settingsSlide = Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _menuController,
            curve: Interval(0.6, 0.9, curve: _menuCurve),
          ),
        );

    _logoutSlide = Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _menuController,
            curve: Interval(0.8, 1.0, curve: _menuCurve),
          ),
        );

    _menuModel = [
      _MenuModel(
        iconData: Icons.person,
        text: "Profile",
        animation: _profileSlide,
      ),
      _MenuModel(
        iconData: Icons.notifications,
        text: "Notifications",
        animation: _notificationsSlide,
      ),
      _MenuModel(
        iconData: Icons.settings,
        text: "Settings",
        animation: _settingsSlide,
      ),
    ];
  }

  @override
  void dispose() {
    _progressController.dispose();
    _menuController.dispose();
    _pausePlayController.dispose();
    _textSlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            leading: FadeTransition(
              opacity: _closeButtonOpacity,
              child: IconButton(
                onPressed: () => _menuController.reverse(),
                icon: const Icon(Icons.close),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 30),
                for (final _MenuModel menu in _menuModel) ...[
                  SlideTransition(
                    position: menu.animation,
                    child: Row(
                      spacing: 10,
                      children: [
                        Icon(menu.iconData, color: Colors.grey.shade200),
                        Text(
                          menu.text,
                          style: TextStyle(
                            color: Colors.grey.shade200,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
                const Spacer(),
                SlideTransition(
                  position: _logoutSlide,
                  child: const Row(
                    spacing: 10,
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      Text(
                        'Log out',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
        SlideTransition(
          position: _screenOffset,
          child: ScaleTransition(
            scale: _screenScale,
            child: Scaffold(
              appBar: AppBar(
                title: Text(/*colorEnumList[widget.index].name*/ 'Now Playing'),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () => _menuController.forward(),
                    icon: const Icon(Icons.menu),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: widget.index,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorEnumList[widget.index].color,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.4),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        height: size.width * 0.85,
                        width: size.width * 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  AnimatedBuilder(
                    animation: _progressController,
                    builder: (context, child) {
                      final left = _leftTime.transform(
                        _progressController.value,
                      );
                      final right = _rightTime.transform(
                        _progressController.value,
                      );
                      return Column(
                        spacing: 5,
                        children: [
                          CustomPaint(
                            size: Size(size.width * 0.8, 5),
                            painter: ProgressBar(
                              progressValue: _progressController.value,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${(left ~/ 60).toString().padLeft(2, '0')}:${(left % 60).toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight(600),
                                  ),
                                ),
                                Text(
                                  '${(right ~/ 60).toString().padLeft(2, '0')}:${(right % 60).toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight(600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Text(
                    colorEnumList[widget.index].name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight(600),
                    ),
                  ),
                  SlideTransition(
                    position: _xSlideOffset,
                    child: Text(
                      colorEnumList[widget.index].desc,
                      style: const TextStyle(fontSize: 18),
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      softWrap: false,
                    ),
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      if (_pausePlayController.isCompleted) {
                        _pausePlayController.reverse();
                        _progressController.forward();
                      } else {
                        _pausePlayController.forward();
                        _progressController.stop();
                      }
                    },
                    child: AnimatedIcon(
                      icon: AnimatedIcons.pause_play,
                      progress: _pausePlayController,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onHorizontalDragStart: (_) => _toggleDrag(),
                    onHorizontalDragEnd: (_) => _toggleDrag(),
                    onHorizontalDragUpdate: (details) {
                      _volume.value += details.delta.dx;
                    },
                    child: AnimatedScale(
                      duration: Duration(milliseconds: 200),
                      scale: _isDrag ? 1.1 : 1,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ValueListenableBuilder(
                          valueListenable: _volume,
                          builder: (context, value, child) {
                            return CustomPaint(
                              size: Size(size.width - 80, 50),
                              painter: VolumePainter(volume: value),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _toggleDrag() => setState(() {
    _isDrag = !_isDrag;
  });
}

class const ProgressBar({required final double _progressValue})
    extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double progress = size.width * _progressValue;

    final RRect trackRRect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      Radius.circular(10),
    );

    final Paint trackPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;

    canvas.drawRRect(trackRRect, trackPaint);

    final RRect progressRRect = RRect.fromLTRBR(
      0,
      0,
      progress,
      size.height,
      Radius.circular(10),
    );

    final Paint progressPaint = Paint()
      ..color = Colors.grey.shade500
      ..style = PaintingStyle.fill;

    canvas.drawRRect(progressRRect, progressPaint);
    canvas.drawCircle(Offset(progress, size.height / 2), 7.5, progressPaint);
  }

  @override
  bool shouldRepaint(covariant ProgressBar oldDelegate) {
    return oldDelegate._progressValue != _progressValue;
  }
}

class VolumePainter({required final double volume}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double progress = volume.clamp(0.0, size.width);

    final Paint backgroundPaint = Paint()..color = Colors.grey.shade300;
    final Rect backgroundRect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawRect(backgroundRect, backgroundPaint);

    final Paint volumePaint = Paint()..color = Colors.grey.shade500;
    final Rect volumeRect = Rect.fromLTWH(0, 0, progress, size.height);

    canvas.drawRect(volumeRect, volumePaint);
  }

  @override
  bool shouldRepaint(covariant VolumePainter oldDelegate) {
    return oldDelegate.volume != volume;
  }
}
