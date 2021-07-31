--[[
$module graphics

graphics module
--]]

local graphics = {}

--[[
% clear(clearDepth, depthValue, clearStencil, stencilValue, clearTarget, targetColor)

Used to clear render depth, stenil and target buffers.

@ clearDepth (boolean) whether to clear depth or not
@ depthValue (number) depth value
@ clearStencil (boolean) whether to clear stencil or not
@ stencilValue (number) stencil value
@ clearTarget (boolean) whether to clear target or not
@ targetColor (color4) target color

: (boolean) Whether or not the operation succeeded
--]]
function graphics.clear(clearDepth, depthValue, clearStencil, stencilValue, clearTarget, targetColor)
	return renderClear(clearDepth, depthValue, clearStencil, stencilValue, clearTarget, targetColor)
end

--[[
% beginScene()

Used to denote start of rendering calls.

: (boolean) Whether or not the operation succeeded
--]]
function graphics.beginScene()
	return renderBeginScene()
end

--[[
% endScene()

Used to denote end of rendering calls.

: (boolean) Whether or not the operation succeeded
--]]
function graphics.endScene()
	return renderEndScene()
end

--[[
% loadTexture(path)

Used to load a texture from given path into memory and bind to the GPU. Current supported image types are [bmp, gif, hdr, jpg, pic, png, pnm, psd, tga].

@ path (string) path of image to load

: (integer) ID of texture, otherwise 0
--]]
function graphics.loadTexture(path)
	return renderLoadTexture(path)
end

--[[
% activateTexture(textureId)

Used to activate texture when about to draw a mesh.

@ path (string) path of image to load

: (boolean) Whether or not the operation succeeded
--]]
function graphics.activateTexture(textureId)
	return renderActivateTexture(textureId)
end

--[[
% deleteTexture(textureId)

Used to unbind texture from GPU and remove from memory.

@ textureId (integer) ID of texture

: (boolean) Whether or not the operation succeeded
--]]
function graphics.deleteTexture(textureId)
	return renderDeleteTexture(textureId)
end

--[[
% loadMeshCollection(path)

Used to load a mesh collection from given path into memory. Current supported mesh file types are [glb, gltf, xm, obj].

@ path (string) path of mesh to load

: (integer) ID of mesh collection, otherwise 0
--]]
function graphics.loadMeshCollection(path)
	return renderLoadMeshCollection(path)
end

--[[
% createSheetMeshCollection(x, y, z, width, height, rows, cols)

Used to create a mesh collection into memory consising of a single mesh. The mesh is divided in a number of rows and columns. Each cell is an individual quad.

@ x (number) x position
@ y (number) y position
@ z (number) z position
@ width (number) width
@ height (number) height
@ width (number) width
@ cols (number) cols

: (integer) ID of mesh collection, otherwise 0
--]]
function graphics.createSheetMeshCollection(x, y, z, width, height, rows, cols)
	return renderCreateSheetMeshCollection(x, y, z, width, height, rows, cols)
end

--[[
% createPlaneXYMeshCollection(x, y, z, width, height, rows, cols)

Used to create a mesh collection into memory consising of a single mesh. The mesh is divided in a number of rows and columns. Each cell is connected to the next.

@ x (number) x position
@ y (number) y position
@ z (number) z position
@ width (number) width
@ height (number) height
@ width (number) width
@ cols (number) cols

: (integer) ID of mesh collection, otherwise 0
--]]
function graphics.createPlaneXYMeshCollection(x, y, z, width, height, rows, cols)
	return renderCreatePlaneXYMeshCollection(x, y, z, width, height, rows, cols)
end

--[[
% createMeshCollection()

Used to create a empty mesh collection in memory.

: (integer) meshCollectionId of mesh collection, otherwise 0
--]]
function graphics.createMeshCollection()
	return renderCreateMeshCollection()
end

--[[
% deleteTexture(meshCollectionId)

Used to unbind mesh collection from GPU and remove from memory.

@ meshCollectionId (integer) ID of mesh collection

: (boolean) Whether or not the operation succeeded
--]]
function graphics.deleteMeshCollection(meshCollectionId)
	return renderDeleteMeshCollection(meshCollectionId)
end

--[[
% createMeshCollection()

Used to create a empty mesh in memory and add to a given mesh collection.

@ meshCollectionId (integer) ID of mesh collection to add to

: (integer) ID of mesh, otherwise 0
--]]
function graphics.createMesh(meshCollectionId)
	return renderCreateMesh(meshCollectionId)
