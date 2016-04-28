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
		end

		if file.open(fn, t)~=nil then
			if file.write(d)~=nil then
				file.close()
				return true
			else
				print("Error writing file: "..fn)
				return false
			end
		else
			print("Error opening file: "..fn)
			return false
		end
	else
		return false
	end
end

function openTemplate(sck, fn, sentCallback)
	if not file.open(fn, "r") then
		print('File not found: '..fn)
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

function tes(text, sentCallback)
	chunk = 512
	if string.len(text) > chunk then
		sck:send(string.sub(text, 1, chunk), tes(string.sub(text, chunk)))
	else
		print(text)
	end
end
	

end
