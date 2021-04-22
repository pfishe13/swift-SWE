% include("header.tpl")
% include("banner.tpl")

<style>
*, *::before, *::after {
  margin: 0;
  padding: 0;
  box-sizing: inherit;
}
 
.calculator {
  border: 1px solid #ccc;
  border-radius: 5px;
  position: absolute;
  right: 100px;
  width: 400px;
}
 
.output-screen {
  width: 100%;
  font-size: 5rem;
  height: 80px;
  border: none;
  background-color: gray;
  color: #fff;
  text-align: right;
  padding-right: 20px;
  padding-left: 10px;
  
}
 
button {
  height: 60px;
  background-color: #fff;
  border-radius: 3px;
  border: 1px solid #c4c4c4;
  background-color: transparent;
  font-size: 2rem;
  color: #333;
  background-image: linear-gradient(to bottom,transparent,transparent 50%,rgba(0,0,0,.04));
  box-shadow: inset 0 0 0 1px rgba(255,255,255,.05), inset 0 1px 0 0 rgba(255,255,255,.45), inset 0 -1px 0 0 rgba(255,255,255,.15), 0 1px 0 0 rgba(255,255,255,.15);
  text-shadow: 0 1px rgba(255,255,255,.4);
}
 
button:hover {
  background-color: #eaeaea;
}
 
.operator {
  color: #337cac;
}
 
.clear-value {
  background-color: green;
  border-color: #b0353a;
  color: #fff;
}
 
.clear-value:hover {
  background-color: #f17377;
}
 
.calculate-value {
  background-color: blue;
  border-color: #337cac;
  color: #fff;
  height: 100%;
  grid-area: 2 / 4 / 6 / 5;
}
 
.calculate-value:hover {
  background-color: #4e9ed4;
}
 
.display-keys {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-gap: 20px;
  padding: 20px;
}
  .save_food_edit, .undo_food_edit, .move_meal, .amount, .calories, .food, .edit_meal, .delete_meal {
    cursor: pointer;
  }
  .completed {text-decoration: line-through;}
  .food { padding-left:8px }
  .amount { padding-left:8px }
  .calories { padding-left:8px }
</style>

<div class="calculator">
<h1 style="text-align:center;">Calories calculator</h1>
        <input type="text" class="output-screen" value="" disabled />
        
        <div class="display-keys">
          
          <button  class="operator" value="+">+</button>
          <button  class="operator" value="-">-</button>
          <button  class="operator" value="*">&times;</button>
          <button  class="operator" value="/">&divide;</button>
      
          <button  value="7">7</button>
          <button  value="8">8</button>
          <button  value="9">9</button>
      
      
          <button  value="4">4</button>
          <button  value="5">5</button>
          <button  value="6">6</button>
      
      
          <button  value="1">1</button>
          <button  value="2">2</button>
          <button  value="3">3</button>
      
      
          <button  value="0">0</button>
          <button  class="decimal" value=".">.</button>
          <button  class="clear-value" value="clear-value">AC</button>
      
          <button  class="calculate-value operator" value="=">=</button>
      
        </div>
      </div>

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
const calculator = {
  outputValue: '0',
  firstValue: null,
  flagForSecondOperand: false,
  operator: null,
}; 
 
function inputDigit(digit) {
  const { outputValue, flagForSecondOperand } = calculator;
 
  if (flagForSecondOperand === true) {
    calculator.outputValue = digit;
    calculator.flagForSecondOperand = false;
  } else {
    calculator.outputValue = outputValue === '0' ? digit : outputValue + digit;
  }
}
 
function inputDecimal(dot) {
  if (calculator.flagForSecondOperand === true) return;
  
  // If the `outputValue` does not contain a decimal point
  if (!calculator.outputValue.includes(dot)) {
    // Append the decimal point
    calculator.outputValue += dot;
  }
}
 
function handleOperator(nextOperator) {
  const { firstValue, outputValue, operator } = calculator
  const inputValue = parseFloat(outputValue);
 
  if (operator && calculator.flagForSecondOperand)  {
    calculator.operator = nextOperator;
    return;
  }
 
  if (firstValue == null) {
    calculator.firstValue = inputValue;
  } else if (operator) {
    const currentValue = firstValue || 0;
    const result = performCalculation[operator](currentValue, inputValue);
 
    calculator.outputValue = String(result);
    calculator.firstValue = result;
  }
 
  calculator.flagForSecondOperand = true;
  calculator.operator = nextOperator;
}
 
const performCalculation = {
  '/': (firstValue, secondOperand) => (firstValue / secondOperand).toFixed(5),
 
  '*': (firstValue, secondOperand) => firstValue * secondOperand,
 
  '+': (firstValue, secondOperand) => firstValue + secondOperand,
 
  '-': (firstValue, secondOperand) => firstValue - secondOperand,
 
  '=': (firstValue, secondOperand) => secondOperand
};
 
function resetCalculator() {
  calculator.outputValue = '0';
  calculator.firstValue = null;
  calculator.flagForSecondOperand = false;
  calculator.operator = null;
}
 
function updateDisplay() {
  const display = document.querySelector('.output-screen');
  display.value = calculator.outputValue;
}
 
updateDisplay();
 
const keys = document.querySelector('.display-keys');
keys.addEventListener('click', (event) => {
  const { target } = event;
  if (!target.matches('button')) {
    return;
  }
 
  if (target.classList.contains('operator')) {
    handleOperator(target.value);
    updateDisplay();
    return;
  }
 
  if (target.classList.contains('decimal')) {
    inputDecimal(target.value);
    updateDisplay();
    return;
  }
 
  if (target.classList.contains('clear-value')) {
    resetCalculator();
    updateDisplay();
    return;
  }
 
  inputDigit(target.value);
  updateDisplay();
});
 
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
