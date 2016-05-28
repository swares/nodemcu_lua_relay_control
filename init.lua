/* I'll start with this super simple example and improve it
  To control our garden misting system.
*/

/* -- Define Web Pages --
  const char web_http200[]    PROGMEM  = { "HTTP/1.1 200 OK\nContent-Type: text/html\nConnection: keep-alive\n\n" };
  const char web_http404[]    PROGMEM  = { "HTTP/1.1 404 Error\nContent-Type: text/html\nConnection: keep-alive\n\n" };
  html index and error pages   
  const char web_error[]      PROGMEM  = { "<!DOCTYPE html><title>Greenhouse Control Station - Error</title><h1>Environmental Monitoring Station - Error</h1><p id='error_txt'>Some Error Occured</p>" };
  const char web_index_ajax[] PROGMEM  = { "<!DOCTYPE html><title>Greenhouse Control Station - Index</title><script>function GetSwitchState() {nocache = '&nocache=' + Math.random() * 1000000;var request = new XMLHttpRequest();request.onreadystatechange = function() {if (this.readyState == 4) {if (this.status == 200) {if (this.responseText != null) {document.getElementById('switch_txt'.innerHTML = this.responseText;}}}};request.open('GET', 'ajax_switch' + nocache, true);request.send(null);setTimeout('GetSwitchState()', 1000);}</script><body onload='GetSwitchState()'><h1>Environmental Monitoring Station</h1><p id='switch_txt'>Switch state: Not requested...</p>" };
*/

-- Configure Wireless Internet
print('\nGreenhouse Control\n')
wifi.setmode(wifi.STATION)
print('set mode=STATION (mode='..wifi.getmode()..')\n')
print('MAC Address: ',wifi.sta.getmac())
print('Chip ID: ',node.chipid())
print('Heap Size: ',node.heap(),'\n')
-- wifi config start
wifi.sta.config('Linksys',"YOUR_NETWORK_PASSWORD")
-- wifi config end

-- wifi connect start
tmr.alarm(0, 1000, 1, function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...\n")
   else
      ip, nm, gw=wifi.sta.getip()
      print("IP Info: \nIP Address: ",ip)
      print("Netmask: ",nm)
      print("Gateway Addr: ",gw,'\n')
      tmr.stop(0)
   end
end)
-- wifi connect end

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
