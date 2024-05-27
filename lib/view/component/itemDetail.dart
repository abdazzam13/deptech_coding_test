import 'package:flutter/cupertino.dart';

class itemDetail extends StatelessWidget {
  const itemDetail({
    super.key,
    required this.title,
    required this.data,
  });

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16
        ),),
        Text(data),
      ],
    );
  }
}