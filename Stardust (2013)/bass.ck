// Final - Stardust

// Define mandolin object.
Mandolin bass => ResonZ filt => Mixdac.in;
400.0 => filt.freq;
1.0 => filt.Q;

// This function plays a single note in the bass.
fun void playBassNote(int note) {
if (note != 0) {
        Std.mtof(note-12) => bass.freq;
        1.0 => bass.noteOn;
        0.2 => bass.gain;
    }
}

// The piece harmony is represented as an array.
[[ 1, 1, 1, 1, 1, 1, 1, 1], //bar 1
 [ 5, 5, 5, 5, 5, 5, 5, 5], //bar 2
 [ 4, 4, 4, 4, 4, 4, 4, 4], //bar 3
 [ 6, 6, 6, 6, 6, 6, 6, 6], //bar 4
 [ 4, 4, 4, 4, 5, 5, 5, 5], //bar 5
 [ 1, 1, 1, 1, 1, 1, 1, 1], //bar 6
 [ 5, 5, 5, 5, 5, 5, 5, 5], //bar 7
 [ 6, 6, 6, 6, 6, 6, 5, 5], //bar 8
 [ 1, 1, 1, 1, 1, 1, 1, 1], //bar 9
 [ 4, 4, 4, 4, 4, 4, 4, 4], //bar 10
 [ 5, 5, 5, 5, 5, 5, 5, 5], //bar 11
 [ 1, 1, 1, 1, 1, 1, 1, 1], //bar 12

 [ 1, 1, 1, 1, 1, 1, 1, 1], //bar x1
 [ 2, 2, 2, 2, 2, 2, 2, 2], //bar x2
 [ 5, 5, 5, 5, 5, 5, 5, 5], //bar x3
 [ 4, 4, 4, 4, 4, 4, 4, 4], //bar x4
 [ 7, 7, 7, 7, 7, 7, 7, 7], //bar x5
 [ 1, 1, 1, 1, 1, 1, 1, 1], //bar x6
 
 [ 1, 1, 1, 1, 1, 1, 1, 1], //bar 1 bis
 [ 5, 5, 5, 5, 5, 5, 5, 5], //bar 2
 [ 4, 4, 4, 4, 4, 4, 4, 4], //bar 3
 [ 6, 6, 6, 6, 6, 6, 6, 6], //bar 4
 [ 4, 4, 4, 4, 5, 5, 5, 5], //bar 5
 [ 1, 1, 1, 1, 1, 1, 1, 1], //bar 6
 [ 5, 5, 5, 5, 5, 5, 5, 5], //bar 7
 [ 6, 6, 6, 6, 6, 6, 5, 5], //bar 8
 [ 1, 1, 1, 1, 1, 1, 1, 1], //bar 9
 [ 4, 4, 4, 4, 4, 4, 4, 4], //bar 10
 [ 5, 5, 5, 5, 5, 5, 5, 5], //bar 11
 [ 1, 1, 1, 1, 1, 1, 1, 1]  //bar 12
] @=> int harmony[][];

// Start in bar 0
0 => int bar;

// Set an absolute counter
0 => int counter;

while (true) {
    // Update counter
    counter % 8 => int beat;
    
    // Select harmony note from piece matrix
    Scale.notes[harmony[bar][beat]] @=> int bassNote;

    // Play notes with the oscillators
    playBassNote(bassNote);

    // Update counter and bar
    counter++;
    if (beat == 7) {
        (bar+1)%30 => bar;
    } 
    
    // Pass time
    BPM.eighthNote => now;
}
