import 'package:flutter/material.dart';

import '../../models/dart/onBoard_model.dart';


List <OnBoardModel> pages = <OnBoardModel>[
  OnBoardModel(
    img: 'assets/burning_image.jpg',
    title: 'LET GO',
    subtitle: 'An excellent way of letting go to all your pain',
    buttom_Color: Colors.purple
  ),
  OnBoardModel(
      img: 'assets/relax_image.png',
      title: 'RELAX',
      subtitle: 'All amazing relaxing techniques are available',
      buttom_Color: Colors.blue
  ),
  OnBoardModel(
      img: 'assets/chat_image.jpg',
      title: 'SPEAK OUT',
      subtitle: 'No better way than to share your pain with strangers',
      buttom_Color: Colors.green
  ),
];