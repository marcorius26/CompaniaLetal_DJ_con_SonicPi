use_bpm 120

live_loop :beep_boop do
  sample :elec_ping, rate: 2
  sleep 0.5
  sample :elec_blip2, rate: 3
  sleep 1.5
end


live_loop :alarma do
  sample :elec_blip2, rate: (knit 1.5, 1, 1, 1).tick, amp: 1.5
  sleep 8
end

live_loop :sint do
  synth :tb303, release: 8, note: :e1, cutoff: (range 90, 60, -10).tick
  sleep 8
  synth :tb303, release: 8, note: :a1, cutoff: (range 90, 60, -10).tick
  sleep 8
end

live_loop :bombo do
  sample :bd_haus, amp: 1.5
  sleep 1
end

live_loop :palmada do
  sync :bombo
  sleep 0.5
  sample :perc_snap
  sleep 0.5
end

live_loop :sonido_fondo do
  sample :loop_garzul, amp: 0.7 , rate: (knit -1, 1).tick
  sleep 8
end


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