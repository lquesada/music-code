// Final - Stardust

public class BPM {
    static dur bar,beat,quarterNote,eighthNote,sixteenthNote,thirtysecondNote;
    
    fun void tempo(float beats) {
        60/beats => float SPB;
        SPB::second => beat;
        (4*SPB)::second => bar;
        SPB::second => quarterNote;
        quarterNote*0.5 => eighthNote;
        eighthNote*0.5 => sixteenthNote;
        sixteenthNote*0.5 => thirtysecondNote;
    }
}
