--En desarrollo. Listo para programar
--doc: http://rinnegatamante.it/lpp-3ds_doc.html


--Variables
local pad = Controls.read()
local antpad = pad
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
	Screen.fillRect(0,0, 1000, 1000, colores.azul, BOTTOM_SCREEN)
	getVariables()
	hola = "Hola, "
	hola += usuario
    Screen.debugPrint(5,5, hola, colores.amarillo, TOP_SCREEN)	
	Screen.debugPrint(5,15,cumple, colores. blanco, TOP_SCREEN)
	Screen.debugPrint(5,25, firmware, colores.blanco, TOP_SCREEN)
	Screen.debugPrint(5,35, kernel, colores.blanco, TOP_SCREEN)
	Screen.debugPrint(0,0, "Pulsa B para cerrar", colores.blanco, BOTTOM_SCREEN)
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
	

	fecha = d + '/' + mes + '/' + ano
	hora = h + ':' + m + ':' + s
	cumple = "Cumple:" + cumpledia + '-' + cumplemes
	firmware = "Ver. " + firm1 + firm2 + firm3 + ' ' + region
	kernel = "Kernel: " + kernel1 + kernel2 + kernel3
	bateria = bateria + "%"
	
end

main()
while true do
	if Controls.check(pad,KEY_B) and not Controls.check(antpad,KEY_B) then
		System.exit()	
	end		
	Screen.refresh()
	Screen.debugPrint(0,0, hora, colores.verde, TOP_SCREEN)
	Screen.debugPrint(15,0, fecha, colores.verde, TOP_SCREEN)
	Screen.debugPrint(50, 0, bateria, colores.rojo, TOP_SCREEN)
	main()
end