--[[
$module matrix4

matrix4 module
--]]

local matrix4 = {}

local assert = assert
local getmetatable = getmetatable
local setmetatable = setmetatable

local matrixTable = {

	__metatable = 'matrix4.metatable',

	__index = function(this, index)
		return this[index:upper()] or this[index:lower()]
	end,

	__mul = function(this, secondMatrix)
		assert(getmetatable(secondMatrix) == 'matrix4.metatable', 'You can only multiply a matrix4 with another matrix4.')
		local m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44 = secondMatrix.m11, secondMatrix.m12, secondMatrix.m13, secondMatrix.m14, secondMatrix.m21, secondMatrix.m22, secondMatrix.m23, secondMatrix.m24, secondMatrix.m31, secondMatrix.m32, secondMatrix.m33, secondMatrix.m34, secondMatrix.m41, secondMatrix.m42, secondMatrix.m43, secondMatrix.m44
		m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44 = mathMultiplyMatrix4x4(this.m11, this.m12, this.m13, this.m14, this.m21, this.m22, this.m23, this.m24, this.m31, this.m32, this.m33, this.m34, this.m41, this.m42, this.m43, this.m44, m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44)
		return matrix4.new(m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44)
	end,

	__tostring = function(this)
		return ('matrix4 %f, %f, %f, %f %f, %f, %f, %fm %f, %f, %f, %f %f, %f, %f, %f'):format(this.m11, this.m12, this.m13, this.m14, this.m21, this.m22, this.m23, this.m24, this.m31, this.m32, this.m33, this.m34, this.m41, this.m42, this.m43, this.m44)
	end

}

function matrix4.new(m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44)
	
	this = {}

	this.m11 = m11 or 1
	this.m12 = m12 or 0
	this.m13 = m13 or 0
	this.m14 = m14 or 0
	this.m21 = m21 or 0
	this.m22 = m22 or 1
	this.m23 = m23 or 0
	this.m24 = m24 or 0
	this.m31 = m31 or 0
	this.m32 = m32 or 0
	this.m33 = m33 or 1
	this.m34 = m34 or 0
	this.m41 = m41 or 0
	this.m42 = m42 or 0
	this.m43 = m43 or 0
	this.m44 = m44 or 1

    function this.unpack()
		return (this.m11) (this.m12) (this.m13) (this.m14) (this.m21) (this.m22) (this.m23) (this.m24) (this.m31) (this.m32) (this.m33) (this.m34) (this.m41) (this.m42) (this.m43) (this.m44)
	end

	return setmetatable(this, matrixTable)

end

function matrix4.scale(x, y, z)

	local m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44 = mathScaleMatrix4x4(x, y, z)
	return matrix4.new(m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44)

end

function matrix4.rotateX(radians)

	local m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44 = mathRotateXMatrix4x4(radians)
	return matrix4.new(m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44)

end

function matrix4.rotateY(radians)

	local m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44 = mathRotateYMatrix4x4(radians)
	return matrix4.new(m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44)

end

function matrix4.rotateZ(radians)

	local m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44 = mathRotateZMatrix4x4(radians)
	return matrix4.new(m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44)

end

function matrix4.translate(x, y, z)

	local m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44 = mathTranslateMatrix4x4(x, y, z)
	return matrix4.new(m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44)

end

function matrix4.transpose(matrix4)

	local m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44 = mathTransposeMatrix4x4(matrix4.m11, matrix4.m12, matrix4.m13, matrix4.m14, matrix4.m21, matrix4.m22, matrix4.m23, matrix4.m24, matrix4.m31, matrix4.m32, matrix4.m33, matrix4.m34, matrix4.m41, matrix4.m42, matrix4.m43, matrix4.m44)
	return matrix4.new(m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44)

end

function matrix4.invertMatrix4x4(matrix4)

	local m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44 = mathInvertMatrix4x4(matrix4.m11, matrix4.m12, matrix4.m13, matrix4.m14, matrix4.m21, matrix4.m22, matrix4.m23, matrix4.m24, matrix4.m31, matrix4.m32, matrix4.m33, matrix4.m34, matrix4.m41, matrix4.m42, matrix4.m43, matrix4.m44)
	return matrix4.new(m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44)

end

function matrix4.lookAt(eye, target, up)

	local m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44 = mathLookAtMatrix4x4(eye, target, up)
	return matrix4.new(m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44)

end

function matrix4.orthoOffCenter(left, right, bottom, top, zner, zfar)

	local m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44 = mathOrthoOffCenterMatrix4x4(left, right, bottom, top, zner, zfar)
	return matrix4.new(m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44)

end

function matrix4.ortho(width, height, zner, zfar)

	local m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44 = mathOrthoMatrix4x4(width, height, zner, zfar)
	return matrix4.new(m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44)

end

function matrix4.perspective(fovRadians, aspectRatio, zner, zfar)

	local m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44 = mathPerspectiveMatrix4x4(fovRadians, aspectRatio, zner, zfar)
	return matrix4.new(m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44)

end

return matrix4