--[[
$module controller

controller module
--]]

local controller = {}

--[[
% getButtonStateAndValue(port, buttonId)

Used to get controller button state and value.

@ port (integer) controller port
@ buttonId (integer) controller button

: (integer) button state
: (number) value in range 0 to 1
--]]
function controller.getButtonStateAndValue(port, buttonId)
	return controllerGetButtonStateAndValue(port, buttonId)
end

--[[
% isButtonDown(port, buttonId)

Used to get button down state.

@ port (integer) controller port
@ buttonId (integer) controller button

: (boolean) Whether button is down or not
--]]
function controller.isButtonDown(port, buttonId)
	return controllerGetButtonState(port, buttonId) == 1
end

--[[
% isButtonHeld(port, buttonId)

Used to get button held down state.

@ port (integer) controller port
@ buttonId (integer) controller button

: (boolean) Whether button is being held down or not
--]]
function controller.isButtonHeld(port, buttonId)
	return controllerGetButtonState(port, buttonId) == 2
end

--[[
% isButtonUp(port, buttonId)

Used to get button button released state.

@ port (integer) controller port
@ buttonId (integer) controller button

: (boolean) Whether button has been released or not
--]]
function controller.isButtonUp(port, buttonId)
	return controllerGetButtonState(port, buttonId) == 3
end

--[[
% getButtonValue(port, buttonId)

Used to get controller button value.

@ port (integer) controller port
@ buttonId (integer) controller button

: (number) value in range 0 to 1
--]]
function controller.getButtonValue(port, buttonId)
	return controllerGetButtonValue(port, buttonId)
end

--[[
% Button['buttonId']


Collection of button Id values to number. Example: controller.Button['DpadDown']


@ DpadUp (string) controller Dpad Up button Id = 1
@ DpadDown (string) controller Dpad Down button Id = 2
@ DpadLeft (string) controller Dpad Left button Id = 3
@ DpadRight (string) controller Dpad Right button Id = 4
@ Start (string) controller Start button Id = 5
@ Back (string) controller Back button Id = 6
@ LeftThumb (string) controller Left Thumb button Id = 7
@ RightThumb (string) controller Right Thumb button Id = 8
@ LeftShoulder (string) controller Left Shoulder button Id = 9
@ RightShoulder (string) controller Right Shoulder button Id = 10
@ A (string) controller A button Id = 11
@ B (string) controller B button Id = 12
@ X (string) controller X button Id = 13
@ Y (string) controller Y button Id = 14
@ Black (string) controller Black button Id = 15
@ White (string) controller White button Id = 16
@ LeftTrigger (string) controller Left Trigger button Id = 17
@ RightTrigger (string) controller Right Trigger button Id = 18
@ LeftStickX (string) controller Left Stick X analog stick Id = 19
@ LeftStickY (string) controller Left Stick Y analog stick Id = 20
@ RightStickX (string) controller Right Stick X analog stick Id = 21
@ RightStickY (string) controller Right Stick Y analog stick Id = 22


--]]
controller.Button = {
	['DpadUp'] = 1,
	['DpadDown'] = 2,
	['DpadLeft'] = 3,
	['DpadRight'] = 4,
	['Start'] = 5,
	['Back'] = 6,
	['LeftThumb'] = 7,
	['RightThumb'] = 8,
	['LeftShoulder'] = 9,
	['RightShoulder'] = 10,
	['A'] = 11,
	['B'] = 12,
	['X'] = 13,
	['Y'] = 14,
	['Black'] = 15,
	['White'] = 16,
	['LeftTrigger'] = 17,
	['RightTrigger'] = 18,
	['LeftStickX'] = 19,
	['LeftStickY'] = 20,
	['RightStickX'] = 21,
	['RightStickY'] = 22
}

return controller