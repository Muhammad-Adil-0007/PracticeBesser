import 'package:flutter/material.dart';

class MyChip extends StatelessWidget {
  final String text;
  final bool state;
  final VoidCallback onTap;
  const MyChip({super.key, required this.text, required this.state, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02,
          vertical: MediaQuery.of(context).size.width * 0.014),
      decoration: BoxDecoration(
        color: const Color(0xff49b38a).withOpacity(0.8),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
          ),
          const SizedBox(
            width: 5,
          ),
          Visibility(
              visible: state,
              child: GestureDetector(
                onTap: onTap,
                child: Icon(Icons.cancel_outlined,
                    size: MediaQuery.of(context).size.width * 0.045),
              ))
        ],
      ),
    );
  }
}
