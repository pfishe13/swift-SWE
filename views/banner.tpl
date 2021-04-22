<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-colors-2021.css">
  <style>
    body {background-color: white}
    body.dark {background-color: #222; color: #e6e6e6}
    button {class="w3-large w3-button w3-margin w3-round-large w3-blue}
    body.dark button {background-color: #222; color: white}
     button{
  display: inline-block;
  margin: 0;
}
  </style>
</head>
<body>
<div  class="w3-sidebar w3-bar-block w3-black w3-card w3-animate-top " style="display:none" id="mySidebar">
  <button class="w3-bar-item w3-button w3-large"
  onclick="w3_close()">Close &times;</button>
    <a href="/overview"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Overview</span></a>
    <a href="/tasks"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Schedule</span></a>
    <a href="/meals"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Meals</span></a>
    <a href="/resources"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Resources</span></a>
    <a href="/login"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">SignUp</span></a>
    <a href="/register"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Login</span></a>
    <button id="darkbutton"  class="w3-large w3-button w3-margin w3-round-large w3-blue ">Dark Mode</button>
</div>
<div id="main">
<div class="w3-container  w3-black">
    <button id="openNav" class="w3-button w3-xxxlarge w3-black w3-round-large " onclick="w3_open()">&#8962;</button>
    <img src="https://user-images.githubusercontent.com/76025363/110568108-84b01180-8120-11eb-95ad-265a8e3bc052.png" width="275" height="147">
    <!-- <span class="w3-xxxlarge " style="font: Arial; color:#ffffff ; text-align:left;"><b>Taskbook</b><span> -->
     <span class="w3-right" id="clockbox"  style="font:20pt Arial; color:#ffffff ; text-align:right;">
<script type="text/javascript">
var tday=["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
var tmonth=["January","February","March","April","May","June","July","August","September","October","November","December"];
function GetClock(){
var d=new Date();
var nday=d.getDay(),nmonth=d.getMonth(),ndate=d.getDate(),nyear=d.getFullYear();
var nhour=d.getHours(),nmin=d.getMinutes(),nsec=d.getSeconds(),ap;
if(nhour==0){ap=" AM";nhour=12;}
else if(nhour<12){ap=" AM";}
else if(nhour==12){ap=" PM";}
else if(nhour>12){ap=" PM";nhour-=12;}
if(nmin<=9) nmin="0"+nmin;
if(nsec<=9) nsec="0"+nsec;
var clocktext=""+tday[nday]+", "+tmonth[nmonth]+" "+ndate+", "+nyear+" "+nhour+":"+nmin+":"+nsec+ap+"";
document.getElementById("clockbox").innerHTML=clocktext;
}
GetClock();
setInterval(GetClock,1000);
</script>
  </span>
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
