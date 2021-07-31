--[[
$module vector4

vector4 module
--]]

local vector4 = {}

local assert = assert
local getmetatable = getmetatable
local setmetatable = setmetatable

local vectorTable = {

	__metatable = 'vector4.metatable',

	__index = function(this, index)
		return this[index:upper()] or this[index:lower()]
	end,

	__add = function(this, secondVector)
		assert(getmetatable(secondVector) == 'vector4.metatable' or type(secondVector) == 'number', 'You can only add a vector4 with another vector4 or a number.')
		local x, y, z, w
		if getmetatable(secondVector) == 'vector4.metatable' then
			x, y, z, w = secondVector.x, secondVector.y, secondVector.z, secondVector.w
		else
			x, y, z, w = secondVector, secondVector, secondVector, secondVector
		end
		x, y, z, w = mathAddVector4(this.x, this.y, this.z, this.w, x, y, z, w)
		return vector4.new(x, y, z, w)
	end,

	__sub = function(this, secondVector)
		assert(getmetatable(secondVector) == 'vector4.metatable' or type(secondVector) == 'number', 'You can only sub a vector4 with another vector4 or a number.')
		local x, y, z, w
		if getmetatable(secondVector) == 'vector4.metatable' then
			x, y, z, w = secondVector.x, secondVector.y, secondVector.z, secondVector.w
		else
			x, y, z, w = secondVector, secondVector, secondVector, secondVector
		end
		x, y, z, w = mathSubtractVector4(this.x, this.y, this.z, this.w, x, y, z, w)
		return vector4.new(x, y, z, w)
	end,

	__mul = function(this, secondVector)
		assert(getmetatable(secondVector) == 'vector4.metatable' or type(secondVector) == 'number', 'You can only multiply a vector4 with another vector4 or a number.')
		local x, y, z, w
		if getmetatable(secondVector) == 'vector4.metatable' then
			x, y, z, w = secondVector.x, secondVector.y, secondVector.z, secondVector.w
		else
			x, y, z, w = secondVector, secondVector, secondVector, secondVector
		end
		x, y, z, w = mathMultiplyVector4(this.x, this.y, this.z, this.w, x, y, z, w)
		return vector4.new(x, y, z, w)
	end,

	__div = function(this, secondVector)
		assert(getmetatable(secondVector) == 'vector4.metatable' or type(secondVector) == 'number', 'You can only divide a vector4 with another vector4 or a number.')
		local x, y, z, w
		if getmetatable(secondVector) == 'vector4.metatable' then
			x, y, z, w = secondVector.x, secondVector.y, secondVector.z, secondVector.w
		else
			x, y, z, w = secondVector, secondVector, secondVector, secondVector
		end
		x, y, z, w = mathDivideVector4(this.x, this.y, this.z, this.w, x, y, z, w)
		return vector4.new(x, y, z, w)
	end,

	__tostring = function(this)
		return ('vector4 %f, %f, %f, %f'):format(this.x, this.y, this.z, this.w)
	end

}

--[[
% new(x, y, z, w)

Used to create a new vector4.

@ x (number) x element
@ y (number) y element
@ z (number) z element
@ w (number) w element

: (vector4) vector
--]]
function vector4.new(x, y, z, w)
	
	this = {}

	this.x = x or 0
	this.y = y or 0
	this.z = z or 0
	this.w = w or 0

--[[
% unpack()

Used to unpack vector into its 4 elements.

: (number) x element
: (number) y element
: (number) z element
: (number) w element
--]]
    function this.unpack()
		return (this.x) (this.y) (this.z) (this.w)
	end

--[[
% lerp(secondVector, alpha)

Used to interpolate between vector value and an other

: (vector4) vector
--]]
	function this.lerp(secondVector, alpha)
		local alpha = type(alpha) == 'number' and alpha or 0
		return vector4.new((secondVector.x - this.x) * alpha + this.x, (secondVector.y - this.y) * alpha + this.y, (secondVector.z - this.z) * alpha + this.z, (secondVector.w - this.w) * alpha + this.w)
	end

--[[
% invertY(value)

Used to offset y value e.g. value - y.

@ [optional] value (number) defaults to 0

: (vector4) vector
--]]
	function this.invertY(value)
		local yOffset = value or renderGetHeight()
		return vector4.new(this.x, yOffset - this.y, this.z, this.w)
	end		

--[[
% invertX(value)

Used to offset x value e.g. value - x.

@ [optional] value (number) defaults to 0

: (vector4) vector
--]]
	function this.invertX(value)
		local xOffset = value or 0
		return vector4.new(xOffset - this.x, this.y, this.z, this.w)
	end		

	return setmetatable(this, vectorTable)

end

return vector4