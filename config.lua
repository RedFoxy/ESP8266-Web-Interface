cfg = {
	['wifi'] = {},
	['net'] = {},
	['web'] = {},
}

cfg.wifi.ok		= false
cfg.wifi.mode	= "client"
cfg.wifi.ssid	= "SSID Name"
cfg.wifi.pwd	= "WiFi Password"

cfg.net.ip		= "192.168.1.119"
cfg.net.netmask	= "255.255.255.0"
cfg.net.gateway	= "192.168.1.1"
cfg.net.dns1	= "8.8.8.8"
cfg.net.dns2	= "8.8.8.8"
cfg.net.allowip	= ""

cfg.net.server	= "NodeMCU on ESP8266"

cfg.web.header	=	"\r\n"..
					"Server: "..cfg.net.server.."\r\n"..
--					"Date: Tue, 19 Apr 2016 12:14:37 GMT\r\n"..
					"Content-Type: text/html; charset=UTF-8\r\n"..
--					"Transfer-Encoding: chunked\r\n"..
--					"Connection: keep-alive\r\n"..
--					"Keep-Alive: timeout=2\r\n"..
					"\r\n";

cfg.web.ok200	=	"HTTP/1.1 200 OK"..cfg.web.header
cfg.web.ko404	=	"HTTP/1.1 404 Not Found"..cfg.web.header..
					"<html><head><title>404 Not Found</title></head>"..
					'<body bgcolor="white">'..
					"<center><h1>404 Not Found</h1></center>"..
					"<hr><center>"..cfg.net.server.."</center>"..
					"</body></html>";
