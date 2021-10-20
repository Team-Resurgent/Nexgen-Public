--[[
$module sound

sound module
--]]

local sound = {}

--[[
% load(path)

Used to load a sound from given path into memory. Current supported formats are [wav].

@ path (string) path of sound to load

: (integer) ID of sound, otherwise 0
--]]
function sound.load(path)
	return soundLoad(path)
end

--[[
% play(soundId)

Used to start playing sound from memory.

@ soundId (integer) ID of sound

: (boolean) Whether or not the operation succeeded
--]]
function sound.play(soundId)
	return soundPlay(soundId)
end

--[[
% stop(soundId)

Used to stop playing sound from memory.

@ soundId (integer) ID of sound

: (boolean) Whether or not the operation succeeded
--]]
function sound.stop(soundId)
	return soundStop(soundId)
end

--[[
% isPlaying(soundId)

Used to check if sound is still playing.

@ soundId (integer) ID of sound

: (boolean) Whether or not the operation succeeded
--]]
function sound.isPlaying(soundId)
	return soundIsPlaying(soundId)
end

--[[
% getVolume(soundId)

Used to get volume of sound.

@ soundId (integer) ID of sound

: (number) Sound volume percent 0 to 1 for left channel
: (number) Sound volume percent 0 to 1 for right channel
--]]

function sound.getVolume(soundId)
	return soundGetVolume(soundId)
end

--[[
% setVolume(soundId, percent)

Used to set volume of sound.

@ soundId (integer) ID of sound
@ percentLeft (number) sound volume percent 0 to 1 for left channel
@ percentRight (number) sound volume percent 0 to 1 for right channel

: (boolean) Whether or not the operation succeeded
--]]

function sound.setVolume(soundId, percentLeft, percentRight)
	return soundSetVolume(soundId, percentLeft, percentRight or percentLeft)
end

--[[
% setRepeat(soundId, count)

Used to set repeat flag on sound (should be called before play).

@ soundId (integer) ID of sound
@ count (integer) times to repeat, -1 to repeat for ever

: (boolean) Whether or not the operation succeeded
--]]

function sound.setRepeat(soundId, count)
	return soundSetRepeat(soundId, count)
end

--[[
% delete(soundId)

Used to delete sound from memory.

@ soundId (integer) ID of sound

: (boolean) Whether or not the operation succeeded
--]]
function sound.delete(soundId)
	return soundDelete(soundId)
end

return sound