import 'package:flutter/material.dart';
import 'package:todo_app/controller/store.dart';

Widget buildTaskItem(height, width, notes, index, snapShot) {
  Store store = Store();
  return Dismissible(
    key: UniqueKey(),
    child: Padding(
      padding: EdgeInsetsDirectional.only(
          start: 10.0, bottom: 10.0, top: 10.0, end: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: height * 0.13,
            decoration: BoxDecoration(
              color: selectColor(notes, index),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width / 1.75,
                        child: Text(
                          '${notes[index].title}',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                            letterSpacing: 1,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Text(
                        '${notes[index].deadLine}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width / 1.5,
                    child: Text(
                      '${notes[index].note}',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(
                        width: width * 0.017,
                      ),
                      Text(
                        '${notes[index].startTime} - ${notes[index].endTime}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          PopupMenuButton(
            child: Icon(
              Icons.more_vert,
              size: 27.0,
              color: Colors.blueGrey.shade700,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text(
                    'Done',
                  ),
                  onTap: () {},
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text(
                    'Archive',
                  ),
                ),
              ];
            },
            elevation: 10,
            splashRadius: 30,
            onSelected: (value) {
              if (value == 0) {
              } else if (value == 1) {}
            },
          ),
        ],
      ),
    ),
    onDismissed: (direction) {
      store.deleteNote(
        id: snapShot.data.docs[index].id,
        title: notes[index].title,
      );
    },
    direction: DismissDirection.startToEnd,
    background: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Icon(
          Icons.delete_sweep_outlined,
          color: Colors.white70,
          size: 35.0,
        ),
      ),
    ),
  );
}

Color selectColor(notes, index) {
  return notes[index].colorId == 0
      ? Colors.deepPurple.shade300
      : notes[index].colorId == 1
          ? Colors.red.shade300
          : notes[index].colorId == 2
              ? Colors.green.shade300
              : notes[index].colorId == 3
                  ? Colors.blue.shade300
                  : Colors.blueGrey.shade300;
}
