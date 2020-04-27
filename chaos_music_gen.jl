# This application is licensed under the MIT License.
#
# Copyright (c) 2020 Gustavo A. Hoffmann
#
# https://github.com/gusthoff/chaos-music
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

using Pkg; Pkg.add("DynamicalSystems")
using Pkg; Pkg.add("MusicXML")
# using Pkg; Pkg.add("Plots")

using DynamicalSystems
using MusicXML
@importMX # imports all the MusicXML types
# using Plots

##########################################################################
# Create logistic map
##########################################################################

lg = Systems.logistic()
tr = trajectory(lg, 100)

# plot(1:101, tr)

##########################################################################
# MusicXML file: general definition for piano part
#
# Based on example code from MusicXML file
##########################################################################

midiinstrument_piano = MidiInstrument(channel= 1,
                                      program =1,
                                      volume = 100,
                                      pan = 0,
                                      id = "P1-I1")
scorepart_piano = ScorePart(name = "Piano",
                            midiinstrument = midiinstrument_piano,
                            id = "P1")

partlist = PartList(scoreparts = [scorepart_piano])

attributes1_piano = Attributes(
   time = Time(beats = 4, beattype = 4), # 4/4
   divisions = 4, # we want to use 16th notes at minimum
   clef = [Clef(number = 1, sign = "G", line = 2),
           Clef(number = 2, sign = "F", line = 4)], # Piano clefs
   staves = 2, # Piano staves
   key = Key(fifths = 0, mode = "major"), # no accidentals, major key
)

##########################################################################
# Generate notes based on logistic map
##########################################################################

notes = ["C", "D", "E", "F", "G", "A", "B", "C"]

measure1_notes_piano = [Note(rest = Rest(), duration =  4)]
# measure1_notes_piano = []

for (i, j) in enumerate(tr)
    curr_note = notes[round(Int, j*length(notes) + 0.5)]
    push!(measure1_notes_piano,
          Note(pitch = Pitch(step = curr_note, alter = 0, octave = 4),
               duration = 4))
end

##########################################################################
# MusicXML file: write output file
##########################################################################

measures_piano = [
    Measure(attributes = attributes1_piano, notes = measure1_notes_piano)
]

part_piano = Part(measures = measures_piano, id = "P1")

score = ScorePartwise(partlist = partlist, parts = [part_piano],)

writemusicxml("myscore.musicxml", score)
