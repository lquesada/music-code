// Final - Stardust

// Define oscillators
PulseOsc harmonyOsc0 => Pan2 pan0 => Mixdac.in;
PulseOsc harmonyOsc1 => Pan2 pan1 => Mixdac.in;
PulseOsc harmonyOsc2 => Pan2 pan2 => Mixdac.in;
0.5 => harmonyOsc0.width;
0.4 => harmonyOsc1.width;
0.3 => harmonyOsc2.width;

// This function automatically oscillates a pan
fun void autopan(Pan2 panner,float factor,float width) {
    while (true) {
        Math.sin((now/second)*Math.PI*factor)*width => panner.pan;
        10::ms => now;
    }
    
}

spork ~ autopan(pan0,0.6,0.3);
spork ~ autopan(pan1,0.2,0.3);
spork ~ autopan(pan2,0.6,0.2);

// This function returns the notes of a diatonic chord
// i.e. either major or minor, only using notes of the scale,
fun int[] chordNotesFromScale(int note) {
    // if note is silence, no chord is to be played.
    if (note == 0)
           return [0,0,0];
    // else, return the unison, the corresponding third, and the fifth.
    return [Scale.notes[note],
            Scale.notes[note+2],
            Scale.notes[note+4]]; 
}

// This function plays harmony.
fun void playHarmony(int harmony[]) {
    playNote(harmony[0],harmonyOsc0,0.01);
    playNote(harmony[1],harmonyOsc1,0.005);
    playNote(harmony[2],harmonyOsc2,0.002);
}    

// This function plays a single note.
fun void playNote(int note,Osc oscillator,float gain) {
    if (note != 0) {
        Std.mtof(note) => oscillator.freq;
        gain => oscillator.gain;
    }
    else {
        0 => oscillator.gain;
    }
}

// The piece harmony is represented as an array.
[[ 1, 8, 1, 8, 1, 8, 1, 8], //bar 1
 [ 5,12, 5,12, 5,12, 5,12], //bar 2
 [ 4,11, 4,11, 4,11, 4,11], //bar 3
 [ 6,13, 6,13, 6,14, 6,15], //bar 4
 [ 4,11, 4,11, 5,12, 5,12], //bar 5
 [ 1, 8, 1, 8, 1, 7, 1, 6], //bar 6
 [ 5,12, 5,12, 5,12, 5,12], //bar 7
 [ 6,13, 6,13, 6,13, 5,12], //bar 8
 [ 1, 8, 1, 8, 1, 8, 1, 8], //bar 9
 [ 4,11, 4,11, 4,11, 4,11], //bar 10
 [ 5,12, 5,12, 5,12, 5,12], //bar 11
 [ 1, 8, 1, 8, 1, 8, 1, 8], //bar 12

 [ 1, 8, 1, 8, 1, 8, 1, 8], //bar x1
 [ 2, 9, 2, 9, 2, 9, 2, 9], //bar x2
 [ 5,12, 5,12, 5,12, 5,12], //bar x3
 [ 4,11, 4,11, 5,12, 5,12], //bar x4
 [ 7,14, 7,14, 8,15, 8,15], //bar x5
 [ 1, 8, 1, 8, 1, 8, 1, 8], //bar x6
 
 [ 1, 8, 1, 8, 1, 8, 1, 8], //bar 1 bis
 [ 5,12, 5,12, 5,12, 5,12], //bar 2
 [ 4,11, 4,11, 4,11, 4,11], //bar 3
 [ 6,13, 6,13, 6,14, 6,15], //bar 4
 [ 4,11, 4,11, 5,12, 5,12], //bar 5
 [ 1, 8, 1, 8, 1, 7, 1, 6], //bar 6
 [ 5,12, 5,12, 5,12, 5,12], //bar 7
 [ 6,13, 6,13, 6,13, 5,12], //bar 8
 [ 1, 8, 1, 8, 1, 8, 1, 8], //bar 9
 [ 4,11, 4,11, 4,11, 4,11], //bar 10
 [ 5,12, 5,12, 5,12, 5,12], //bar 11
 [ 1, 8, 1, 8, 1, 8, 1, 8]  //bar 12
] @=> int harmony[][];

// Start in bar 0
0 => int bar;

// Set an absolute counter
0 => int counter;

while (true) {
    // Update counter
    counter % 8 => int beat;
    
    // Select harmony notes from piece matrix
    chordNotesFromScale(harmony[bar][beat]) @=> int harmonyNotes[];

    // Play notes with the oscillators
    playHarmony(harmonyNotes);

    // Display info
    // Update counter and bar
    counter++;
    if (beat == 7) {
        (bar+1)%30 => bar;
    } 
    
    // Pass time
    BPM.eighthNote => now;
}
