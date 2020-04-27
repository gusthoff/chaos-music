# Chaos Music

## Getting Started

Follow the instructions below to install the required packages and run the
application.

### Prerequisites

This application requires:

- The [Julia language compiler](https://julialang.org/)

- Julia packages from:

    - [JuliaDynamics](https://github.com/JuliaDynamics/)
    - [JuliaMusic](https://github.com/JuliaMusic)

- A score editor that supports MusicXML files

    - For example, [MuseScore](https://musescore.org)

### Installing the Julia packages

To install the required packages, run the following commands in the Julia
environment:

```julia
using Pkg; Pkg.add("DynamicalSystems")
using Pkg; Pkg.add("MusicXML")
```

You might want to plot arrays. This requires `Plots`:

```julia
using Pkg; Pkg.add("Plots")
```

### Running the Application

Use the Julia compiler to run the application:

```
julia chaos_music_gen.jl
```

This generates a MusicXML file called `myscore.musicxml`. In order to
visualize it and play it, open the file in the score editor.
