extends Node

@export var frequency : float = 440.0
@export var volume : float = 0.5

var stream : AudioStreamGenerator
var playback : AudioStreamGeneratorPlayback
var phase : float = 0.0

# Smaller buffer = lower latency
const BUFFER_CHUNK_SIZE = 512

func _ready():
    stream = AudioStreamGenerator.new()
    stream.mix_rate = 48000
    $AudioStreamPlayer.stream = stream
    $AudioStreamPlayer.play()

    playback = $AudioStreamPlayer.get_stream_playback()
    if playback == null:
        push_error("AudioStreamGeneratorPlayback is null!")

func _process(_delta):
    if playback == null:
        return

    var frames_available = playback.get_frames_available()
    var frames_to_push = min(frames_available, BUFFER_CHUNK_SIZE)

    var increment = frequency / stream.mix_rate

    for i in range(frames_to_push):
        var sample = sin(phase * TAU) * volume
        playback.push_frame(Vector2(sample, sample))
        phase = fmod(phase + increment, 1.0)
