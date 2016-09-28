--En desarrollo. Listo para programar
--doc: http://rinnegatamante.it/lpp-3ds_doc.html


--Variables
local pad = Controls.read()
local usuario
local bateria

--Variables formateadas
local fechaF
local horaF
local cumpleF
local firmwareF
local kernelF
local bateriaF


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
    Screen.debugPrint(5,5, "Hola, "..usuario, colores.amarillo, TOP_SCREEN)	
	Screen.debugPrint(20,30,cumpleF, colores. blanco, TOP_SCREEN)
	Screen.debugPrint(20,45, firmwareF, colores.blanco, TOP_SCREEN)
	Screen.debugPrint(20,60, kernelF, colores.blanco, TOP_SCREEN)
	
	Screen.debugPrint(0,0, horaF, colores.verde, BOTTOM_SCREEN)
	Screen.debugPrint(100,0, fechaF, colores.verde, BOTTOM_SCREEN)
	Screen.debugPrint(200, 0, bateriaF, colores.rojo, BOTTOM_SCREEN)	
	Screen.debugPrint(0,50, "Pulsa B para cerrar", colores.azul, BOTTOM_SCREEN)
    Screen.flip()
end

function init()

	--definimos variables locales
	local usu = System.getUsername()
	local cumD, cumM = System.getBirthday()
	local f1, f2, f3 = System.getFirmware()
	local k1, k2, k3 = System.getKernel()
	local reg = System.getRegion()
	local bat = System.getBatteryLife()
	local h1, m1, s1 = System.getTime()
	local d2, m2, a2 = System.getDate()

	--formateamos el texto
	local fecha = formateaFecha(d2, m2, a2)
	local hora = formateaHora(h1, m1, s1)
	local firmware = formateaFirmware(f1, f2, f3, reg)
	local vKernel = formateaVersionKernel(k1, k2, k3)
	local cumpleanos = formateaCumple(cumD, cumM)
	local batt = formateaBateria(bat)	
	
	--pasamos las variables locales a las globales para no ensuciar las globales
	usuario = usu
	cumpledia = cumD;	cumplemes = cumM
	f1 = firm1;	f2 = firm2;	f3 = firm3
	k1 = kernel1;	k2 = kernel2;	k3 = kernel3	
	region = reg
	bateria = bat
	h1 = h;	m1 = m;	s1 = s
	d2 = d;	m2 = mes; a2 = ano
	
	--pasamos las variables formateadas
	fechaF = fecha
	horaF = hora
	firmwareF = firmware
	kernelF = vKernel
	cumpleF = cumpleanos	
	bateriaF = batt
end
function formateaFecha(d2, m2, a2)

	--variable temporal para no manipular la variable d2
	local res = d2
	
	--bucle "switch"
	if res == 1 then res = "Lun" end
	if res == 2 then res = "Mar" end
	if res == 3 then res = "Mie" end
	if res == 4 then res = "Jue" end
	if res == 5 then res = "Vie" end
	if res == 6 then res = "Sab" end
	if res == 7 then res = "Dom" end	
	
	local fecha = res .. '/' .. m2 .. '/' .. a2
	
	return fecha
end
function formateaHora(h1, m1, s1)
	local a = h1
	local b = m1
	local c = s1
	
	--TODO si tiene menos de dos cifras poner el cero delante: 1 -> 01
	
	local hora = a .. ':' .. b .. ':' .. c
	return hora
end
function formateaFirmware(f1, f2, f3, reg)
	local a = f1
	local b = f2
	local c = f3
	local i = reg
	
	--TODO formatear a base 10 inverso el firmware
	--TODO formatear la region 
	
	local firmware = "Ver. " .. a .. b .. c .. ' ' .. i
	return firmware
end
function formateaVersionKernel(k1, k2, k3)
	local a = k1
	local b	= k2
	local c = k3
	
	--TODO lo mismo que firmware
	
	local vKernel = "Kernel: " .. a .. b .. c

	return vKernel
end
function formateaCumple(cumD, cumM)
	local a = cumD
	local b = cumM
	
	--TODO igual que la hora
	
	local cumpleanos = "Cumple: " .. a .. '-' .. b
	return cumpleanos
end
function formateaBateria(bat)
	local a = bat
	
	--TODO formatear bateria
	
	local batt = a .. "%"
	
	return batt
end

init()
main()
while true do
	pad = Controls.read()

	if Controls.check(pad,KEY_B) then
		System.exit()	
	end	
	
	Screen.waitVblankStart() 
	Screen.clear(BOTTOM_SCREEN)	
	
	local h1, m1, s1 = System.getTime()
	local d2, m2, a2 = System.getDate()
	local bat = System.getBatteryLife()
	
	local hora = formateaHora(h1, m1, s1)
	local fecha = formateaFecha(d2, m2, a2)
	local batt = formateaBateria(bat)		
	
	Screen.debugPrint(0,0, hora, colores.verde, BOTTOM_SCREEN)
	Screen.debugPrint(100,0, fecha, colores.verde, BOTTOM_SCREEN)
	Screen.debugPrint(280, 0, batt, colores.rojo, BOTTOM_SCREEN)	
	Screen.debugPrint(0,200, "Pulsa B para cerrar", colores.azul, BOTTOM_SCREEN)
	Screen.waitVblankStart() 
end
