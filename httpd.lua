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
