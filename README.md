# DJ con Sonic Pi

Este práctica es del grupo Compañia Letal para Lenguajes y Paradigmas de tercer año de Ingeniería Informática UCJC.

####Compuesto por:
                
+ Nielsen Casado García
+ Vittorio Ferone
+ Marcos Sánchez Morales
+ Javier Langa Subirón
                
----

La base de este proyecto es crear un set de Dj, mientras programamos en vivo con Sonic Pi.

##Set: 


####Etapa 1 Intro

En esta parte se propondrá una base ya hecha para dar tiempo a preparar todo el set

    use_bpm 60

	define :sample_bass do
  	sample :bass_hard_c, attack: 0.5, sustain: 1
	end
	define :sample_choir do
 	 sample :loop_3d_printer, sustain: 3.2
	end
	define :sample_darkchoir do
  	sample :ambi_dark_woosh
	end
	define :hat do
  	sample :hat_gem
  	sleep 0.5
	end
	live_loop :bass do
  	use_synth :dpulse
  	1.times do
    	sample_darkchoir
    	sleep 2
    	sample_choir
    	sleep 3
    	3.times do
      	sample_bass
      	with_fx :reverb, room: 0.8, damp: 0.5 do
        	play :e4
        	sleep 0.75
        	play :b4
        	sleep 0.75
        	play :a4
        	sleep 0.5
        	play :e4
        	sleep 0.75
        	play :b3
        	sleep 0.75
        	play :a3
        	sleep 0.5
      	end
    	end
    
    	with_fx :reverb, room: 0.9, mix: 0.7 do
      	sample :misc_glitch, rate: 1.5, amp: 1
      	sleep 0.5
      	sample :elec_blip, rate: 2, amp: 0.7
      	sleep 0.25
      	sample :elec_blip2, rate: 2, amp: 0.7
      	sleep 0.25
    	end
    
    	sample :perc_impact2, amp: 2, sustain: 1.5
    	sleep 1.5
    
    	2.times do
      	sample_bass
      	with_fx :reverb, room: 0.7, damp: 0.4 do
        	play :g4
        	sleep 0.75
        	play :f4
        	sleep 0.75
        	play :e4
        	sleep 0.5
        	play :g4
        	sleep 0.75
        	play :f3
        	sleep 0.75
        	play :e3
        	sleep 0.5
     	 end
    	end
    
    # Transición hacia una sección más dinámica
    	with_fx :echo, phase: 0.375, mix: 0.6 do
      	2.times do
        	sample_bass
        	play :e4, release: 0.5, amp: 1.2
        	sleep 0.5
        	play :g4, release: 0.5, amp: 1.2
        	sleep 0.5
        	play :d4, release: 0.5, amp: 1.2
        	sleep 0.5
        	play :a4, release: 0.5, amp: 1.2
        	sleep 0.5
      	end
    	end
    
    	with_fx :slicer, phase: 0.25, wave: 1 do
      	play chord(:e3, :minor), release: 3, amp: 1.5
      	sleep 3
    	end
    	stop
  	end
	end
	# Variables de amplificación y velocidad inicial
	bass_amp = 0.5
	elec_amp = 0.25
	elec_rate = 1.0  # Velocidad inicial de los electrónicos
	elec_sleep = 1.0

	# Hilo para el bajo
	in_thread do
  	sleep 5
  	loop do
    	sample :bass_woodsy_c, amp: bass_amp
    	sleep 0.25
    	sample :bass_hit_c, amp: bass_amp
    	sleep 0.75
  	end
	end

	# Hilo para los sonidos electrónicos
	elec_thread = in_thread do
  	sleep 5
  	loop do
    	sample :elec_ping, amp: elec_amp, rate: elec_rate
    	sleep elec_sleep * 0.25
    	sample :elec_blip2, amp: elec_amp, rate: elec_rate
    	sleep elec_sleep * 0.75
  	end
	end

	# Hilo para el bombo
	in_thread do
  	sleep 5
  	loop do
    	sample :bd_haus, amp: bass_amp
    	sleep 0.5
    	sample :drum_bass_hard, amp: bass_amp
    	sleep 0.5
  	end
	end

####Etapa 2 Confusión

Al terminar esta intro empezaran a sonar ruidos de cuentas atrás, cronómetros, acabando con la explosion de una bomba nuclear.

	# Ajustar amplificación y velocidad después de un tiempo
	in_thread do
  	sleep 35  # Esperar un tiempo antes de cambiar las amplitudes y velocidad
  	10.times do
    	bass_amp -= 0.03 if bass_amp > 0  # Bajar la amplificación del bajo
    	elec_amp += 0.05 if elec_amp < 1.0  # Subir la amplificación de los electrónicos
    	elec_rate += 0.1 if elec_rate < 2.0  # Aumentar la velocidad de los electrónicos
    	elec_sleep -= 0.05 if elec_sleep >= 0
    	sleep 1  # Tiempo entre cambios
  	end
  	7.times do
    	sample :elec_pop, amp: 3
    	sleep 1
  	end
  	use_synth :noise
  	play 50, sustain: 3
	end

####Etapa 3 Mundo Apocalíptico

A partir de aquí comienza el live-programming introduciendo poco a poco los instrumentos hasta que se crea una base que simula un mundo apocalíptico.

####Etapa 4 Final

Con la base anterior se realizaran unos pequeños cambios a la base, sin quitar la esencia principal.
