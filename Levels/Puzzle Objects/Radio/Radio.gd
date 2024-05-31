class_name Radio

signal _channel_state_changed(channel, state)

const channel_count: int = 8

enum Channel {Channel_1 = 0, Channel_2 = 1, Channel_3 = 2, Channel_4 = 3, Channel_5 = 4, Channel_6 = 5, Channel_7 = 6, Channel_8 = 7}

static var channel_states: Array[int] = []

func _init():
    channel_states.resize(channel_count)
    channel_states.fill(0)

static var singleton := Radio.new()
static var channel_state_changed := Signal(singleton._channel_state_changed)

static func updateChannel(channel, sig):
    if sig:
        channel_states[channel] += 1
    else:
        channel_states[channel] -= 1
    if (channel_states[channel] == 0): channel_state_changed.emit(channel, false)
    if (channel_states[channel] == 1): channel_state_changed.emit(channel, true)