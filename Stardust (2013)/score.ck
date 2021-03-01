120 => float beat;

Mixdac.init();
Mixdac.log();

BPM tempo;
tempo.tempo(beat);

Scale scale;

Machine.add(me.dir()+"/drumset.ck") => int drumset;
Machine.add(me.dir()+"/bass.ck") => int bass;
Machine.add(me.dir()+"/strings.ck") => int strings;
Machine.add(me.dir()+"/vibraphone.ck") => int vibraphone;
12*tempo.bar => now;

6*tempo.bar => now;

9*tempo.bar => now;

Machine.remove(bass);

tempo.bar => now;

Machine.remove(strings);

tempo.bar => now;

Machine.remove(drumset);

tempo.bar => now;

Machine.remove(vibraphone);
