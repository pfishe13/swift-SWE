% include("header.tpl")
% include("banner.tpl")

<style>
.collapsible {
  cursor: pointer;
  padding: 20px;
  width: 100%;
  text-align: left;
  font-size: 15px;
}
.active, .collapsible:hover {
  background-color: black;
  color: white;
  cursor: pointer;
}
.content {
  padding: 18px;
  padding-bottom: 30px;
  display: none;
  overflow: hidden;
  color = white;
}
div.resources {
    text-indent: 50px;
}
a:link{
  color: white;
  cursor: pointer;
  text-decoration: none;
}
a:hover{
    color: blue;
    cursor: pointer;
}
</style>
<div class="resources">
<h2>Resource Catagories:</h2>
</div">
<button type="button" class="collapsible">Shoulder</button>
<div class="content">
  <p><a href="https://youtu.be/rL6b6LDJK5w"> Lateral Raise </a> </p>
  <p><a href="https://youtu.be/Vm1oShjeCAc"> Front Raise </a> </p>
  <p><a href="https://youtu.be/UBoMrEff-vM"> Bent Over Lateral Raise </a> </p>
  <p><a href="https://youtu.be/_Yb_exS0iaI"> Military Press </a> </p>
  <p><a href="https://youtu.be/_Yb_exS0iaI"> Dumbbell Shoulder Press </a> </p>
  <p><a href="https://youtu.be/JmMIYI-GV0I"> Shoulder Shrug </a> </p>
</div>
<button type="button" class="collapsible">Chest</button>
<div class="content">
  <p> </p>
</div>
<button type="button" class="collapsible">Back</button>
<div class="content">
  <p> </p>
</div>
<button type="button" class="collapsible">Arms</button>
<div class="content">
  <p> </p>
</div>
<button type="button" class="collapsible">Abdominal</button>
<div class="content">
  <p> </p>
</div>
<button type="button" class="collapsible">Legs</button>
<div class="content">
  <p> </p>
</div>
<script>
var coll = document.getElementsByClassName("collapsible");
var i;
for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var content = this.nextElementSibling;
    if (content.style.display === "block") {
      content.style.display = "none";
    } else {
      content.style.display = "block";
    }
  });
}
</script>
% include("footer.tpl")
