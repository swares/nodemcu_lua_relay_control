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

