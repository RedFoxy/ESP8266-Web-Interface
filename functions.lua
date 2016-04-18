-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
function tprint (tbl, indent)
	if not indent then indent = 0 end
	for k, v in pairs(tbl) do
		formatting = string.rep("  ", indent)..k..": "
		if type(v) == "table" then
			print(formatting)
			tprint(v, indent+1)
		elseif type(v) == 'boolean' then
			print(formatting..tostring(v))
		else
			print(formatting..v)
		end
	end
end

function savestate()
	local x=''
	for i, act in ipairs(led) do
		x=x.."["..i.."] = {"
			.."name = '"..act.name.."', "
			.."pin = "..act.pin..", "
			.."status = "..act.status
			.."},\n";
	end
	fwrite("state.lua", "led = {\n"..x.."}\n")
	collectgarbage();
end

function fwrite(fn, d, t)
	if(d~=nil and fn~=nil) then
		if (t==nil) or (t=="a" and file.exists(fn)==false) then
			t='w+'
--			print("Crea/Sovrascrivi file: "..t)
		end

		if file.open(fn, t)~=nil then
			if file.write(d)~=nil then
--print("file scritto correttamente: "..fn)
				file.close()
				return true
			else
				print("Errore scrittura file: "..fn)
				return false
			end
		else
			print("Errore apertura file: "..fn)
			return false
		end
	else
		return false
	end
end

function Sendfile(sck, fn, sentCallback, d)
	if not file.open(fn, "r") then
		print('File HTML non trovato: '..fn)
		if sentCallback then
			sentCallback()
		else
			sck:close()
		end
		return
	end
	local function sendChunk()
		local line = file.read(512)
		if line then 
			sck:send(line, sendChunk) 
		else
			file.close()
			if d==true then
				file.remove(fn)
			end
			collectgarbage()
			if sentCallback then
				sentCallback()
			else
				sck:close()
			end
		end
	end
	sendChunk()
end
