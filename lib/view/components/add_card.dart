import 'package:flutter/material.dart';
import 'package:taskmate/services/globals.dart';

class AddCard extends StatefulWidget {
  VoidCallback func;
  AddCard({super.key, required this.func});

  @override
  State<AddCard> createState() => _AddCardState();
}
// i was too lazy and didnt want this in my global file so i made it into a widget
// i also didnt want to call Get inside globals so here we are :/
// might refactor and remove in the **future**

class _AddCardState extends State<AddCard> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.func,
      icon: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 25,
        shadowColor: Colors.black,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18))),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          child: Container(
            decoration: BoxDecoration(gradient: MyColors.greyBorder),
            padding: const EdgeInsets.all(0.1),
            child: Stack(
              fit: StackFit.expand,
              children:  [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: ColoredBox(color: Colors.black45),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                    child: DecoratedBox(decoration: BoxDecoration(gradient: MyColors.grey),),
                  ),
                ),
                const Center(
                    child: Icon(
                  Icons.add_rounded,
                  size: 64,
                  color: Colors.white,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
