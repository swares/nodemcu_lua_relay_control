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
    </head>
    <body>
      <h1>Greenhouse Control</h1>
      <div id="page">
        <div id="maincontent">
            <div id="statuscontent">Status</div>
            <div id="controlcontent">
                           <p>Switch Control</p>
                       <p>GPIO0 - InLed <form style="display: inline" action="#controlcontent?pin=ON0" method="get"><button>On</button></form>&nbsp;<form style="display: inline" action="#controlcontent?pin=OFF0" method="get"><button>Off</button></form>
                       <p>GPIO1 - Water <form style="display: inline" action="#controlcontent?pin=ON1" method="get"><button>On</button></form>&nbsp;<form style="display: inline" action="#controlcontent?pin=OFF1" method="get"><button>Off</button></form>
                       <p>GPIO2 - Light <form style="display: inline" action="#controlcontent?pin=ON2" method="get"><button>On</button></form>&nbsp;<form style="display: inline" action="#controlcontent?pin=OFF2" method="get"><button>Off</button></form>
                       <p>GPIO3 - Alarm <form style="display: inline" action="#controlcontent?pin=ON3" method="get"><button>On</button></form>&nbsp;<form style="display: inline" action="#controlcontent?pin=OFF3" method="get"><button>Off</button></form>
                       <p>GPIO4 - Music <form style="display: inline" action="#controlcontent?pin=ON4" method="get"><button>On</button></form>&nbsp;<form style="display: inline" action="#controlcontent?pin=OFF4" method="get"><button>Off</button></form>
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
led4 = 7
gpio.mode(led0, gpio.OUTPUT)
gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)
gpio.mode(led3, gpio.OUTPUT)
gpio.mode(led4, gpio.OUTPUT)
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
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
        buf = buf.."<!doctype html><title>Greenhouse Control</title><h1>Greenhouse Control</h1>";
        buf = buf.."<p>GPIO0 <a href=\"?pin=ON0\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF0\"><button>OFF</button></a></p>";
        buf = buf.."<p>GPIO1 <a href=\"?pin=ON1\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF1\"><button>OFF</button></a></p>";
        buf = buf.."<p>GPIO2 <a href=\"?pin=ON2\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF2\"><button>OFF</button></a></p>";
        buf = buf.."<p>GPIO3 <a href=\"?pin=ON3\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF3\"><button>OFF</button></a></p>";
        buf = buf.."<p>GPIO4 <a href=\"?pin=ON4\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF4\"><button>OFF</button></a></p>";
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
        elseif(_GET.pin == "ON4")then
              gpio.write(led4, gpio.HIGH);
        elseif(_GET.pin == "OFF4")then
              gpio.write(led4, gpio.LOW);
        end
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
