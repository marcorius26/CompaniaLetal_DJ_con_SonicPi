# Guia para el usuario:
# El orden esta determinado por las letras del abecedario
# de tal manera que el primer live_loop corresponde con la
# a el segundo con la b .etc

# Las letras multiplican al amp para poder ajustar el volumen
# de los loops esto será utilizado mas adelante

# La única limitación es que no se recomienda que el valor de h e i sea 1,
# el loop asignado a i está pensado para seguir al de h, produciendo así un
# cambio de beat

# *Es importante que para el cambio de beat no reiniciemos la
# ejecución para que la transición sea la intencionada*

# Valores utilizados durante la presentación:
# a = 1 -> a = 1
# b = 1 -> b = 2
# c = 1 -> c = 1
# d = 1 -> d = 1.5
# e = 1 -> e = 1
# f = 1 -> f = 0
# g = 0 -> g = 1.5
# h = 1 -> h = 0
# i = 0 -> i = 1


use_bpm 120

a = 0
b = 0
c = 0
d = 0
e = 0
f = 0
g = 0

h = 0
i = 0


live_loop :beep_boop do
  sample :elec_ping, rate: 2, amp: 1*a
  sleep 0.5
  sample :elec_blip2, rate: 3, amp: 1*a
  sleep 1.5
end

live_loop :alarma do
  sample :elec_blip2, rate: (knit 1.5, 1, 1, 1).tick, amp: 1.5*b
  sleep 8
end

live_loop :sint do
  synth :tb303, release: 8, note: :e1, cutoff: (range 90, 60, -10).tick, amp: 1*c
  sleep 8
  synth :tb303, release: 8, note: :a1, cutoff: (range 90, 60, -10).tick, amp: 1*c
  sleep 8
end

live_loop :bombo do
  sample :bd_haus, amp: 1.5*d
  sleep 1
end

live_loop :palmada do
  sync :bombo
  sleep 0.5
  sample :perc_snap, amp: 1*e
  sleep 0.5
end

live_loop :sonido_fondo do
  sample :loop_garzul, amp: 0.9*f , rate: (knit -1, 1).tick
  sleep 8
end

live_loop :bombo2 do
  sleep 0.5
  sample :bd_boom, amp: 1*g
  sleep 0.5
end

live_loop :guitarra do
  with_fx :echo, mix: 0.5, phase: 0.75 do
    with_fx :bitcrusher, bits: 8 do
      sleep 2
      sample :guit_e_slide, rate: 0.8, amp: 0.7*h
      sleep 6
      sleep 2
      sample :guit_e_slide, rate: 0.8, amp: 0.7*h
      sleep 2
      sample :guit_e_slide, release: 1, rate: 0.8, amp: 0.7*h
      sleep 1
      sample :guit_e_slide, release: 3, rate: 0.8, amp: 0.7*h
      sleep 1
      sample :guit_e_slide, release: 0.3, rate: 2, amp: 0.9*h
      sleep 1
      sample :guit_e_slide, release: 0.3, rate: 2, amp: 0.9*h
      sleep 1
    end
  end
end

live_loop :guitarrairreconocible do
  with_fx :echo, mix: 0.5, phase: 0.75 do
    with_fx :bitcrusher, bits: 8 do
      16.times do
        sample :guit_e_slide, release: 0.3, rate: 20, amp: 1.5*i
        sleep 0.5
      end
      16.times do
        sample :guit_e_slide, release: 0.3, rate: 30, amp: 2*i
        sleep 0.5
      end
    end
  end
end