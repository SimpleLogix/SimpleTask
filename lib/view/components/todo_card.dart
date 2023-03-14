import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmate/model/profile.dart';
import 'package:taskmate/model/task.dart';
import 'package:taskmate/model/todo_list.dart';
import 'package:taskmate/services/globals.dart';

class TodoCard extends StatefulWidget {
  bool isEditModeOn = false;
  final TodoList list;
  final VoidCallback onLongPress;
  final VoidCallback onRemoveTodo;
  TodoCard({
    super.key,
    required this.list,
    required this.onLongPress,
    required this.onRemoveTodo,
    required this.isEditModeOn,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  PageController controller = Get.put(PageController(initialPage: 0));
  @override
  Widget build(BuildContext context) {
    // grab to do list from widget and do some quick maths
    TodoList list = widget.list;
    int done = 0;
    for (Task task in list.tasks) {
      if (task.isDone) {
        done++;
      }
    }

    return InkWell(
      onTap: () {
        if (!widget.isEditModeOn) {
          // get user todo's and find index of selected todo
          Profile user = Get.find<Profile>();
          final int index = user.todoLists.indexOf(list) + 1;
          const Duration duration = Duration(milliseconds: 500);

          controller.animateToPage(
            index,
            duration: duration,
            curve: (index < 3) ? Curves.easeIn : Curves.linear,
          );
        }
      },
      onLongPress: widget.onLongPress,
      highlightColor: MyColors.pressed,
      borderRadius: const BorderRadius.all(Radius.circular(18)),
      child: Ink(
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 25,
          shadowColor: Colors.black,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                  child: Container(
                    color: MyColors.badge,
                    padding: const EdgeInsets.all(0.1),
                    child: Card(
                      elevation: 50,
                      shadowColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      color: list.color,
                      child: Center(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 45),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: splitText(list.name))),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 45,
                height: 45,
                margin: const EdgeInsets.fromLTRB(0, 0, 4, 4),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  color: MyColors.badge,
                ),
                child: IconButton(
                  onPressed: widget.isEditModeOn? widget.onRemoveTodo : (){},
                  icon: Icon(
                    widget.isEditModeOn ? Icons.close_rounded : list.icon,
                    color: MyColors.lightTxt,
                    size: 18,
                  ),
                ),
              ),
              Container(
                height: 10,
                width: 200,
                margin: const EdgeInsets.fromLTRB(4, 0, 48, 4),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                  ),
                  color: MyColors.badge,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(13, 0, 0, 18),
                  child: Text(
                    "${done.toString()} / ${list.tasks.length.toString()}",
                    style: const TextStyle(
                      color: MyColors.lightTxt,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> splitText(String text) {
    final List<Widget> res = [];
    // split the string text into words
    final words = text.split(" ");
    // add strings that are short
    List<String> parsedWords = [];
    for (int i = 0; i < words.length; i++) {
      // if small word and not the first, append next to prev word
      if (words[i].length < 3 && i > 0 && words[i - 1].length < 9) {
        final word = "${words[i - 1]} ${words[i]}";
        parsedWords.removeLast();
        parsedWords.add(word); // update to ew word
      } else {
        parsedWords.add(words[i]);
      }
    }
    for (String word in parsedWords) {
      if (word.isNotEmpty) {
        res.add(Flexible(
          child: FittedBox(
            fit: BoxFit.cover,
            child: Text(
              word,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: MyColors.lightTxt,
                fontSize: 18,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ));
      }
    }
    return res;
  }
}
