// Final - Stardust

// Used resources
[me.dir(-1)+"/audio/kick_03.wav",
 me.dir(-1)+"/audio/hihat_02.wav",
 me.dir(-1)+"/audio/snare_01.wav"] @=> string resources[];
 
// Define percussion objects.
SndBuf kick => Pan2 kickpan => Mixdac.in;
SndBuf hihat => Pan2 hihatpan => Mixdac.in;
SndBuf snare => Pan2 snarepan => Mixdac.in;
0.4 => kick.gain;
0.2 => hihat.gain;
0.2 => snare.gain;
0.4 => kickpan.pan;
-0.4 => snarepan.pan;
-0.2 => hihatpan.pan;

// Load sound samples and stop them.
resources[0] => kick.read;
kick.samples() => kick.pos;
resources[1] => hihat.read;
hihat.samples() => hihat.pos;
resources[2] => snare.read;
snare.samples() => snare.pos;

// Set an absolute counter
0 => int counter;

while (true) {
    // Update counter
    counter % 4 => int beat;
    
    // Play percussion
    if ((beat == 0) || (beat == 2)) {
        0 => kick.pos;
    }
    if (beat == 1) {
        0 => snare.pos;
        Math.random2f(0.6,1.1) => snare.rate;
    }
    else if (beat == 3) {
        0 => snare.pos;
        Math.random2f(0.6,1.1) => snare.rate;
    }
    0 => hihat.pos;
    0.1 => hihat.gain;
    Math.random2f(0.95,1.05) => hihat.rate;
        
    // Update counter and bar
    counter++;
    
    // Pass time
    BPM.beat => now;
}
