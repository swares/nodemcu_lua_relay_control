webpage = [[
    <!DOCTYPE html>
    <html>
    <head>
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <script type="text/javascript" src="//code.jquery.com/jquery-1.9.1.js"></script>
      <link rel="stylesheet" type="text/css" href="/css/result-light.css">
      <style type="text/css">
        body {
        font: small sans-serif;
    }
    #page {
        margin-left: 200px;
        background-color: #F0F0F0;
    }
    #maincontent {
        float: right;
        width: 100%;
    }
    #menuleftcontent {
        float: left;
        width: 200px;
        margin-left: -200px;
        background-color: #CCCCCC;
    }
    #clearingdiv {
        clear: both;
    }
      </style>
      <title>Greenhouse Control</title>
<script>function GetSwitchState() {
nocache = "&nocache=" + Math.random() * 1000000;
var request = new XMLHttpRequest();
request.onreadystatechange = function() {
if (this.readyState == 4) {
if (this.status == 200) {
if (this.responseText != null) {document.getElementById("statuscontent").innerHTML = this.responseText;}}}}
request.open("GET", "ajax_switch" + nocache, true);
request.send(null);
setTimeout('GetSwitchState()', 1000);
}</script>

    </head>
    <body>
      <h1>Greenhouse Control</h1>
      <div id="page">
        <div id="maincontent">
            <div id="statuscontent">Status</div>
            <div id="controlcontent">
                           <p>Switch Control</p>
                       <p>GPIO0 - Water <form style="display: inline" action="#controlcontent?pin=ON0" method="get"><button>On</button></form>&nbsp;<form style="display: inline" action="#controlcontent?pin=OFF0" method="get"><button>Off</button></form>
                       <p>GPIO1 - Light <form style="display: inline" action="#controlcontent?pin=ON1" method="get"><button>On</button></form>&nbsp;<form style="display: inline" action="#controlcontent?pin=OFF1" method="get"><button>Off</button></form>
                       <p>GPIO2 - Alarm <form style="display: inline" action="#controlcontent?pin=ON2" method="get"><button>On</button></form>&nbsp;<form style="display: inline" action="#controlcontent?pin=OFF2" method="get"><button>Off</button></form>
                       <p>GPIO3 - Music <form style="display: inline" action="#controlcontent?pin=ON3" method="get"><button>On</button></form>&nbsp;<form style="display: inline" action="#controlcontent?pin=OFF3" method="get"><button>Off</button></form>
            </div>
            <div id="musiccontent">Music</div>
        </div>
        <div id="menuleftcontent">
            <ul id="menu">
                <li><a href="#statuscontent">Status</a></li>
                <li><a href="#controlcontent">Control</a></li>
                <li><a href="#musiccontent">Music</a></li>
            </ul>
        </div>
        <div id="clearingdiv"></div>
    </div>
    <script type='text/javascript'>//<![CDATA[
    $(function () {
        $("#maincontent > div:gt(0)").hide();
        $("#menu a").on("click", function (e) {
            var href = $(this).attr("href");
            $("#maincontent > " + href).show();
            $("#maincontent > :not(" + href + ")").hide();
        });
    });
    //\]\]> 
    </script>
    </body>
    </html>
    ]]
-- config / start httpd server
led0 = 3 // program to internal led
led1 = 4
led2 = 5
led3 = 6
gpio.mode(led0, gpio.OUTPUT)
gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)
gpio.mode(led3, gpio.OUTPUT)
-- start server
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        -- process connectinn
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        -- handle switching, if selected
        local _on,_off = "",""
        if(_GET.pin == "ON0")then
              gpio.write(led0, gpio.HIGH);
        elseif(_GET.pin == "OFF0")then
              gpio.write(led0, gpio.LOW);
        elseif(_GET.pin == "ON1")then
              gpio.write(led1, gpio.HIGH);
        elseif(_GET.pin == "OFF1")then
              gpio.write(led1, gpio.LOW);
        elseif(_GET.pin == "ON2")then
              gpio.write(led2, gpio.HIGH);
        elseif(_GET.pin == "OFF2")then
              gpio.write(led2, gpio.LOW);
        elseif(_GET.pin == "ON3")then
              gpio.write(led3, gpio.HIGH);
        elseif(_GET.pin == "OFF3")then
              gpio.write(led3, gpio.LOW);
        end
        -- send webpage
        client:send(webpage);
        client:close();
        collectgarbage();
    end)
end)
