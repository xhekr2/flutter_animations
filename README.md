# flutter_animations_masterclass

노마드코더 강의 flutter animations masterclass에서 학습한 내용입니다.

# 파일 설명

## data/
앱에서 사용되는 데이터 파일들입니다.

### data_file.dart
Swiping card, Music Player, Container Transform screen에서 사용하는 enum 정의
deviceWidth는 initState에서 MediaQuery.of(context).size로 size를 얻은 뒤, size.width 접근을 할 수 없어서
Pixel5 API33 Tiramisu의 width를 하드코딩해두었습니다.

### menu_model.dart
menu_model은 music_player_detail_screen에서 사용합니다.
강의에선 단순히 Map으로 정의해 key를 통해 value에 접근했지만
Map을 사용하면 값은 dynamic을 사용해야 하므로 타입 안정성의 문제 그리고
개인적인 코드 스타일이 모델 객체를 정의해두고 사용하는 편이라서 따로 모델을 정의해서 사용했습니다.


## screens/
표시되는 화면들입니다.

### implicit_animations_screen
암시적 애니메이션입니다.

### explicit_animations_screen
명시적 애니메이션입니다. 강의에선 단순히 forward, stop, reverse, repeat을 사용했지만
명시적 애니메이션은 곧 애니메이션을 자유롭게 컨트롤하는 것이라고 생각해

slide를 통해 직접 AnimationController에 접근 가능하게 해두었고
forward, reverse, stop, repeat, repeat의 reverse 속성 변경의 기능을 가진
ElevatedButton을 만들어두었습니다.

### custom_painter_screen
강의에선 AppleWatch입니다. CustomPainter를 사용해서 직접 화면에 그려보는 연습을 했고
Animation을 사용해보았습니다

### swiping_card_screen
카드 두 장을 이용해 마치 여러 장의 카드를 넘기는 듯한 착시 효과를 주는 방법을 알아보았습니다.
강의에서는 asset에 image파일을 저장해두고 사용했지만
개인적인 스타일 때문에 대신 data디렉토리의 data_file.dart에 정의된 ColorEnum을 정의해
사용했습니다. Tween의 transform 메서드를 알아보았습니다.

### music_player_screen
PageView.builder, PageController를 사용했습니다.
배경에서 사용하던 Container의 색이 변하지 않았는데 Page가 바껴도 플러터는
child가 바뀌지 않는다고 판단해 생기는 현상이였습니다. 배경이 되는 Container의 key 속성에
(강의에선) ValueKey로 처음엔 현재 페이지의 인덱스를 사용했습니다.
그런데 페이지를 빠르게 (예를 들면 1=>2=>1) 전환하다 보니 같은 key를 가진 위젯이
화면에 동시에 존재하게 되어 오류가 발생했습니다. 강의에선 미처 다루지 못한 부분 같긴 한데
key에 UniqueKey를 사용하면 전환하는 시간에 남아있는 위젯과 새로운 위젯의 key가 다를 수 있어
오류를 해결할 수 있었습니다.
추가적으로  Backdrop.filter도 알아볼 수 있었습니다.

#### music_player_detail_screen
여러 애니메이션 기법을 알아볼 수 있었습니다. CustomPainter을 사용해 사용자의 제스처를
읽어서 마치 볼륨 조절 바를 만들었고, Progress Bar를 만들었습니다. AnimatedIcon을 이용해
움직이는 아이콘을 간단하게 만들어보기도 했습니다.

### container_transform_screen
animations 패키지에서 OpenContainer를 사용했습니다. 추가로 GridView와 ListView, ListTile을 알아보고
OpenContainer를 사용했을 때 ListTile을 Material로 감싸주지 않아서
Material widget not found와 같은 에러를 받아보았습니다.

### shared_axis_screen
animations 패키지에서 PageTransitionSwitcher와 SharedAxisTransition를 사용했습니다.
처음에 애니메이션이 적용되지 않는 어려움이 있었는데 child가 바뀌지 않는다고 판단하고
그대로 재사용해서 생기는 문제였습니다. music_player_screen에서와 마찬가지로
Container에 key속성에 UniqueKey를 사용했습니다.

강의 수강하며 추가 예정입니다~