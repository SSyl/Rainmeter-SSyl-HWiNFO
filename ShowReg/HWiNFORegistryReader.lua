-- ..\SSyliNFO\ShowReg\HWiNFORegistryReader.lua
-- Everything in the ShowReg folder was obtained from: https://docs.rainmeter.net/tips/examples/HWiNFO_New.rmskin
-- Based on code provided by raiguard

function ParseOutput(measureName)
	local raw = SKIN:GetMeasure(measureName):GetStringValue()
	local fileName = SKIN:GetVariable('CURRENTPATH')..'output.html'
  
  -- Create document header
	local output = 
	[[<!DOCTYPE HTML>
	<html lang="en-US">
	<head>
	<title>HWiNFO Registry Reader</title>
	<meta http-equiv="content-type" content="text/html;charset=utf-8" />
	<style>
	body {
		font-family: Sans-serif;
		font-size: 100%;
		font-color: #2F2F2F;
		background-color: #E1E3E6;
	}
	td {
		padding: 5px;
	}
	th {
		background-color: #F7BC81;
		color: #2F2F2F;
		padding: 10px 0px 10px 0px;
	}
	table {
		table-layout: fixed;
		width: 100%;
		background-color: #FAFAFA;
		box-shadow: 0 0 15px 3px #9E9E9E;
	}
	table, th, td {
		border-style: solid;
		border-width: 1px;
		border-color: #2F2F2F;
		border-collapse: collapse;    
		word-wrap: break-word;
	}
	div {
		width: 95%;
		position: absolute;
		top:0;
		bottom: 0;
		left: 0;
		right: 0;
		margin: auto;
	}  
	</style>
	</head>
	<body>
	<div>
	<br>
	<table>
	<tr>
	<th style="width: 5%;">Index</th>
	<th style="width: 25%;">Sensor</th>
	<th style="width: 25%;">Label</th>
	<th style="width: 10%;">Value</th>
	<th style="width: 10%;">ValueRaw</th>
	</tr>]]

	-- Match over each group as a whole
	local match_string = '    Sensor(%d-)    .-    (.-)\n    .-    .-    (.-)\n    .-    .-    (.-)\n    .-    .-    (.-)\n'
	for index, sensor, label, value, value_raw in raw:gmatch(match_string) do
		output = output
		..'<tr><td style="width: 5%;">'..index..'</td>'
		..'<td style="width: 25%;">'..sensor..'</td>'
		..'<td style="width: 25%;">'..label..'</td>'
		..'<td style="width: 10%;">'..value..'</td>'
		..'<td style="width: 10%;">'..value_raw..'</td></tr>\n'
	end

	-- Create document footer
	output = output .. '</table><br></div></body></html>'

	-- Write to the file
	local file = io.open(fileName, 'w')
	file:write(output)
	file:close()
  
	-- Open the page in the browser

	SKIN:Bang(fileName)
	SKIN:Bang('!DeactivateConfig')
  
end