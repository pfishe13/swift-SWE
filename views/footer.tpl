<!DOCTYPE html>
<html lang="en">

<head>
<style>
#footer { 
 bottom: 0;
 position: fixed;
 left: 0;
 right: 0;
 margin: 25px 500px 25px;
}
</style>
</head>

<div class="w3-row">
  <div id="footer" class="w3-panel w3-card-4 w3-round-xlarge" style="background-color:#1b1b2a; color:#b1b7ba;">
    <div>
      <h1><i><span id="clockbox"  style="font:20pt; color:#b1b7ba ;"></i></h1>
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
    </div>
  </div>
</div>



</html>
