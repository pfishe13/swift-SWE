% include("header.tpl")
% include("banner.tpl")

<style>
  .save_food_edit, .undo_food_edit, .move_meal, .amount, .calories, .food, .edit_meal, .delete_meal {
    cursor: pointer;
  }
  .completed {text-decoration: line-through;}
  .food { padding-left:8px }
  .amount { padding-left:8px }
  .calories { padding-left:8px }
</style>

<div class="w3-row">
  <div class="w3-col s6 w3-container w3-topbar w3-bottombar w3-leftbar w3-rightbar w3-border-white">
    <div class="w3-row w3-xxlarge w3-bottombar w3-border-black w3-margin-bottom">
      <h1><i>Meals</i></h1>
    </div>
    <table id="meal-list-today" class="w3-table">
    </table>
    <div class="w3-row w3-bottombar w3-border-black w3-margin-bottom w3-margin-top"></div>
  </div>
</div>
<input id="current_food_input" hidden value=""/> 
<script>
/* API CALLS */
function api_get_meals(success_function) {
  $.ajax({url:"api/meals", type:"GET", 
          success:success_function});
}
function api_create_meal(meal, success_function) {
  console.log("creating meal with:", meal)
  $.ajax({url:"api/meals", type:"POST", 
          data:JSON.stringify(meal), 
          contentType:"application/json; charset=utf-8",
          success:success_function});
}
function api_update_meal(meal, success_function) {
  console.log("updating meal with:", meal)
  meal.id = parseInt(meal.id)
  $.ajax({url:"api/meals", type:"PUT", 
          data:JSON.stringify(meal), 
          contentType:"application/json; charset=utf-8",
          success:success_function});
}
function api_delete_meal(meal, success_function) {
  console.log("deleting meal with:", meal)
  meal.id = parseInt(meal.id)
  $.ajax({url:"api/meals", type:"DELETE", 
          data:JSON.stringify(meal), 
          contentType:"application/json; charset=utf-8",
          success:success_function});
}
/* KEYPRESS MONITOR */
function input_keypress(event) {
  if (event.target.id != "current_food_input") {
    $("#current_food_input").val(event.target.id)
  }
  id = event.target.id.replace("amount_input-","");    // added
  id = event.target.id.replace("calories_input-","");    // added
  id = event.target.id.replace("food_input-","");
  $("#filler-"+id).prop('hidden', true);
  $("#save_food_edit-"+id).prop('hidden', false);
  $("#undo_food_edit-"+id).prop('hidden', false);
}
/* EVENT HANDLERS */
function move_meal(event) {
  if ($("#current_food_input").val() != "") { return }
  console.log("move item", event.target.id )
  id = event.target.id.replace("move_meal-","");
  target_list = event.target.className.search("today") > 0 ? "tomorrow" : "today";
  api_update_meal({'id':id, 'list':target_list},
                  function(result) { 
                    console.log(result);
                    get_current_meals();
                  } );
}
// called when 'food' is clicked -- completes meal
function complete_meal_food(event) {
  if ($("#current_food_input").val() != "") { return }
  console.log("complete item", event.target.id )
  id = event.target.id.replace("food-","");
  completed = event.target.className.search("completed") > 0;
  console.log("updating :",{'id':id, 'completed':completed==false})
  api_update_meal({'id':id, 'completed':completed==false}, 
                  function(result) { 
                    console.log(result);
                    get_current_meals();
                  } );
}
// called when 'amount' is clicked -- completes meal
function complete_meal_amount(event) {
  if ($("#current_food_input").val() != "") { return }
  console.log("complete item", event.target.id )
  id = event.target.id.replace("amount-","");
  completed = event.target.className.search("completed") > 0;
  console.log("updating :",{'id':id, 'completed':completed==false})
  api_update_meal({'id':id, 'completed':completed==false}, 
                  function(result) { 
                    console.log(result);
                    get_current_meals();
                  } );
}
// called when 'calories' is clicked -- completes meal
function complete_meal_calories(event) {
  if ($("#current_food_input").val() != "") { return }
  console.log("complete item", event.target.id )
  id = event.target.id.replace("calories-","");
  completed = event.target.className.search("completed") > 0;
  console.log("updating :",{'id':id, 'completed':completed==false})
  api_update_meal({'id':id, 'completed':completed==false}, 
                  function(result) { 
                    console.log(result);
                    get_current_meals();
                  } );
}
function edit_meal(event) {
  if ($("#current_food_input").val() != "") { return }
  console.log("edit item", event.target.id)
  id = event.target.id.replace("edit_meal-","");
  // move the text to the input editor
  $("#amount_input-"+id).val($("#amount-"+id).text());   // added
  $("#calories_input-"+id).val($("#calories-"+id).text());   // added
  $("#food_input-"+id).val($("#food-"+id).text());
  // hide the text display
  $("#move_meal-"+id).prop('hidden', true);
  $("#amount-"+id).prop('hidden', true);              // added
  $("#calories-"+id).prop('hidden', true);              // added
  $("#food-"+id).prop('hidden', true);
  $("#edit_meal-"+id).prop('hidden', true);
  $("#delete_meal-"+id).prop('hidden', true);
  // show the editor
  $("#amount_editor-"+id).prop('hidden', false);   // added
  $("#calories_editor-"+id).prop('hidden', false);   // added
  $("#editor-"+id).prop('hidden', false);
  $("#save_food_edit-"+id).prop('hidden', false);
  $("#undo_food_edit-"+id).prop('hidden', false);
  // set the editing flag
  $("#current_food_input").val(event.target.id)
}
function save_food_edit(event) {
  console.log("save item", event.target.id)
  id = event.target.id.replace("save_food_edit-","");
  console.log("food to save = ",$("#food_input-" + id).val())
  console.log("amount to save = ",$("#amount_input-" + id).val())    // added
  console.log("calories to save = ",$("#calories_input-" + id).val())    // added
  if ((id != "today") & (id != "tomorrow")) {
    api_update_meal({'id':id, food:$("#food_input-" + id).val(), amount:$("#amount_input-" + id).val(), calories:$("#calories_input-" + id).val()},
                    function(result) { 
                      console.log(result);
                      get_current_meals();
                      $("#current_food_input").val("")
                    } );
  } else {
    api_create_meal({food:$("#food_input-" + id).val(), amount:$("#amount_input-" + id).val(), calories:$("#calories_input-" + id).val(), list:id},
                    function(result) { 
                      console.log(result);
                      get_current_meals();
                      $("#current_food_input").val("")
                    } );
  }
}
function undo_food_edit(event) {
  id = event.target.id.replace("undo_food_edit-","")
  console.log("undo",[id])
  $("#food_input-" + id).val("");
  $("#amount_input-" + id).val("");    // added
  $("#calories_input-" + id).val("");    // added
  if ((id != "today") & (id != "tomorrow")) {
    // hide the editor
    $("#amount_editor-"+id).prop('hidden', true);    // added
    $("#calories_editor-"+id).prop('hidden', true);    // added
    $("#editor-"+id).prop('hidden', true);
    $("#save_food_edit-"+id).prop('hidden', true);
    $("#undo_food_edit-"+id).prop('hidden', true);
    // show the text display
    $("#move_meal-"+id).prop('hidden', false);
    $("#amount-"+id).prop('hidden', false);
    $("#calories-"+id).prop('hidden', false);
    $("#food-"+id).prop('hidden', false);
    $("#filler-"+id).prop('hidden', false);
    $("#edit_meal-"+id).prop('hidden', false);
    $("#delete_meal-"+id).prop('hidden', false);
  }
  // set the editing flag
  $("#current_food_input").val("")
}
function delete_meal(event) {
  if ($("#current_food_input").val() != "") { return }
  console.log("delete item", event.target.id )
  id = event.target.id.replace("delete_meal-","");
  api_delete_meal({'id':id},
                  function(result) { 
                    console.log(result);
                    get_current_meals();
                  } );
}
function display_meal(x) {
  arrow = (x.list == "today") ? "arrow_forward" : "arrow_back";
  completed = x.completed ? " completed" : "";
  if ((x.id == "today") | (x.id == "tomorrow")) {
    t = '<tr id="meal-'+x.id+'" class="meal">' +
        '  <td style="width:36px"></td>' +  
        '  <td><span id="amount_editor-'+x.id+'">' + 
        '        <input id="amount_input-'+x.id+'" style="height:22px" class="w3-input" '+ 
        '          type="text" autofocus placeholder="Amount..."/>'+
        '      </span>' + 
        '  </td>' +
        '  <td><span id="editor-'+x.id+'">' + 
        '        <input id="food_input-'+x.id+'" style="height:22px" class="w3-input" '+ 
        '          type="text" autofocus placeholder="Food..."/>'+
        '      </span>' + 
        '  </td>' +
        '  <td><span id="calories_editor-'+x.id+'">' + 
        '        <input id="calories_input-'+x.id+'" style="height:22px" class="w3-input" '+ 
        '          type="number" autofocus placeholder="# of Calories..."/>'+
        '      </span>' + 
        '  </td>' +
        '  <td style="width:72px">' +
        '    <span id="filler-'+x.id+'" class="material-icons">more_horiz</span>' + 
        '    <span id="save_food_edit-'+x.id+'" hidden class="save_food_edit material-icons">done</span>' + 
        '    <span id="undo_food_edit-'+x.id+'" hidden class="undo_food_edit material-icons">cancel</span>' +
        '  </td>' +
        '</tr>';
  } else {
    t = '<tr id="meal-'+x.id+'" class="meal">' + 
        '  <td><span id="move_meal-'+x.id+'" class="move_meal '+x.list+' material-icons">' + arrow + '</span></td>' +
        '  <td><span id="amount-'+x.id+'" class="amount' + completed + '">' + x.amount + '</span>' + 
        '      <span id="amount_editor-'+x.id+'" hidden>' + 
        '        <input id="amount_input-'+x.id+'" style="height:22px" class="w3-input" type="text" autofocus/>' +
        '      </span>' + 
        '  </td>' +
        '  <td><span id="food-'+x.id+'" class="food' + completed + '">' + x.food + '</span>' + 
        '      <span id="editor-'+x.id+'" hidden>' + 
        '        <input id="food_input-'+x.id+'" style="height:22px" class="w3-input" type="text" autofocus/>' +
        '      </span>' + 
        '  </td>' +
        '  <td><span id="calories-'+x.id+'" class="calories' + completed + '">' + x.calories + '</span>' + 
        '      <span id="calories_editor-'+x.id+'" hidden>' + 
        '        <input id="calories_input-'+x.id+'" style="height:22px" class="w3-input" type="number" autofocus/>' +
        '      </span>' + 
        '  </td>' +
        '  <td>' +
        '    <span id="edit_meal-'+x.id+'" class="edit_meal '+x.list+' material-icons">edit</span>' +
        '    <span id="delete_meal-'+x.id+'" class="delete_meal material-icons">delete</span>' +
        '    <span id="save_food_edit-'+x.id+'" hidden class="save_food_edit material-icons">done</span>' + 
        '    <span id="undo_food_edit-'+x.id+'" hidden class="undo_food_edit material-icons">cancel</span>' +
        '  </td>' +
        '</tr>';
  }
  $("#meal-list-" + x.list).append(t);
  $("#current_food_input").val("")
}
function get_current_meals() {
  // remove the old meals
  $(".meal").remove();
  // display the new meal editor
  display_meal({id:"today", list:"today"})
  display_meal({id:"tomorrow", list:"tomorrow"})
  // display the meals
  api_get_meals(function(result){
    for (const meal of result.meals) {
      display_meal(meal);
    }
    // wire the response events 
    $(".move_meal").click(move_meal);
    $(".food").click(complete_meal_food)
    $(".amount").click(complete_meal_amount)
    $(".calories").click(complete_meal_calories)
    $(".edit_meal").click(edit_meal);
    $(".save_food_edit").click(save_food_edit);
    $(".undo_food_edit").click(undo_food_edit);
    $(".delete_meal").click(delete_meal);
    // set all inputs to set flag
    $("input").keypress(input_keypress);
  });
}
$(document).ready(function() {
  get_current_meals()
});
</script>
% include("footer.tpl")
