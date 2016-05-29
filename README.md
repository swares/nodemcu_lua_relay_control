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
        
# notes for enhanced webpage layout (even better if used with ajax)
        <!doctype html><title>Greenhouse Control</title><h1>Greenhouse Control</h1>
		<div id="page">
			<div id="maincontent">
				<div id="main">
                   Main
				</div>
				<div id="control">
				   <p>Switch Control</p>
                   <p>GPIO0 - InLed <a href=\"?pin=ON0\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF0\"><button>OFF</button></a></p>
                   <p>GPIO1 - Water <a href=\"?pin=ON1\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF1\"><button>OFF</button></a></p>
                   <p>GPIO2 - Light <a href=\"?pin=ON2\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF2\"><button>OFF</button></a></p>
                   <p>GPIO3 - Alarm <a href=\"?pin=ON3\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF3\"><button>OFF</button></a></p>
                   <p>GPIO4 - Music <a href=\"?pin=ON4\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF4\"><button>OFF</button></a></p>
				</div>
				<div id="music">
                   Music
				</div>
			</div>
			<div id="menuleftcontent">
				<ul id="menu">
					<li><a href="#main">Main</a></li>
					<li><a href="#control">Control</a></li>
					<li><a href="#music">Music</a></li>
				</ul>
			</div>
			<div id="clearingdiv"></div>
		</div>

		#page {
			margin-left: 200px;
		}
		#maincontent {
			float: right;
			width: 100%;
			background-color: #F0F0F0;
		}
		#menuleftcontent{
			float: left;
			width: 200px;
			margin-left: -200px;
			background-color: #CCCCCC;
		}
		#clearingdiv {
			clear: both;
		}

		$(function () {
			$("#maincontent > div:gt(0)").hide();
			$("#menu a").on("click", function (e) {
				var href = $(this).attr("href");
				$("#maincontent > " + href).show();
				$("#maincontent > :not(" + href + ")").hide();
			});
		});
