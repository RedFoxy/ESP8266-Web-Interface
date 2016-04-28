function dashboard(sck)
	math.randomseed( tonumber(tostring(tmr.now()):reverse():sub(1,6)) )
	math.random(); math.random(); math.random();
	page_name="temp_"..math.random()..".htm"

	fwrite(page_name,
	'<div class="row">\n'..
	'	<div class="col-lg-12">\n'..
	'		<h1 class="page-header">'..
				'Dashboard'..
			'</h1>\n'..
	'	</div>\n'..
	'</div>\n'..
	'<div class="row">\n'..
	'	<div class="col-lg-6">\n'..
	'		<div class="panel panel-default">\n'..
	'			<div class="panel-heading">\n'..
	'					Elenco GPIO\n'..
	'			</div>\n'..
	'			<div class="panel-body">\n'..
	'				<div class="dataTable_wrapper">\n'..
	'					<table class="table table-striped table-bordered table-hover gpio" style="    width: initial !important;" id="dataTables-example">\n'..
	'						<thead>\n'..
	'							<tr>\n'..
	'								<th>Pin</th>\n'..
	'								<th>On/Off</th>\n'..
	'								<th>Switch</th>\n'..
	'								<th>Stato</th>\n'..
	'							</tr>\n'..
	'						</thead>\n'..
	'						<tbody>\n'
	)

	for i, act in ipairs(led) do
		fwrite(page_name, 
		'								<tr nowrap style="white-space: nowrap;">'..
		'									<td style="text-align: center">'..act.pin..'</td>\n'..
		'									<td>'..
													'<button class="btn btn-success" id="'..i..'" act="on">ON</button></a> '..
													'<button class="btn btn-danger" id="'..i..'" act="off">OFF</button></a>'..
												'</td>\n'..
		'									<td>'..
													'<button class="btn btn-primary" id="'..i..'" act="toggle">'..act.name..'</button>'..
												'</td>\n'..
		'									<td><div class="circle" id="p'..i..'"></div></td>\n'..
		'								</tr>\n'
		, 'a')
	end

	fwrite(page_name,
	'						</tbody>\n'..
	'					</table>\n'..
	'				</div>\n'..
	'			</div>\n'..
	'		</div>\n'..
	'	</div>\n'..
	'</div>\n'
	, 'a')

	sck:send(cfg.web.ok200,
		function () openTemplate(sck, "sbadmin1.lua",
			function () openTemplate(sck, page_name,
				function () openTemplate(sck, "sbadmin_b.lua",
					function () openTemplate(sck, "sbadmin2.lua")end
				)end
			)end
		)end
	)
	file.remove(page_name)
--	sck:close()
end