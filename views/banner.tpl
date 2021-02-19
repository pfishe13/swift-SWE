<div class="w3-container w3-topbar w3-leftbar w3-rightbar w3-border-white w3-black">
<span class="w3-xxxlarge w3-margin"><b>Taskbook</b></span>
<meta charset="utf-8">
  <style>
    body {background-color: white}
    body.dark {background-color: #222; color: #e6e6e6}
    button {class="w3-large w3-button w3-margin w3-round-large w3-blue}
    body.dark button {background-color: #222; color: white}
  </style>
</head>
<body>
<button id="darkbutton"  class="w3-large w3-button w3-margin w3-round-large w3-blue">Dark Mode</button>
    <a href="/overview"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Overview</span></a>
    <a href="/tasks"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Today</span></a>
    <a href="/calories"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Calories</span></a>
    <a href="/register"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Sign up</span></a>
    <a href="/login"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Log In</span></a>
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


<!--
<div class="w3-container w3-black">
  <span class="w3-xxxlarge w3-margin"><b>Taskbook</b></span>
  <span class="w3-right">
  <meta charset="UTF-8">
    <meta name="viewport" content=
        "width=device-width, initial-scale=1.0">
    <title>Dark Mode</title>
    <style>
        body{
        padding:0% 3% 10% 3%;
        text-align:center;
        }
        h1{
        color: #32a852;
        margin-top:30px;
        }
        button{
            cursor: pointer;
            border: 1px solid #555;
            text-align: center;
            padding: 5px;
            margin-left: 8px;
        }
        .dark{
            background-color: #222;
            color: #e6e6e6;
        }
    </style>
    <button onclick="myFunction()" class="w3-large w3-button w3-margin w3-round-large w3-blue">Dark Mode</button>
    
    <script>
        function myFunction() {
        var element = document.body;
        element.classList.toggle("dark");
        }
         button{
            cursor: pointer;
            border: 1px solid #555;
            text-align: center;
            padding: 5px;
            margin-left: 8px;
        }
        .dark{
            background-color: #222;
            color: #e6e6e6;
        }
    </script>
    <script>
        function myFunction() {
        var element = document.body;
        element.classList.toggle("dark");
        }
    </script>
    <a href="/overview"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Overview</span></a>
    <a href="/tasks"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Today</span></a>
    <a href="/calories"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Calories</span></a>
    <a href="/register"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Sign up</span></a>
    <a href="/login"><span class="w3-large w3-button w3-margin w3-round-large w3-blue">Log In</span></a>
    <span class="w3-large w3-button w3-margin w3-round-large w3-blue">Log Out</span>
    <!-- <span class="w3-large w3-button w3-margin w3-round-large w3-blue">Dark Mode</span> -->
  </span>
</div>
-->

