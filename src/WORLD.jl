module WORLD

# A light-weight julia wrapper for WORLD.

# Types
export World, DioOption

# World methods
export dio, dio1, stonemask, star, cheaptrick, platinum, synthesis

# Aperiodiciy analysis
export aperiodicityratio, synthesisFromAperiodicity

# utils
export getFFTSizeForStar, getFFTSizeForCheapTrick

# Dependency
deps = joinpath(Pkg.dir("WORLD"), "deps", "deps.jl")
if isfile(deps)
    include(deps)
else
    error("WORLD not properly installed. Please run Pkg.build(\"WORLD\")")
end

include("bridge.jl")

# World is a composite type that holds common settings that are used during
# analysis
type World
    fs::Int64 # Sample frequency
    framePeriod::Float64 # [ms]
end

World(;fs=44100, framePeriod=5.0) = World(fs, framePeriod)

function dio1(w::World, x::Vector{Float64})
    dio1(x, w.fs, w.framePeriod)
end

function stonemask(w::World, x::Vector{Float64},
                   timeaxis::Vector{Float64}, f0::Vector{Float64})
    stonemask(x, w.fs, timeaxis, f0)
end

function star(w::World, x::Vector{Float64},
              timeaxis::Vector{Float64}, f0::Vector{Float64})
    star(x, w.fs, timeaxis, f0)
end

function cheaptrick(w::World, x::Vector{Float64},
                    timeaxis::Vector{Float64}, f0::Vector{Float64})
    cheaptrick(x, w.fs, timeaxis, f0)
end

function platinum(w::World, x::Vector{Float64},
                  timeaxis::Vector{Float64}, f0::Vector{Float64},
                  spectrogram::Matrix{Float64})
    platinum(x, w.fs, timeaxis, f0, spectrogram)
end

function synthesis(w::World, f0::Vector{Float64},
                   spectrogram::Matrix{Float64},
                   residual::Matrix{Float64}, len::Int)
    synthesis(f0, spectrogram, residual, w.framePeriod,  w.fs, len)
end

function aperiodicityratio(w::World, x::Vector{Float64},
                           f0::Vector{Float64},timeaxis::Vector{Float64})
    aperiodicityratio(x, w.fs, f0, timeaxis)
end

function synthesisFromAperiodicity(w::World, f0::Vector{Float64},
                                   spectrogram::Matrix{Float64},
                                   aperiodicity::Matrix{Float64}, len::Int)
    synthesisFromAperiodicity(f0, spectrogram, aperiodicity, w.framePeriod,
                              w.fs, len)
end

end # module WORLD