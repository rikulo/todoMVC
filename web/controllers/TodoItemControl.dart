part of todoMVC;

/** The controller for [Todo] items.
 */
class TodoItemControl extends Control {
  
  final TodoAppControl _appc;
  final Todo _todo;
  
  TextBox _input;
  TextView _label;
  CheckBox _toggle;
  
  TodoItemControl(this._appc, this._todo);
  
  //@override
  void onRender() {
    _input = view.query("TextBox.edit");
    _label = view.query("TextView.title");
    _toggle = view.query("CheckBox.toggle");
  }
  
  void toggleCompleted(ChangeEvent<bool> event) {
    _appc.increaseCompleted(_todo.completed = event.value);
  }
  
  void editTitle(ViewEvent event) {
    view.classes.add("editing");
    _input.node.focus();
  }
  
  void enterTitle(DOMEvent event) {
    if (event.keyCode == ENTER_KEY)
      _input.node.blur();
  }
  
  void submitTitle(ViewEvent event) {
    final String title = _input.value.trim();
    if (!title.isEmpty) {
      _label.text = _todo.title = title;
      _appc.save();
      view.classes.remove("editing");
    } else 
      destroy();
  }
  
  void destroy([ViewEvent event]) => _appc.destroy(_todo);
  
  //@override
  void onCommand(String command, [ViewEvent event]) {}
  
}
