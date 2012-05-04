local self = {}
VFS.INode = VFS.MakeConstructor (self)

function self:ctor ()
	VFS.EventProvider (self)
end

function self:GetDisplayName ()
	return self:GetName ()
end

function self:GetDisplayPath ()
	local path = self:GetDisplayName ()
	local parent = self:GetParentFolder ()
	
	while parent do
		if path:len () > 1000 then
			error ("INode:GetDisplayPath : Path is too long!")
		end
		if parent:GetDisplayName () ~= "" then
			path = parent:GetDisplayName () .. "/" .. path
		end
		parent = parent:GetParentFolder ()
	end
	
	return path
end

function self:GetName ()
	VFS.Error ("INode:GetName : Not implemented")
    return "[Node]"
end

function self:GetNodeType ()
	VFS.Error ("INode:GetNodeType : Not implemented")
	return VFS.NodeType.Unknown
end

function self:GetOwner ()
	VFS.Error ("INode:GetOwner : Not implemented")
	return GAuth.GetSystemId ()
end

function self:GetParentFolder ()
	VFS.Error ("INode:GetParentFolder : Not implemented")
	return nil
end

function self:GetPermissionBlock ()
	VFS.Error ("INode:GetPermissionBlock : Not implemented")
end

function self:GetPath ()
	local path = self:GetName ()
	local parent = self:GetParentFolder ()
	
	while parent do
		if path:len () > 1000 then
			error ("INode:GetPath : Path is too long!")
		end
		if parent:GetName () ~= "" then
			path = parent:GetName () .. "/" .. path
		end
		parent = parent:GetParentFolder ()
	end
	
	return path
end

function self:IsFile ()
	return self:GetNodeType () & VFS.NodeType.File ~= 0
end

function self:IsFolder ()
	return self:GetNodeType () & VFS.NodeType.Folder ~= 0
end

function self:SetDisplayName (displayName)
end

function self:SetOwner (authId, ownerId, callback)
	VFS.Error ("INode:SetOwner : Not implemented")
	
	callback = callback or VFS.NullCallback
	callback (VFS.ReturnCode.AccessDenied)
end