extends Control

@export var oscillator : NodePath
@onready var label = $Label
@onready var slider = $HSlider

func _ready():
    # Correct connection using Callable
    slider.connect("value_changed", Callable(self, "_on_HSlider_value_changed"))

func _on_HSlider_value_changed(value):
    var osc_node = get_node_or_null(oscillator)
    if osc_node:
        osc_node.frequency = value
    # round to 1 decimal
    label.text = str(round(value * 10) / 10.0) + " Hz"
