# Waveform.gd
extends Node2D

@export var osc : NodePath
var samples = []

func _process(_delta):
    var playback = get_node(osc).playback
    samples.clear()
    # Collect a small buffer
    for i in range(200):
        var val = sin((i / 200.0) * TAU * 4.0) # placeholder
        samples.append(val)
    queue_redraw()

func _draw():
    var width = get_viewport_rect().size.x
    var height = get_viewport_rect().size.y * 0.5
    var points = []
    for i in range(samples.size()):
        points.append(Vector2(i * width / samples.size(), height - samples[i] * height))
    draw_polyline(points, Color.CYAN, 2)
