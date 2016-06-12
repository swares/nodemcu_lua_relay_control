# nodemcu_lua_relay_control
Simple Relay Controler ESP8266

Nodemcu Lua $6

        Switches $2
        1 - Lights
        2 - Misters
        3 - Alarm ( turn on - siren / rgb lights / mister / music ) - using pir sensor inside ) $2
        4 - 

        3x ADS1115 4 Channel 16 Bit I2C ADC Module with Pro Gain Amplifier $3
        7x Soil Moisture Sensors $6
        3x Rain Drops Sensors 
        1x Light Intensity Sensor $1
        1x UV Intensity Sensor $9
        1x Air Humidity / Temperature Sensor DHT-11 $1.33
        1x DS3231 RTC Only
        1x pir motion sensor
        1x siren $3

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
        
        1D - 1-Wire
        brd1 - dht22 - air humidity and temperature
        brd1 - wifi
        2D - I2C
        brd1 - DS3231 RTC Only
        4D - Digital
        brd1 - httpd / switch #1 - Mister
        brd1 - httpd / switch #2 - Alarm
        brd1 - httpd / switch #3 - Lights
        brd1 - httpd / switch #4 - 
        1D - Digital
        brd1 - ext1 - HC-SR501 - Infrared PIR Motion Sensor 
        1D - PWM
        brd1 - ext2 - HC-SR04 - Ultrasonic Range Sensor (door open?, someone in center of gh?)

        2D - I2C
        11d total  11d usable on brd
        brd1 - brd2 - ads1115 - 2x i2c 4-channel 15bit analog multiplexer
        brd1 - brd2 - ads1115-1 - ext1 - Light Intensity Sensor
        brd1 - brd2 - ads1115-1 - ext2 - UV Light Intensity Sensor
        brd1 - brd2 - ads1115-1 - ext3 - Soil Moisture Sensor #1
        brd1 - brd2 - ads1115-1 - ext4 - Soil Moisture Sensor #2 
        brd1 - brd2 - ads1115-2 - ext1 - Soil Moisture Sensor #3
        brd1 - brd2 - ads1115-2 - ext2 - Soil Moisture Sensor #4
        brd1 - brd2 - ads1115-2 - ext3 - Soil Moisture Sensor #5
        brd1 - brd2 - ads1115-2 - ext4 - Soil Moisture Sensor #6 
        brd1 - brd2 - ads1115-3 - ext1 - Soil Moisture Sensor #7
        brd1 - brd2 - ads1115-3 - ext2 - Rain Drops Sensor #1
        brd1 - brd2 - ads1115-3 - ext3 - Rain Drops Sensor #2
        brd1 - brd2 - ads1115-3 - ext4 - Rain Drops Sensor #3 

        # code / libs
        Nodemcu Lua / wifi
        use my wifi.lua
        ADS1115 4 Channel 16 Bit I2C ADC Module with Pro Gain Amplifier - analog read
        https://github.com/Hydhen/NodeMCU/blob/master/ADS1X15/ADS1115.lua
        - 7x Soil Moisture Sensors
        - 1x Light Intensity Sensor
        - 1x UV Intensity Sensor
        - 3x Rain Drops Sensors - analog read
        1x Air Humidity / Temperature Sensor DHT-11 - 1-wire?
        https://github.com/ok1cdj/ESP8266-LUA/blob/master/Thermometer-DHT11-Thingspeak/dht11.lua
        1x DS3231 RTC Only - I2c
        https://github.com/nodemcu/nodemcu-firmware/blob/master/lua_modules/ds3231/ds3231.lua
        1x pir motion sensor - digital read
