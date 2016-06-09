function motion()
  print("Motion Detection : ON!") 
  stat = "ON" 
  gpio.write(outpin,gpio.HIGH)  -- Led ON - Motion detected
  gpio.trig(6,"down",nomotion)  -- trigger on falling edge
  return stat
end
function nomotion()
  print("Motion Detection : OFF!") 
  stat = "OFF" 
  gpio.write(outpin,gpio.LOW)   -- Led OFF 
  gpio.trig(6,"up",motion)  -- trigger on rising edge
  return stat
end
gpio.trig(6,"up",motion)
