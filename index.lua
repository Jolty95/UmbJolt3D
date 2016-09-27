--En desarrollo. Listo para programar
--doc: http://rinnegatamante.it/lpp-3ds_doc.html


--Variables
local pad = Controls.read()
local usuario
local cumpledia, cumplemes
local firm1, firm2, firm3
local kernel1, kernel2, kernel3
local region
local bateria
local h, m, s
local d, mes, ano

local fecha
local hora
local cumple
local firmware
local kernel


--Colores
local colores =
{	
	rojo = Color.new(255,0,0),
	verde = Color.new(55,255,0),
	amarillo = Color.new(255,205,66),
	blanco = Color.new(255,255,255),
	--un azul distinto al "estandar"
	azul = Color.new(100,149,237)	
}

--Main
function main()
    Screen.refresh()
    Screen.clear(TOP_SCREEN)
	Screen.clear(BOTTOM_SCREEN)
	getVariables()
    Screen.debugPrint(5,5, "Hola, "..usuario, colores.amarillo, TOP_SCREEN)	
	Screen.debugPrint(20,30,cumple, colores. blanco, TOP_SCREEN)
	Screen.debugPrint(20,45, firmware, colores.blanco, TOP_SCREEN)
	Screen.debugPrint(20,60, kernel, colores.blanco, TOP_SCREEN)
	
	Screen.debugPrint(0,0, hora, colores.verde, BOTTOM_SCREEN)
	Screen.debugPrint(100,0, fecha, colores.verde, BOTTOM_SCREEN)
	Screen.debugPrint(200, 0, bateria, colores.rojo, BOTTOM_SCREEN)	
	Screen.debugPrint(0,50, "Pulsa B para cerrar", colores.azul, BOTTOM_SCREEN)
    Screen.flip()
end

function getVariables()
	usuario = System.getUsername() 
	cumpledia, cumplemes = System.getBirthday()
	firm1, firm2, firm3 = System.getFirmware() 
	kernel1, kernel2, kernel3 = System.getKernel() 
	region = System.getRegion() 
	bateria = System.getBatteryLife() 
	h,m,s = System.getTime() 
	d, mes, ano = System.getDate() 
	if d == 1 then d = "Lun" end
	if d == 2 then d = "Mar" end
	if d == 3 then d = "Mie" end
	if d == 4 then d = "Jue" end
	if d == 5 then d = "Vie" end
	if d == 6 then d = "Sab" end
	if d == 7 then d = "Dom" end
	

	fecha = d .. '/' .. mes .. '/' .. ano
	hora = h .. ':' .. m .. ':' .. s
	cumple = "Cumple: " .. cumpledia .. '-' .. cumplemes
	firmware = "Ver. " .. firm1 .. firm2 .. firm3 .. ' ' .. region
	kernel = "Kernel: " .. kernel1 .. kernel2 .. kernel3
	bateria = bateria .. "%"
	
end

main()
while true do
	pad = Controls.read()

	if Controls.check(pad,KEY_B) then
		System.exit()	
	end	
	
	hn, mn, sn = System.getTime()
	if not sn == s then		
		refresca();
	end
--	checkNuevaBateria()
--	checkNuevaFecha()
end



function refresca()
    Screen.refresh()
	Screen.clear(BOTTOM_SCREEN)
		
	h,m,s = System.getTime() 		
	hora = h .. ':' .. m .. ':' .. s
	
	Screen.debugPrint(0,0, hora, colores.verde, BOTTOM_SCREEN)
	Screen.debugPrint(100,0, fecha, colores.verde, BOTTOM_SCREEN)
	Screen.debugPrint(220, 0, bateria, colores.rojo, BOTTOM_SCREEN)	
	Screen.debugPrint(0,150, "Pulsa B para cerrar", colores.azul, BOTTOM_SCREEN)
    Screen.flip()
end

function checkNuevaBateria()
	if not bateria == System.getBatteryLife() then
		main();
	end
end

function checkNuevaFecha()
	dn, mn, an = System.getDate()
	if not dn == d or not mn == mes or not an == ano then
		main();
	end
end