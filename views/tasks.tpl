% include("header.tpl")
% include("banner.tpl")

<style>
  .save_edit, .undo_edit, .move_task, .sets, .reps, .description, .edit_task, .delete_task {
    cursor: pointer;
  }
  .completed {text-decoration: line-through;}
  .description { padding-left:8px }
  .sets { padding-left:8px }
  .reps { padding-left:8px }
</style>

<div class="w3-row w3-xxlarge w3-bottombar w3-border-theme-dark-blue w3-margin-bottom"></div>

<div class="w3-row">
  <div class="w3-panel w3-card-4 w3-round-xlarge" style="background-color:#1b1b2a; color:#b1b7ba; margin: auto; width:800px">
    <div class="w3-row w3-xxlarge w3-bottombar w3-border-theme-dark-blue w3-margin-bottom">
      <h1><i>Workout</i></h1>
    </div>
    <table id="task-list-today" class="w3-table">
    </table>
    <div class="w3-row w3-bottombar w3-border-theme-dark-blue w3-margin-bottom w3-margin-top"></div>
  </div>
</div>
<input id="current_input" hidden value=""/> 
<script>
/* API CALLS */
function api_get_tasks(success_function) {
  $.ajax({url:"api/tasks", type:"GET", 
          success:success_function});
}
function api_create_task(task, success_function) {
  console.log("creating task with:", task)
  $.ajax({url:"api/tasks", type:"POST", 
          data:JSON.stringify(task), 
          contentType:"application/json; charset=utf-8",
          success:success_function});
}
function api_update_task(task, success_function) {
  console.log("updating task with:", task)
  task.id = parseInt(task.id)
  $.ajax({url:"api/tasks", type:"PUT", 
          data:JSON.stringify(task), 
          contentType:"application/json; charset=utf-8",
          success:success_function});
}
function api_delete_task(task, success_function) {
  console.log("deleting task with:", task)
  task.id = parseInt(task.id)
  $.ajax({url:"api/tasks", type:"DELETE", 
          data:JSON.stringify(task), 
          contentType:"application/json; charset=utf-8",
          success:success_function});
}
/* KEYPRESS MONITOR */
function input_keypress(event) {
  if (event.target.id != "current_input") {
    $("#current_input").val(event.target.id)
  }
  id = event.target.id.replace("set_input-","");    // added
  id = event.target.id.replace("rep_input-","");    // added
  id = event.target.id.replace("input-","");
  $("#filler-"+id).prop('hidden', true);
  $("#save_edit-"+id).prop('hidden', false);
  $("#undo_edit-"+id).prop('hidden', false);
}
/* EVENT HANDLERS */
function move_task(event) {
  if ($("#current_input").val() != "") { return }
  console.log("move item", event.target.id )
  id = event.target.id.replace("move_task-","");
  target_list = event.target.className.search("today") > 0 ? "tomorrow" : "today";
  api_update_task({'id':id, 'list':target_list},
                  function(result) { 
                    console.log(result);
                    get_current_tasks();
                  } );
}
// called when 'description' is clicked -- completes task
function complete_task_des(event) {
  if ($("#current_input").val() != "") { return }
  console.log("complete item", event.target.id )
  id = event.target.id.replace("description-","");
  completed = event.target.className.search("completed") > 0;
  console.log("updating :",{'id':id, 'completed':completed==false})
  api_update_task({'id':id, 'completed':completed==false}, 
                  function(result) { 
                    console.log(result);
                    get_current_tasks();
                  } );
}
// called when 'sets' is clicked -- completes task
function complete_task_set(event) {
  if ($("#current_input").val() != "") { return }
  console.log("complete item", event.target.id )
  id = event.target.id.replace("sets-","");
  completed = event.target.className.search("completed") > 0;
  console.log("updating :",{'id':id, 'completed':completed==false})
  api_update_task({'id':id, 'completed':completed==false}, 
                  function(result) { 
                    console.log(result);
                    get_current_tasks();
                  } );
}
// called when 'reps' is clicked -- completes task
function complete_task_rep(event) {
  if ($("#current_input").val() != "") { return }
  console.log("complete item", event.target.id )
  id = event.target.id.replace("reps-","");
  completed = event.target.className.search("completed") > 0;
  console.log("updating :",{'id':id, 'completed':completed==false})
  api_update_task({'id':id, 'completed':completed==false}, 
                  function(result) { 
                    console.log(result);
                    get_current_tasks();
                  } );
}
function edit_task(event) {
  if ($("#current_input").val() != "") { return }
  console.log("edit item", event.target.id)
  id = event.target.id.replace("edit_task-","");
  // move the text to the input editor
  $("#set_input-"+id).val($("#sets-"+id).text());   // added
  $("#rep_input-"+id).val($("#reps-"+id).text());   // added
  $("#input-"+id).val($("#description-"+id).text());
  // hide the text display
  $("#move_task-"+id).prop('hidden', true);
  $("#sets-"+id).prop('hidden', true);              // added
  $("#reps-"+id).prop('hidden', true);              // added
  $("#description-"+id).prop('hidden', true);
  $("#edit_task-"+id).prop('hidden', true);
  $("#delete_task-"+id).prop('hidden', true);
  // show the editor
  $("#set_editor-"+id).prop('hidden', false);   // added
  $("#rep_editor-"+id).prop('hidden', false);   // added
  $("#editor-"+id).prop('hidden', false);
  $("#save_edit-"+id).prop('hidden', false);
  $("#undo_edit-"+id).prop('hidden', false);
  // set the editing flag
  $("#current_input").val(event.target.id)
}
function save_edit(event) {
  console.log("save item", event.target.id)
  id = event.target.id.replace("save_edit-","");
  console.log("desc to save = ",$("#input-" + id).val())
  console.log("reps to save = ",$("#rep_input-" + id).val())    // added
  console.log("sets to save = ",$("#set_input-" + id).val())    // added
  if ((id != "today") & (id != "tomorrow")) {
    api_update_task({'id':id, description:$("#input-" + id).val(), sets:$("#set_input-" + id).val(), reps:$("#rep_input-" + id).val()},
                    function(result) { 
                      console.log(result);
                      get_current_tasks();
                      $("#current_input").val("")
                    } );
  } else {
    api_create_task({description:$("#input-" + id).val(), sets:$("#set_input-" + id).val(), reps:$("#rep_input-" + id).val(), list:id},
                    function(result) { 
                      console.log(result);
                      get_current_tasks();
                      $("#current_input").val("")
                    } );
  }
}
function undo_edit(event) {
  id = event.target.id.replace("undo_edit-","")
  console.log("undo",[id])
  $("#input-" + id).val("");
  $("#set_input-" + id).val("");    // added
  $("#rep_input-" + id).val("");    // added
  if ((id != "today") & (id != "tomorrow")) {
    // hide the editor
    $("#set_editor-"+id).prop('hidden', true);    // added
    $("#rep_editor-"+id).prop('hidden', true);    // added
    $("#editor-"+id).prop('hidden', true);
    $("#save_edit-"+id).prop('hidden', true);
    $("#undo_edit-"+id).prop('hidden', true);
    // show the text display
    $("#move_task-"+id).prop('hidden', false);
    $("#sets-"+id).prop('hidden', false);
    $("#reps-"+id).prop('hidden', false);
    $("#description-"+id).prop('hidden', false);
    $("#filler-"+id).prop('hidden', false);
    $("#edit_task-"+id).prop('hidden', false);
    $("#delete_task-"+id).prop('hidden', false);
  }
  // set the editing flag
  $("#current_input").val("")
}
function delete_task(event) {
  if ($("#current_input").val() != "") { return }
  console.log("delete item", event.target.id )
  id = event.target.id.replace("delete_task-","");
  api_delete_task({'id':id},
                  function(result) { 
                    console.log(result);
                    get_current_tasks();
                  } );
}
function display_task(x) {
  arrow = (x.list == "today") ? "arrow_forward" : "arrow_back";
  completed = x.completed ? " completed" : "";
  if ((x.id == "today") | (x.id == "tomorrow")) {
    t = '<tr id="task-'+x.id+'" class="task">' +
        '  <td style="width:36px"></td>' +  
        '  <td style="width:96px"><span id="set_editor-'+x.id+'">' + 
        '        <input id="set_input-'+x.id+'" style="height:22px" class="w3-input" '+ 
        '          type="text" autofocus placeholder="# of Sets"/>'+
        '      </span>' + 
        '  </td>' +
        '  <td style="width:96px"><span id="rep_editor-'+x.id+'">' + 
        '        <input id="rep_input-'+x.id+'" style="height:22px" class="w3-input" '+ 
        '          type="text" autofocus placeholder="# of Reps"/>'+
        '      </span>' + 
        '  </td>' +
        '  <td><span id="editor-'+x.id+'">' + 
        '        <input id="input-'+x.id+'" style="height:22px" class="w3-input" '+ 
        '          type="text" autofocus placeholder="Exercise..."/>'+
        '      </span>' + 
        '  </td>' +
        '  <td style="width:72px">' +
        '    <span id="filler-'+x.id+'" class="material-icons">more_horiz</span>' + 
        '    <span id="save_edit-'+x.id+'" hidden class="save_edit material-icons" style="color:#00d764;">done</span>' + 
        '    <span id="undo_edit-'+x.id+'" hidden class="undo_edit material-icons" style="color:#fc1f5d;">cancel</span>' +
        '  </td>' +
        '</tr>';
  } else {
    t = '<tr id="task-'+x.id+'" class="task">' + 
        '  <td><span id="move_task-'+x.id+'" class="move_task '+x.list+' material-icons">' + arrow + '</span></td>' +
        '  <td><span id="sets-'+x.id+'" class="sets' + completed + '">' + x.sets + '</span>' + 
        '      <span id="set_editor-'+x.id+'" hidden>' + 
        '        <input id="set_input-'+x.id+'" style="height:22px" class="w3-input" type="text" autofocus/>' +
        '      </span>' + 
        '  </td>' +
        '  <td><span id="reps-'+x.id+'" class="reps' + completed + '">' + x.reps + '</span>' + 
        '      <span id="rep_editor-'+x.id+'" hidden>' + 
        '        <input id="rep_input-'+x.id+'" style="height:22px" class="w3-input" type="text" autofocus/>' +
        '      </span>' + 
        '  </td>' +
        '  <td><span id="description-'+x.id+'" class="description' + completed + '">' + x.description + '</span>' + 
        '      <span id="editor-'+x.id+'" hidden>' + 
        '        <input id="input-'+x.id+'" style="height:22px" class="w3-input" type="text" autofocus/>' +
        '      </span>' + 
        '  </td>' +
        '  <td>' +
        '    <span id="edit_task-'+x.id+'" class="edit_task '+x.list+' material-icons" style="color:#0ea3ff;">edit</span>' +
        '    <span id="delete_task-'+x.id+'" class="delete_task material-icons" style="color:#fc1f5d;">delete</span>' +
        '    <span id="save_edit-'+x.id+'" hidden class="save_edit material-icons" style="color:#00d764;">done</span>' + 
        '    <span id="undo_edit-'+x.id+'" hidden class="undo_edit material-icons" style="color:#fc1f5d;">cancel</span>' +
        '  </td>' +
        '</tr>';
  }
  $("#task-list-" + x.list).append(t);
  $("#current_input").val("")
}
function get_current_tasks() {
  // remove the old tasks
  $(".task").remove();
  // display the new task editor
  display_task({id:"today", list:"today"})
  display_task({id:"tomorrow", list:"tomorrow"})
  // display the tasks
  api_get_tasks(function(result){
    for (const task of result.tasks) {
      display_task(task);
    }
    // wire the response events 
    $(".move_task").click(move_task);
    $(".description").click(complete_task_des)
    $(".sets").click(complete_task_set)
    $(".reps").click(complete_task_rep)
    $(".edit_task").click(edit_task);
    $(".save_edit").click(save_edit);
    $(".undo_edit").click(undo_edit);
    $(".delete_task").click(delete_task);
    // set all inputs to set flag
    $("input").keypress(input_keypress);
  });
}
$(document).ready(function() {
  get_current_tasks()
});
</script>
% include("footer.tpl")
