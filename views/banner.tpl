<div class="w3-container w3-topbar w3-leftbar w3-rightbar w3-border-white w3-black">
<span class="w3-xxxlarge w3-margin"><b>Taskbook</b></span>
<div id="clockbox"  style="font:30pt Brush Script MT; color:#FF0000; text-align:right;"></div>

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
<meta charset="utf-8">
  <style>
    body {background-color: white}
    body.dark {background-color: #222; color: #e6e6e6}
    button {class="w3-large w3-button w3-margin w3-round-large w3-blue}
    body.dark button {background-color: #222; color: white}
  </style>
</head>
<body>
<span class="w3-right">
<button id="darkbutton"  class="w3-large w3-button w3-margin w3-round-large w3-blue">Dark Mode</button>
    <a href="/overview"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Overview</span></a>
    <a href="/tasks"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Today</span></a>
    <a href="/calories"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Calories</span></a>
    <a href="/register"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Sign up</span></a>
    <a href="/login"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Log In</span></a>
</span>
<script>
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

