# nodemcu_lua_relay_control
Simple Relay Controler ESP8266

Nodemcu Lua $6

        Switches $2
        1 - Lights
        2 - Misters
        3 - Alarm ( turn on - siren / rgb lights / mister / music ) - using pir sensor inside ) $2
        4 - Music

        ADS1115 4 Channel 16 Bit I2C ADC Module with Pro Gain Amplifier $3
        7x Soil Moisture Sensors $6
        1x Light Intensity Sensor $1
        1x UV Intensity Sensor $9
        1x Air Humidity / Temperature Sensor DHT-11 $1.33
        
        pir motion sensor
        ultrasonic sensor $1.50
        2x sharp GP2Y0A02YK0F Analog Distance Sensor 20-150cm or other longer range model
        siren $3

        3.3v stepdown power converter $1
        12v DC power adapter
        Water Control valve $8
        5x 3/4 in. x 10 ft. PVC Schedule 40 Plain-End Pipe $2.86/ea $14.30
        http://www.homedepot.com/p/JM-eagle-3-4-in-x-10-ft-PVC-Schedule-40-Plain-End-Pipe-57471/202280935
        2 x HML 5M 30W 300 x SMD 3528 Water Resistant Flexible RGB LED Strip Light w/ 24 Keys Remote Controller  -  RGB COLOR
        Power strip $16
       
        5x 3/4" PVC Electrical Conduit 10' $2.17/ea = $10.85  + connectors .28/ea $1.12
        http://www.homedepot.com/p/JM-eagle-3-4-in-x-10-ft-PVC-Schedule-40-Conduit-67454/100129197
        50 ft. 14-3 Grey Solid UF-B W/G Cable $35.57
        http://www.homedepot.com/p/Southwire-50-ft-14-3-Grey-Solid-UF-B-W-G-Cable-13057522/206316936
        
        plus tax
        $50 to run elecrical
        $60 lights / water / control
        
        $110 lights/water/controler to greenhouse + tax
        
        
        brd1 - bmp180 - air pressure and temperature
        brd1 - DS3231 - AT24C32 IIC module precision Real time clock quare memory
        brd1 - wifi
        brd1 - httpd             - LED
        brd1 - httpd / switch #1 - Mister
        brd1 - httpd / switch #2 - Alarm
        brd1 - httpd / switch #3 - Lights
        brd1 - httpd / switch #4 - Music
        brd1 - ext1 - HC-SR501 - Infrared PIR Motion Sensor 
        brd1 - ext2 - HC-SR04 - Ultrasonic Range Sensor (door open?, someone in center of gh?)
        
        brd1 - brd2 - ads1115 - 2x i2c 4-channel 15bit analog multiplexer
        brd1 - brd2 - ads1115-1 - ext1 - Soil Moisture Sensor #1
        brd1 - brd2 - ads1115-1 - ext2 - Soil Moisture Sensor #2 
        brd1 - brd2 - ads1115-1 - ext3 - Soil Moisture Sensor #3
        brd1 - brd2 - ads1115-1 - ext4 - Soil Moisture Sensor #4
        brd1 - brd2 - ads1115-2 - ext1 - Soil Moisture Sensor #5
        brd1 - brd2 - ads1115-2 - ext2 - Soil Moisture Sensor #6 
        brd1 - brd2 - ads1115-2 - ext3 - Light Intensity Sensor
        brd1 - brd2 - ads1115-2 - ext4 - UV Light Intensity Sensor

        
# notes for enhanced webpage layout (even better if used with ajax)

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
		//]]> 
		</script>
		</body>
		</html>
		]]

                // Status Page Data
                <p>Temperature, Air: </p>
                <p>Humidity, Air: </p>
                <p>Humidity, Soil - 1:   2:  3:  4:  5: </p>
                <p>Light Level</p>
                <p>UV Level</p>
                <p>Led 0</p>
                <p>Switch - 1:   2:   3:   4:  </p>
                
                
