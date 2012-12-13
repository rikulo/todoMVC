part of todoMVC;

/** The main controller of application.
 */
class TodoAppControl extends Control {
  
  List<Todo> _list;
  int _completedCount;
  
  TextBox _input;
  
  List<Todo> get todos => _list;
  int get completedCount => _completedCount;
  int get activeCount => _list.length - _completedCount;
  
  TodoAppControl(this._list) {
    _completedCount = 0;
    _list.forEach((Todo t) {
      if (t.completed)
        _completedCount++;
    });
  }
  
  //@override
  void onRender() {
    _input = view.query("#new-todo");
  }
  
  void enterNewTodo(DomEvent event) {
    if (event.keyCode == ENTER_KEY) {
      final String title = _input.value.trim();
      if (!title.isEmpty) {
        _list.add(new Todo(title));
        save();
        render();
        _input.node.focus();
      }
    }
  }
  
  void selectAll(ChangeEvent<bool> event) {
    final bool completed = event.value;
    _list.forEach((Todo t) {
      t.completed = completed;
    });
    _completedCount = completed ? _list.length : 0;
    save();
    render();
  }
  
  void clearCompleted(ViewEvent event) {
    _list = _list.filter((Todo t) => !t.completed);
    _completedCount = 0;
    save();
    render();
  }
  
  void increaseCompleted(bool completed) {
    _completedCount += completed ? 1 : -1;
    save();
    render();
  }
  
  void destroy(Todo t) {
    if (_list.removeAt(_list.indexOf(t)).completed)
      _completedCount--;
    save();
    render();
  }
  
  void save() => saveModel(_list);
  
  //@override
  void onCommand(String command, [ViewEvent event]) {}
  
}
