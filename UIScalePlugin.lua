-- UIScalePlugin - SetAsync for Radon Labs.
local Toolbar = plugin:CreateToolbar("UIScalePlugin")
local NotesButton = Toolbar:CreateButton("Offset to scale","Change offset to scale.", "rbxassetid://9007592167")
local Selection = game:GetService("Selection")
function IsAUiObject(Object)
	local TestSize
	pcall(function()
		TestSize = Object.AbsoluteSize
	end)
	return (not not TestSize)
end
NotesButton.Click:Connect(function()
	print("UIScalePlugin : Offset to scale.")
	for i,v in pairs(Selection:Get()) do
		if IsAUiObject(v) then
			if not IsAUiObject(v.Parent) then
				error("UIScalePlugin: "..v.Name.."'s Parent is not a UI object, so the scale can not be calculated.")
			else
				if table.concat({v.Size.X.Scale, v.Size.Y.Scale},",") == "0,0" then
					local Offsets = v.Size
					local ScreenSize = v.Parent.AbsoluteSize
					local NewXScale = (Offsets.X.Offset / ScreenSize.X)
					local NewYScale = (Offsets.Y.Offset / ScreenSize.Y)
					v.Size = UDim2.new(NewXScale,0,NewYScale,0)
					print("Scaled "..v.Name..".")
				else
					print("Already scaled. ")
				end
			end
		end
	end
end)