end

--[[
% clearMesh(meshCollectionId, meshId)

Used to clear a mesh in memory for a given mesh collection and mesh.

@ meshCollectionId (integer) ID of mesh collection
@ meshId (integer) ID of mesh

: (integer) ID of mesh, otherwise 0
--]]
function graphics.clearMesh(meshCollectionId, meshId)
	return renderClearMesh(meshCollectionId, meshId)
end

--[[
% addMeshData(meshCollectionId, meshId, vertices, indicies)

Used to add vertices and indices to a mesh in memory for a given mesh collection and mesh.

@ meshCollectionId (integer) ID of mesh collection
@ meshId (integer) ID of mesh
@ vertices (vertexArray) collection of vertices
@ [optional] indicies (indexArray) collection of indicies

: (boolean) Whether or not the operation succeeded
--]]
function graphics.addMeshData(meshCollectionId, meshId, vertices, indicies)
	return renderAddMeshData(meshCollectionId, meshId, vertices, indicies)
end

--[[
% getMeshData(meshCollectionId, meshId)

Used to get vertex and index arrays for a given mesh collection and mesh.

@ meshCollectionId (integer) ID of mesh collection
@ meshId (integer) ID of mesh

: (vertexArray) Collection of vertices
: (indexArray) Collection of indicies if exists otherwise nil
--]]
function graphics.getMeshData(meshCollectionId, meshId)
	return renderGetMeshData(meshCollectionId, meshId)
end

--[[
% bindMesh(meshCollectionId, meshId)

Used to bind mesh in memory to the GPU.

@ meshCollectionId (integer) ID of mesh collection
@ meshId (integer) ID of mesh

: (boolean) Whether or not the operation succeeded
--]]
function graphics.bindMesh(meshCollectionId, meshId)
	return renderBindMesh(meshCollectionId, meshId)
end

--[[
% activateMesh(meshCollectionId, meshId)

Used to activate mesh when about to draw a mesh.

@ meshCollectionId (integer) ID of mesh collection
@ meshId (integer) ID of mesh

: (boolean) Whether or not the operation succeeded
--]]
function graphics.activateMesh(meshCollectionId, meshId)
	return renderActivateMesh(meshCollectionId, meshId)
end

--[[
% getMeshName(meshCollectionId, meshId)

Used to get mesh name for a given mesh collection and mesh.

@ meshCollectionId (integer) ID of mesh collection
@ meshId (integer) ID of mesh

: (matrix4) transform matrix for mesh
--]]
function graphics.getMeshName(meshCollectionId, meshId)
	return renderGetMeshName(meshCollectionId, meshId)
end

--[[
% getMeshTransform(meshCollectionId, meshId)

Used to get tranform matrix for a given mesh collection and mesh.

@ meshCollectionId (integer) ID of mesh collection
@ meshId (integer) ID of mesh

: (matrix4) transform matrix for mesh
--]]
function graphics.getMeshTransform(meshCollectionId, meshId)
	local m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44 = renderGetMeshTransform(meshCollectionId, meshId)
	return matrix4.new(m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44)
end

--[[
% getMeshInfo(meshCollectionId, meshId)

Used to get index offset and count for a given mesh collection and mesh.

@ meshCollectionId (integer) ID of mesh collection
@ meshId (integer) ID of mesh

: (integer) index offset
: (integer) index count
--]]
function graphics.getMeshInfo(meshCollectionId, meshId)
	return renderGetMeshInfo(meshCollectionId, meshId)
end

--[[
% getMeshIndices(meshCollectionId)

Used to get collecyion of mesh ID's from a given mesh collection.

@ meshCollectionId (integer) ID of mesh collection

: (indexArray) Collection of mesh ID's
--]]
function graphics.getMeshIndices(meshCollectionId)
	return renderGetMeshIndices(meshCollectionId)
end

--[[
% getChildMeshIndices(meshCollectionId, parentMeshId)

Used to get collecyion of mesh ID's from a given mesh collection and parent mesh.

@ meshCollectionId (integer) ID of mesh collection
@ parentMeshId (integer) ID of parent mesh, 0 for root level

: (indexArray) Collection of mesh ID's
--]]
function graphics.getChildMeshIndices(meshCollectionId, parentMeshId)
	return renderGetChildMeshIndices(meshCollectionId, parentMeshId)
