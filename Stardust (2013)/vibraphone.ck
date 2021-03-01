// Final - Stardust

// Define oscillator objects.
ModalBar metalophone => ResonZ filt => Mixdac.in;
800.0 => filt.freq;
1.0 => filt.Q;
10 => metalophone.preset;

fun void playSTKNote(int note,ModalBar instrument,float gain) {
    if (note != 0) {
        Std.mtof(note+12) => instrument.freq;
        1.0 => instrument.noteOn;
        gain => instrument.gain;
    }
}

[[ 1, 0, 3, 0, 3, 0, 4, 4], //bar 1
 [ 5, 0, 0, 0, 7, 7, 3, 3], //bar 2
 [ 1, 0, 0, 0, 6, 0, 4, 5], //bar 3
 [ 6, 0, 1, 1, 3, 0, 0, 0], //bar 4
 [ 0, 0, 0, 0, 7, 0, 7, 0], //bar 5
 [ 1, 0, 1, 3, 5, 0, 0, 0], //bar 6
 [ 5, 0, 5, 2, 7, 0, 0, 8], //bar 7
 [10, 0, 0, 8, 6, 0, 5, 0], //bar 8
 [ 1, 1, 3, 0, 3, 0, 2, 0], //bar 9
 [ 4, 4, 6, 0, 6, 0, 7, 0], //bar 10
 [ 5, 5, 7, 0, 7, 0, 9, 0], //bar 11
 [ 1, 1, 5, 0, 8, 0, 0, 0], //bar 12

 [ 1, 0, 3, 0, 5, 0, 3, 4], //bar x1
 [ 2, 0, 6, 0, 4, 0, 2, 0], //bar x2
 [ 5, 0, 2, 0, 7, 0, 5, 6], //bar x3
 [ 4, 0, 8, 0, 4, 0, 6, 0], //bar x4
 [ 7, 0, 2, 0, 7, 7, 9, 14],//bar x5
 [ 1, 0, 3, 0, 5, 0, 1, 0], //bar x6
 
 [ 1, 0, 3, 0, 3, 0, 4, 4], //bar 1
 [ 5, 0, 0, 0, 7, 7, 3, 3], //bar 2
 [ 1, 0, 0, 0, 6, 0, 4, 5], //bar 3
 [ 6, 0, 1, 1, 3, 0, 0, 0], //bar 4
 [ 0, 0, 0, 0, 7, 0, 7, 0], //bar 5
 [ 1, 0, 1, 3, 5, 0, 0, 0], //bar 6
 [ 5, 0, 5, 2, 7, 0, 0, 8], //bar 7
 [10, 0, 0, 8, 6, 0, 5, 0], //bar 8
 [ 1, 1, 3, 0, 3, 0, 2, 0], //bar 9
 [ 4, 4, 6, 0, 6, 0, 7, 0], //bar 10
 [ 5, 5, 7, 0, 7, 0, 9, 0], //bar 11
 [ 1, 1, 5, 0, 8, 0, 0, 0]  //bar 12
] @=> int melody[][];

// Start in bar 0
0 => int bar;

// Set an absolute counter
0 => int counter;

while (true) {
    // Update counter
    counter % 8 => int beat;
    
    // Select melody note from piece matrix
    Scale.notes[melody[bar][beat]] => int melodyNote;
    
    // Play notes with the oscillators
    playSTKNote(melodyNote,metalophone,0.8);

    counter++;
    if (beat == 7) {
        (bar+1)%30 => bar;
    } 
    
    // Pass time
    // Since a quarter is 750 ms long, an eighth is 375 ms long
    BPM.eighthNote => now;
}
