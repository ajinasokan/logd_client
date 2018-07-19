import 'dart:collection';
import 'dart:async';

typedef Future<void> Task();

class TaskQueue {
  Queue<Task> tasks = Queue();
  bool isProcessing = false;

  void add(Task task) {
    tasks.add(task);
    process();
  }

  void process() async {
    if (isProcessing) return;

    isProcessing = true;
    while (tasks.length > 0) await tasks.removeFirst()();
    isProcessing = false;
  }
}