end

--[[
% loadFont(path)

Used to load a font from given path into memory and bind to the GPU. Current supported font types are [fnt].

@ path (string) path of image to load

: (integer) ID of font, otherwise 0
--]]
function graphics.loadFont(path)
	return renderLoadFont(path)
end

--[[
% drawFont(fontId, position, message)

Draws font to current render buffer

@ fontId (integer) ID of font 
@ position (vector3) position
@ message (string) message

: (boolean) Whether or not the operation succeeded
--]]
function graphics.drawFont(fontId, position, message)
	return renderDrawFont(fontId, position, message)
end

--[[
% measureFont(fontId, message)

Measures font message size.

@ fontId (integer) ID of font 
@ message (string) message

: (integer) width
: (integer) height
--]]
function graphics.measureFont(fontId, message)
	return renderMeasureFont(fontId, message)
end

--[[
% setModelMatrix(modelMatrix)

Sets current shader model matrix.

@ modelMatrix (matrix4) model matrix

: (boolean) Whether or not the operation succeeded
--]]
function graphics.setModelMatrix(modelMatrix)
	return renderSetModelMatrix(modelMatrix)
end

--[[
% setViewMatrix(viewMatrix)

Sets current shader view matrix.

@ modelMatrix (matrix4) view matrix

: (boolean) Whether or not the operation succeeded
--]]
function graphics.setViewMatrix(value)
	return renderSetViewMatrix(value)
end

--[[
% setProjectionMatrix(projectionMatrix)

Sets current shader projection matrix.

@ modelMatrix (matrix4) projection matrix

: (boolean) Whether or not the operation succeeded
--]]
function graphics.setProjectionMatrix(projectionMatrix)
	return renderSetProjectionMatrix(projectionMatrix)
end

--[[
% drawMesh(indexOffset, indexCount)

Draws current active mesh and texture, with given index pffset and count.

@ indexOffset (integer) index offset
@ indexCount (integer) index count

: (boolean) Whether or not the operation succeeded
--]]
function graphics.drawMesh(indexOffset, indexCount)
	return renderDrawMesh(indexOffset, indexCount)
end

--[[
% getWidth()

Gets current render buffer width.

: (integer) width
--]]
function graphics.getWidth()
	return renderGetWidth()
end

--[[
% getHeight()

Gets current render buffer height.

: (integer) height
--]]
function graphics.getHeight()
	return renderGetHeight()
end

--[[
% disableDepth()

Disables depth testing

: (boolean) Whether or not the operation succeeded
--]]
function graphics.disableDepth()
	return renderDisableDepth()
end

--[[
% enableDepth()

Enables depth testing

: (boolean) Whether or not the operation succeeded
--]]
function graphics.enableDepth()
	return renderEnableDepth()
end

--[[
% cullingMode(mode)

Enables culling

@ cullingMode (integer) culling mode

: (boolean) Whether or not the operation succeeded
--]]
function graphics.cullingMode(cullingMode)
	return renderCullingMode(cullingMode)
end

--[[
% enableLights()

Enables lights

: (boolean) Whether or not the operation succeeded
--]]
function graphics.enableLights()
	return renderEnableLights()
end

--[[
% disableLights()

Disables lights

: (boolean) Whether or not the operation succeeded
--]]
function graphics.disableLights()
	return renderDisableLights()
end

--[[
% enableLight(lightId, position, distance, color)

Enables light

@ lightId (integer) ID of light
@ position (vector3) position
@ distance (number) distance
@ color (color4) color

: (boolean) Whether or not the operation succeeded
--]]
function graphics.enableLight(lightId, position, distance, color)
	return renderEnableLight(lightId, position, distance, color)
end

--[[
% disableLight(lightId)

Disable light

@ lightId (integer) ID of light

: (boolean) Whether or not the operation succeeded
--]]
function graphics.disableLight(lightId)
	return renderDisableLight(lightId)
end

--[[
% setAmbientLight(color)

Sets ambient light

@ color (color3) color

: (boolean) Whether or not the operation succeeded
--]]
function graphics.setAmbientLight(color)
	return renderSetAmbientLight(color)
end

