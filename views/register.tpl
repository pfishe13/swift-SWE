% include("header.tpl")
% include("banner.tpl")
<form action="/register-account">
    <label for="uname">Username:</label><br>
    <input type="text" id="uname" name="uname"><br>
    <label for="pword">Password:</label><br>
    <input type="password" id="pword" name="pword"><br>
    <label for="email">Email:</label><br>
    <input type="email" id="email" name="email">


    <input type="submit">
</form>
% include("footer.tpl")
