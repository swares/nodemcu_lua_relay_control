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
-- pins

-- config / start httpd server
led0 = 3 // program to internal led
led1 = 4
led2 = 5
led3 = 6
led4 = 7

-- ADS1115 ADC
-- Requirements
bit = require("bit")

-- Global variable for i2c
SDA                                 = 2
SCL                                 = 3

-- Global variable for ADS1115
ADDR                                = 0x48

ADS1115_CONVERTIONDELAY             = 8


--- DHT11
-- Measure temperature, humidity and post data to thingspeak.com
-- 2014 OK1CDJ
-- DHT11 code is from esp8266.com
---Sensor DHT11 is conntected to GPIO0
pin = 3
-- GPIO0 = 3 GPIO2 = 4

Humidity = 0
HumidityDec=0
Temperature = 0
TemperatureDec=0
Checksum = 0
ChecksumTest=0
