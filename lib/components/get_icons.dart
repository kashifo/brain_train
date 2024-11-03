import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget getIcon(String title){
  switch(title){
    case 'Memory': return getSvgIcon('brain_gear.svg');
    case 'Imagination': return getNormalIcon(Icons.remove_red_eye);
    case 'Attention': return getSvgIcon('alert_filled.svg');
    case 'Math': return getSvgIcon('abacus.svg');
    case 'Scores': return getNormalIcon(Icons.score);
    case 'About': return getNormalIcon(Icons.info_outline);
    case 'History': return getNormalIcon(Icons.history);
    case 'Feedback': return getNormalIcon(Icons.feedback_outlined);

    //Memory
    case 'Repeat the Numbers': return getNormalIcon(Icons.repeat_one);
    case 'Find the Pair': return getSvgIcon('flip_flops.svg');
    case 'Compare': return getSvgIcon('compare.svg');
    case 'Matrix': return getSvgIcon('matrix.svg');

    //Imagination
    case 'Classic Puzzle': return getSvgIcon('puzzles.svg');
    case 'Sliding Puzzle': return getSvgIcon('slide_button.svg');

    //Attention
    case 'Find the Number': return getSvgIcon('folder_search.svg');

    //Math
    case 'Human Calculator': return getSvgIcon('calc.svg');
  }

  return getNormalIcon(Icons.ac_unit);
}

Widget getNormalIcon(var icon){
  return Icon(
    icon,
    color: Colors.white,
    size: 25,
  );
}

Widget getSvgIcon(var icon){
  return SvgPicture.asset(
    'assets/icons/$icon',
    colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
    width: 25,
  );
}
