if cfg.wifi.mode ~=nil then
	if cfg.wifi.mode == "client" then
		wifi.setmode(wifi.STATION)

		if (cfg.wifi.ssid ~=nil and cfg.wifi.pwd ~= nil) then
			wifi.sta.config(cfg.wifi.ssid, cfg.wifi.pwd)

			wifi.sta.connect()
			if cfg.net.ip ~= nil and cfg.net.netmask ~= nil and cfg.net.gateway then
				wifi.sta.setip(cfg.net)
				cfg.wifi.ok = true
			else
				local cnt = 0
				tmr.alarm(3, 1000, 1, function() 
					if (wifi.sta.getip() == nil) and (cnt < 20) then 
						print("Trying Connect to Router, Waiting...")
						cnt = cnt + 1 
					else 
						tmr.stop(3)
						if (cnt < 20) then
							cfg.wifi.ok = true
						else
							cfg.wifi.ok = false
							print("Wifi setup time more than 20s, Please verify wifi.sta.config() function. Then re-download the file.")
						end
						cnt = nil;
						collectgarbage();
					end 
				end)
			end
		end
		if cfg.wifi.ok then
			print("IP : "..wifi.sta.getip().."\nMAC: "..wifi.sta.getmac());
		end
	end
--		print("MAC:"..wifi.ap.getmac().."\r\nIP:"..wifi.ap.getip());
end