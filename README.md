# DJ con Sonic Pi

Este práctica es del grupo Compañia Letal para Lenguajes y Paradigmas de tercer año de Ingeniería Informática UCJC.

#### Compuesto por:
                
+ Nielsen Casado García
+ Vittorio Ferone
+ Marcos Sánchez Morales
+ Javier Langa Subirón
                
----

La base de este proyecto es crear un set de Dj, mientras programamos en vivo con Sonic Pi.

## Set: 


#### Etapa 1 Intro

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

#### Etapa 2 Confusión

Al terminar esta intro empezaran a sonar ruidos de cuentas atrás, cronómetros, acabando con la explosion de una bomba nuclear.

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

#### Etapa 3 Mundo Apocalíptico

A partir de aquí comienza el live-programming introduciendo poco a poco los instrumentos hasta que se crea una base que simula un mundo apocalíptico.

#### Etapa 4 Final

Con la base anterior se realizaran unos pequeños cambios a la base, sin quitar la esencia principal.

	use_bpm 120
	
	#Utilización de 2 samples similares para imitar al de un aparato electrico que ha perdido una fuente de alimentación, ajustando la velocidad de reproducción de este sample con la función rate:
	
	live_loop :beep_boop do
	  sample :elec_ping, rate: 2
	  sleep 0.5
	  sample :elec_blip2, rate: 3
	  sleep 1.5
	end
	
	#Similar al anterior live_loop en este utilizamos un sample anteriormente utilizado pero utilizamos funciones para darle un sonido distinto, para ello utilizamos la función rate previamente utilizada pero junto con la función knit somos capaces de hacer que una vez se reproduzca a 1.5 de velocidad pero a la siguiente se reproduzca a la velocidad estandar dandole variedad, además de amplificar el sonido 1.5 veces para que resalte más, el resultado final es un sonido similar a una alarma.
	
	live_loop :alarma do
	  sample :elec_blip2, rate: (knit 1.5, 1, 1, 1).tick, amp: 1.5
	  sleep 8
	end
	
	#Para el sintetizador hemos utilizado uno de los loops encontrados  en los ejemplos incluidos en Sonic Pi, en este caso hemos utilizado un loop encontrado en el ejemplo llamado Time Machine. Este sintetizador produce un sonido post-apocalíptico, que resulta muy adecuado.
	
	live_loop :sint do
	  synth :tb303, release: 8, note: :e1, cutoff: (range 90, 60, -10).tick
	  sleep 8
	  synth :tb303, release: 8, note: :a1, cutoff: (range 90, 60, -10).tick
	  sleep 8
	end
	
	#Aquí es donde el dj de la fiesta vuelve en si después de haber perdido el conocimiento y al ver el potencial de los sonidos que le rodean utiliza elementos para retomar la fiesta por donde se había quedado. En este caso utilizamos un sample para hacer el sonido de un bombo y lo repetimos cada segundo.
	
	live_loop :bombo do
	  sample :bd_haus, amp: 1.5
	  sleep 1
	end
	
	#Ahora la gente de la fiesta comienza a seguir el bombo con palmadas, para ello utilizamos sync: lo cual hace que al sonar el bombo suene la palmada dando la sensación de que parte del público está aportando al ritmo.
	
	live_loop :palmada do
	  sync :bombo
	  sleep 0.5
	  sample :perc_snap
	  sleep 0.5
	end
	
	#Ahora es cuando el dj captura sonidos de afuera de la discoteca y los modifica para implementarlos al beat. La formula es similar a los loops anteriores.
	
	live_loop :sonido_fondo do
	  sample :loop_garzul, amp: 0.7 , rate: (knit -1, 1).tick
	  sleep 8
	end
	
	#Finalmente el dj utiliza su guitarra para hacer del beat una obra maestra digna del festival ucjc demostrando así que ni un apocalipsis puede parar el festival. Aquí utilizamos with_fx para dar efectos al sample de una guitarra, solapamos 2 efectos uno sobre otro para aportar al sonido apocaliptico y fuera de lugar.
	
	live_loop :guitarra do
	  with_fx :echo, mix: 0.5, phase: 0.75 do
	    with_fx :bitcrusher, bits: 8 do
	      sleep 2
	      sample :guit_e_slide, rate: 0.8, amp: 0.7
	      sleep 6
	      sleep 2
	      sample :guit_e_slide, rate: 0.8, amp: 0.7
	      sleep 2
	      sample :guit_e_slide, release: 1, rate: 0.8, amp: 0.7
	      sleep 1
	      sample :guit_e_slide, release: 3, rate: 0.8, amp: 0.7
	      sleep 1
	      sample :guit_e_slide, release: 0.3, rate: 2, amp: 0.9
	      sleep 1
	      sample :guit_e_slide, release: 0.3, rate: 2, amp: 0.9
	      sleep 1
	    end
	  end
	end