--[[
% setViewport(x, y, width, height)

Sets current viewport

@ x (number) x position
@ y (number) y position
@ width (number) width
@ height (number) height

: (boolean) Whether or not the operation succeeded
--]]
function graphics.setViewport(x, y, width, height)
	return renderSetViewport(x, y, width, height)
end

--[[
% enableScissor(x, y, width, height)

Enables scissor mode

@ x (number) x position
@ y (number) y position
@ width (number) width
@ height (number) height

: (boolean) Whether or not the operation succeeded
--]]
function graphics.enableScissor(x, y, width, height)
	return renderEnableScissor(x, y, width, height)
end

--[[
% disableScissor()

Disables scissor

: (boolean) Whether or not the operation succeeded
--]]
function graphics.disableScissor()
	return renderDisableScissor()
end

--[[
% disableFog()

Disables fog

: (boolean) Whether or not the operation succeeded
--]]
function graphics.disableFog()
	return renderDisableFog()
end

--[[
% enableLinearFog(color, fogStart, fogEnd)

Enables linear fog

@ color (color3) fog color
@ fogStart (number) fog start value
@ fogEnd (number) fog end value

: (boolean) Whether or not the operation succeeded
--]]
function graphics.enableLinearFog(color, fogStart, fogEnd)
	return renderEnableLinearFog(color, fogStart, fogEnd)
end

--[[
% enableExponentialFog(color, density)

Enables exponential fog

@ color (color3) fog color
@ density (number) fog density

: (boolean) Whether or not the operation succeeded
--]]
function graphics.enableExponentialFog(color, density)
	return renderEnableExponentialFog(color, density)
end

--[[
% enableExponentialSquaredFog(color, density)

Enables exponential squared fog

@ color (color3) fog color
@ density (number) fog density

: (boolean) Whether or not the operation succeeded
--]]
function graphics.enableExponentialSquaredFog(color, density)
	return renderEnableExponentialSquaredFog(color, density)
end

--[[
% setColorTint(color)

Sets color tint

@ color (color4) color

: (boolean) Whether or not the operation succeeded
--]]
function graphics.setColorTint(tint)
	return renderSetColorTint(tint)
end

--[[
% enableBlend(blendOp, sFactor, dFactor)

Enables blending

@ blendOp (integer) blend operarton
@ sFactor (integer) source blend factor
@ dFactor (integer) dest blend factor

: (boolean) Whether or not the operation succeeded
--]]
function graphics.enableBlend(blendOp, sFactor, dFactor)
	return renderEnableBlend(blendOp, sFactor, dFactor)
end

--[[
% disableBlend()

Disables blending

: (boolean) Whether or not the operation succeeded
--]]
function graphics.disableBlend()
	return renderDisableBlend()
end

--[[
% drawNinePatch(textureId, position, width, height, cornerPercentX, cornerPercentY)

Draws nine patch mesh

@ textureId (integer) index offset
@ position (vector3) position
@ width (number) width
@ height (number) height
@ cornerPercentX (number) X axis corner percentage of width
@ cornerPercentY (number) Y axis corner percentage of height

: (boolean) Whether or not the operation succeeded
--]]
function graphics.drawNinePatch(textureId, position, width, height, cornerPercentX, cornerPercentY)
	return renderDrawNinePatch(textureId, position, width, height, cornerPercentX, cornerPercentY)
end

--[[
% swapBuffers()

Swaps current render buffer.

: (boolean) Whether or not the operation succeeded
--]]
function graphics.swapBuffers()
	return renderSwapBuffers()	
end

graphics.CullingMode = {
	['None'] = 0,
	['Front'] = 1,
	['Back'] = 2
}

graphics.BlendOp = {
	['Add'] = 0,
	['Subtract'] = 1,
	['InvSubtract'] = 2
}

graphics.BlendFactor = {
	['Zero'] = 0,
	['One'] = 1,
	['SrcColor'] = 2,
	['OneMinusSrcColor'] = 3,
	['DstColor'] = 4,
	['OneMinusDstColor'] = 5,
	['SrcAlpha'] = 6,
	['OneMinusSrcAlpha'] = 7,
	['DstAlpha'] = 8,
	['OneMinusDstAlpha'] = 9,
	['ConstantColor'] = 10,
	['OneMinusConstantColor'] = 11,
	['ConstantAlpha'] = 12,
	['OneMinusConstantAlpha'] = 13,
	['AlphaSaturate'] = 14
}

return graphics