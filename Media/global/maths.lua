--[[
$module maths

maths module
--]]

local maths = {}

--[[
% degreesToRadians()

Used to convert a degrees value to radians.

@ degrees (number) degrees value

: (number) value converted to radians
--]]
function maths.degreesToRadians(degrees)
	return mathDegreesToRadians(degrees)
end

return maths