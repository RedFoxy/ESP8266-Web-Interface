-- v0.0.3
print("Lettura file di configurazione")
dofile("config.lua")

print("Caricamento delle funzioni globali")
dofile("functions.lua")

print("Connessione alla rete")
dofile("network.lua")

if file.exists("state.lua") then
	dofile("state.lua")
else 
	led = {
		[1] = {name = 'GPIO16', pin = 0,	status = 0},
		[2] = {name = 'GPIO5',	pin = 1,	status = 0},
		[3] = {name = 'GPIO4',	pin = 2,	status = 0},
		[4] = {name = 'GPIO0',	pin = 3,	status = 0},
		[5] = {name = 'GPIO2',	pin = 4,	status = 0},
		[6] = {name = 'GPIO14', pin = 5,	status = 0},
		[7] = {name = 'GPIO12', pin = 6,	status = 0},
		[8] = {name = 'GPIO13', pin = 7,	status = 0},
		[9] = {name = 'GPIO15', pin = 8,	status = 0},
--		[10]= {name = 'GPIO3',	pin = 9,	status = 0},
--		[11]= {name = 'GPIO1',	pin = 10, status = 0}
	}
end

for i, act in ipairs(led) do
	gpio.mode(act.pin, gpio.OUTPUT)
	if (act.status == 1) then
		gpio.write(act.pin, gpio.HIGH)
	else
		gpio.write(act.pin, gpio.LOW)
	end
end

srv=net.createServer(net.TCP)

srv:listen(80,function(conn)
	conn:on("receive", function(sck,request)
		local clientip, clientport = sck:getpeer()
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

		if vars~=nil then
			print(clientip.." - Path: "..path.." - Vars: "..vars)
		else
			print(clientip.." - Path: "..path)
		end

		if (vars~=nil) then
			if (_GET.id~=nil) then
				id=tonumber(_GET.id)
			end
		end

		if path == '/status' then
			local ff = '{'
			for i, act in ipairs(led) do
				ff = ff..'"'..i..'": '..act.status..', '
			end
				sck:send(cfg.web.ok200..
					string.sub(ff,1,-3)..'}')
			sck:close()

		elseif path == '/on' then
			if id~=nil then
				gpio.write(led[id]['pin'], gpio.HIGH)
				led[id]['status'] = 1
				savestate()
				sck:send(cfg.web.ok200..'{"status": "success", "value": '..led[id]['status']..'}')
			else
				sck:send(cfg.web.ok200..'{"status": "error", "msg": "id pin not valid"}')
			end
			sck:close()

		elseif path == '/off' then
			if id~=nil then
				gpio.write(led[id]['pin'], gpio.LOW)
				led[id]['status'] = 0
				savestate()
				sck:send(cfg.web.ok200..'{"status": "success", "value": '..led[id]['status']..'}')
			else
				sck:send(cfg.web.ok200..'{"status": "error", "msg": "id pin not valid"}')
			end
			sck:close()

		elseif path == '/toggle' then
			if id~=nil then
				if led[id]['status'] == 1 then
					gpio.write(led[id]['pin'], gpio.LOW)
					led[id]['status'] = 0
				else
					gpio.write(led[id]['pin'], gpio.HIGH)
					led[id]['status'] = 1
				end
				savestate()
				sck:send(cfg.web.ok200..'{"status": "success", "value": '..led[id]['status']..'}')
			else
				sck:send(cfg.web.ok200..'{"status": "error", "msg": "id pin not valid"}')
			end
			sck:close()

		elseif path == '/' or path == '/wifi' or path == '/pref' then
			dofile('dashboard.lua')
			dashboard(sck)
		else
			sck:send(cfg.web.ko404)
			sck:close();
		end
		collectgarbage();
	end)
end)