<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-colors-2021.css">
  
<style>
body {
  background-color: #d3d6de;
  font-family: 'Roboto';
}

button {
  class="w3-large w3-button w3-margin w3-round-large w3-blue" 
}

body.dark {
  background-color: #14141F;
  color: #e6e6e6
  font-family: 'Roboto';
}

body.dark button {
  background-color: #14141F;
  color: white;
}

button {
  display: inline-block;
  margin: 0;
}

.div-banner { background-color: #1b1b2a }

.w3-border-theme-dark-blue {border-color:#14141f !important}

</style>
</head>
<body>
<div  class="w3-sidebar w3-bar-block w3-card-4 w3-animate-top " style="display:none; background-color:#1b1b2a;" id="mySidebar">
  <button class="w3-bar-item w3-button w3-large"
  onclick="w3_close()">Close &times;</button>
    <a href="/overview"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Overview</span></a>
    <a href="/tasks"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Schedule</span></a>
    <a href="/meals"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Meals</span></a>
    <a href="/resources"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Resources</span></a>
    <a href="/login"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">SignUp</span></a>
    <a href="/register"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Login</span></a>
    <button id="darkbutton"  style="height:43px" class="w3-large w3-button w3-margin w3-round-large w3-blue ">Dark Mode</button>
</div>
<div id="main">
<div class="div-banner">
    <button id="openNav" class="w3-button w3-margin w3-xxxlarge w3-round-large w3-hover-green" onclick="w3_open()">&#8962;</button>
    <img src="https://github.com/moha-ali001/software-engineering-proj/blob/main/views/swift_logo_v1.png?raw=true" width="275" height="147">
    <!-- <span class="w3-xxxlarge " style="font: Arial; color:#ffffff ; text-align:left;"><b>Taskbook</b><span> -->
</div>
<script>
function w3_open() {
  document.getElementById("main").style.marginLeft = "25%";
  document.getElementById("mySidebar").style.width = "25%";
  document.getElementById("mySidebar").style.display = "block";
  document.getElementById("openNav").style.display = 'none';
}
function w3_close() {
  document.getElementById("main").style.marginLeft = "0%";
  document.getElementById("mySidebar").style.display = "none";
  document.getElementById("openNav").style.display = "inline-block";
}
</script>
</span>
<script>
/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
function myFunction() {
  document.getElementById("myDropdown").classList.toggle("show");
}
// Close the dropdown if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
const body = document.querySelector('body');
const button = document.querySelector('#darkbutton');
function toggleDark() {
  if (body.classList.contains('dark')) {
    body.classList.remove('dark');
    localStorage.setItem("theme", "light");
    button.innerHTML = "Dark Mode";
  } else {
    body.classList.add('dark');
    localStorage.setItem("theme", "dark");
    button.innerHTML = "Dark Mode";
  }
}
if (localStorage.getItem("theme") === "dark") {
  body.classList.add('dark');
  button.innerHTML = "Dark Mode";
}
document.querySelector('#darkbutton').addEventListener('click', toggleDark);
</script>
</div>
