import 'package:flutter/material.dart';

// final List<Color> colorList = <Color>[
//   Colors.red.shade100,
//   Colors.orange.shade100,
//   Colors.yellow.shade100,
//   Colors.green.shade100,
//   Colors.blue.shade100,
//   Colors.indigo.shade100,
//   Colors.purple.shade100,
// ];

const List<ColorEnum> colorEnumList = <ColorEnum>[
  ColorEnum.redShade,
  ColorEnum.orangeShade,
  ColorEnum.yellowShade,
  ColorEnum.greenShade,
  ColorEnum.blueShade,
  ColorEnum.indigoShade,
  ColorEnum.purpleShade,
];

enum ColorEnum({
  required final Color color,
  required final String name,
  required final String desc,
}) {
  redShade(
    color: Color(0xFFFFCDD2),
    name: "Colors.red.shade100",
    desc: "Red is an intense color symbolizing passion, energy, danger, and power.",
  ),
  orangeShade(
    color: Color(0xFFFFE0B2),
    name: "Colors.orange.shade100",
    desc: "Orange symbolizes vitality, warmth, creativity, and spirituality.",
  ),
  yellowShade(
    color: Color(0xFFFFF9C4),
    name: "Colors.yellow.shade100",
    desc: "Yellow is a color that symbolizes hope, happiness, wealth, and authority, while also conveying meanings of caution and warning.",
  ),
  greenShade(
    color: Color(0xFFC8E6C9),
    name: "Colors.green.shade100",
    desc:
        "Green symbolizes peace, safety, nature, and psychological stability.",
  ),
  blueShade(
    color: Color(0xFFBBDEFB),
    name: "Colors.blue.shade100",
    desc: "Blue symbolizes trust, tranquility, composure, and hope.",
  ),
  indigoShade(
    color: Color(0xFFC5CAE9),
    name: "Colors.indigo.shade100",
    desc: "Indigo symbolizes wisdom, intuition, insight, and mystery.",
  ),
  purpleShade(
    color: Color(0xFFE1BEE7),
    name: "Colors.purple.shade100",
    desc: "Since ancient times, the color purple has symbolized nobility and power due to the high value of the dye used to produce it.",
  ),
}

/// pixel5 tiramisu: 392.72727272727275
const double deviceWidth = 392.72727272727275;
