-- ============================================================
-- ESP HELPERS (migrados de Chilli - sin cambios de lógica)
-- ============================================================

local espSection = nil -- se asigna en Parte 2
local espUi = {}       -- contenedor de referencias UI del ESP

-- Fonts (Chilli style)
local function makeFont(arg, arg2)
	local ok, result = pcall(Font.new, arg, arg2, Enum.FontStyle.Normal)
	return ok and result or nil
end

local espLib = {
	MainFont   = makeFont("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold),
	StatusFont = makeFont("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular),
	Sequence   = function(arg)
		local result = table.create(#arg)
		for i, v in ipairs(arg) do
			result[i] = ColorSequenceKeypoint.new(v[1], v[2])
		end
		return ColorSequence.new(result)
	end,
}

local espColor = Color3.fromRGB
local espSequence = espLib.Sequence
local espPalettes = {}

do
	local gold = {}
	local tbl19 = {}
	local tbl20 = { 0, espColor(255, 231, 158) }
	local tbl21 = { 0.4, espColor(255, 196, 66) }
	local tbl22 = { 1, espColor(214, 142, 12) }
	tbl19[1] = tbl20
	tbl19[2] = tbl21
	tbl19[3] = tbl22
	gold.Text = espSequence(tbl19)
	local tbl23 = {}
	local tbl24 = { 0, espColor(122, 76, 0) }
	local tbl25 = { 0.55, espColor(62, 38, 0) }
	local tbl26 = { 1, espColor(20, 12, 0) }
	tbl23[1] = tbl24
	tbl23[2] = tbl25
	tbl23[3] = tbl26
	gold.Stroke = espSequence(tbl23)
	gold.Outline = espColor(255, 232, 152)
	espPalettes.Gold = gold
end

do
	local orange = {}
	local tbl19 = {}
	local tbl20 = { 0, espColor(255, 198, 132) }
	local tbl21 = { 0.4, espColor(255, 146, 40) }
	local tbl22 = { 1, espColor(206, 92, 0) }
	tbl19[1] = tbl20
	tbl19[2] = tbl21
	tbl19[3] = tbl22
	orange.Text = espSequence(tbl19)
	local tbl23 = {}
	local tbl24 = { 0, espColor(112, 54, 0) }
	local tbl25 = { 0.55, espColor(56, 27, 0) }
	local tbl26 = { 1, espColor(18, 8, 0) }
	tbl23[1] = tbl24
	tbl23[2] = tbl25
	tbl23[3] = tbl26
	orange.Stroke = espSequence(tbl23)
	orange.Outline = espColor(255, 194, 112)
	espPalettes.Orange = orange
end

do
	local red = {}
	local tbl19 = {}
	local tbl20 = { 0, espColor(255, 105, 105) }
	local tbl21 = { 0.4, espColor(255, 28, 40) }
	local tbl22 = { 1, espColor(184, 0, 18) }
	tbl19[1] = tbl20
	tbl19[2] = tbl21
	tbl19[3] = tbl22
	red.Text = espSequence(tbl19)
	local tbl23 = {}
	local tbl24 = { 0, espColor(124, 0, 15) }
	local tbl25 = { 0.55, espColor(61, 0, 9) }
	local tbl26 = { 1, espColor(18, 0, 3) }
	tbl23[1] = tbl24
	tbl23[2] = tbl25
	tbl23[3] = tbl26
	red.Stroke = espSequence(tbl23)
	red.Outline = espColor(255, 128, 138)
	espPalettes.Red = red
end

-- Paletas extra que usa el ESP (Accent, Sheen)
do
	local accent = {}
	local tbl14 = {}
	local tbl15 = { 0, espColor(170, 255, 160) }
	local tbl16 = { 0.45, espColor(58, 255, 55) }
	local tbl17 = { 1, espColor(20, 109, 0) }
	tbl14[1] = tbl15
	tbl14[2] = tbl16
	tbl14[3] = tbl17
	accent.Text = espSequence(tbl14)
	local tbl18 = {}
	local tbl19 = { 0, espColor(10, 52, 6) }
	local tbl20 = { 1, espColor(3, 16, 0) }
	tbl18[1] = tbl19
	tbl18[2] = tbl20
	accent.Stroke = espSequence(tbl18)
	accent.Outline = espColor(58, 255, 55)
	espPalettes.Accent = accent
end

do
	local sheen = {}
	local tbl14 = {}
	local tbl15 = { 0, espColor(255, 255, 255) }
	local tbl16 = { 0.5, espColor(222, 222, 222) }
	local tbl17 = { 1, espColor(255, 255, 255) }
	tbl14[1] = tbl15
	tbl14[2] = tbl16
	tbl14[3] = tbl17
	sheen.Text = espSequence(tbl14)
	local tbl18 = {}
	local tbl19 = { 0, espColor(8, 8, 8) }
	local tbl20 = { 1, espColor(8, 8, 8) }
	tbl18[1] = tbl19
	tbl18[2] = tbl20
	sheen.Stroke = espSequence(tbl18)
	sheen.Outline = espColor(255, 255, 255)
	espPalettes.Sheen = sheen
end

espLib.Palettes = espPalettes

espLib.PaletteFromColor = function(arg)
	local color3 = Color3.new(1, 1, 1)
	local color4 = Color3.new(0, 0, 0)
	local tbl14 = {}
	local sequence2 = espLib.Sequence
	local tbl15 = {}
	local tbl16 = { 0, arg:Lerp(color3, 0.5) }
	local tbl17 = { 0.4, arg:Lerp(color3, 0.1) }
	local tbl18 = { 1, arg:Lerp(color4, 0.25) }
	tbl15[1] = tbl16
	tbl15[2] = tbl17
	tbl15[3] = tbl18
	tbl14.Text = sequence2(tbl15)
	local sequence3 = espLib.Sequence
	local tbl19 = {}
	local tbl20 = { 0, arg:Lerp(color4, 0.55) }
	local tbl21 = { 0.55, arg:Lerp(color4, 0.75) }
	local tbl22 = { 1, arg:Lerp(color4, 0.92) }
	tbl19[1] = tbl20
	tbl19[2] = tbl21
	tbl19[3] = tbl22
	tbl14.Stroke = sequence3(tbl19)
	tbl14.Outline = arg:Lerp(color3, 0.25)
	return tbl14
end

espLib.SizeScale = 1
local espSizeListeners = {}

espLib.OnSizeChanged = function(arg)
	table.insert(espSizeListeners, arg)
end

espLib.SetSizeScale = function(sizeScale)
	if espLib.SizeScale == sizeScale then
		return
	end
	espLib.SizeScale = sizeScale

	for _, v10 in ipairs(espSizeListeners) do
		pcall(v10)
	end
end

espLib.RowHeight = function(arg)
	local currentCamera = workspace.CurrentCamera
	return math.max(6, math.floor(math.clamp((currentCamera and currentCamera.ViewportSize.Y or 1080) * 0.014, 13, 19) * (arg or espLib.SizeScale)))
end

espLib.ScaledWidth = function(arg, arg2)
	return math.max(30, math.floor(arg * (arg2 or espLib.SizeScale)))
end

espLib.CreateRuntime = function()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = randomName()
	screenGui:SetAttribute("PotentOwned", true)
	screenGui.Archivable = false
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.DisplayOrder = 48
	screenGui.Parent = getGuiContainer()
	return screenGui
end

espLib.CreateTag = function(parent, maxDistance)
	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Name = randomName()
	billboardGui.AlwaysOnTop = true
	billboardGui.LightInfluence = 0
	billboardGui.MaxDistance = maxDistance
	local frame = Instance.new("Frame")
	frame.Name = randomName()
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.Size = UDim2.fromScale(1, 1)
	frame.Parent = billboardGui
	local uiListLayout = Instance.new("UIListLayout")
	uiListLayout.Name = randomName()
	uiListLayout.FillDirection = Enum.FillDirection.Vertical
	uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uiListLayout.Parent = frame
	billboardGui.Parent = parent
	return billboardGui, frame
end

espLib.CreateTextRow = function(parent, fontFace, layoutOrder, arg)
	local frame = Instance.new("Frame")
	frame.Name = randomName()
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.Size = UDim2.fromScale(1, arg)
	frame.LayoutOrder = layoutOrder
	frame.Parent = parent

	local function createTextLabel(zIndex)
		local textLabel = Instance.new("TextLabel")
		textLabel.Name = randomName()
		textLabel.BackgroundTransparency = 1
		textLabel.Size = UDim2.fromScale(1, 1)
		textLabel.Text = ""
		textLabel.TextScaled = true
		textLabel.TextStrokeTransparency = 1
		textLabel.TextXAlignment = Enum.TextXAlignment.Center
		textLabel.TextYAlignment = Enum.TextYAlignment.Center
		textLabel.ZIndex = zIndex

		if fontFace then
			textLabel.FontFace = fontFace
		else
			textLabel.Font = Enum.Font.GothamBold
		end

		textLabel.Parent = frame
		return textLabel
	end

	local v10 = createTextLabel(2)
	v10.Position = UDim2.fromOffset(1, 1)
	v10.TextColor3 = Color3.new(0, 0, 0)
	v10.TextTransparency = 0.1
	local v11 = createTextLabel(3)
	v11.TextColor3 = Color3.new(1, 1, 1)
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Name = randomName()
	uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	uiStroke.LineJoinMode = Enum.LineJoinMode.Round
	uiStroke.Color = Color3.new(1, 1, 1)
	uiStroke.Transparency = 0.05

	uiStroke.Thickness = pcall(function()
		uiStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
	end) and 0.05 or 1.2

	uiStroke.Parent = v11
	local uiGradient = Instance.new("UIGradient")
	uiGradient.Name = randomName()
	uiGradient.Rotation = 90
	uiGradient.Parent = uiStroke
	local uiGradient2 = Instance.new("UIGradient")
	uiGradient2.Name = randomName()
	uiGradient2.Rotation = 90
	uiGradient2.Parent = v11
	return { Holder = frame, Shadow = v10, Label = v11, StrokeGradient = uiGradient, TextGradient = uiGradient2, Palette = nil }
end

espLib.SetRow = function(arg, text, palette)
	if arg.Label.Text ~= text then
		arg.Label.Text = text
		arg.Shadow.Text = text
	end

	if arg.Palette ~= palette then
		arg.Palette = palette
		arg.TextGradient.Color = palette.Text
		arg.TextGradient.Rotation = palette.Rotation or 90
		arg.StrokeGradient.Color = palette.Stroke
	end
end

espLib.ReadToggle = function(arg, arg2)
	if type(arg) ~= "table" then
		return arg2 == true
	end

	local ok, result = pcall(function()
		local controller = arg._controller
		return type(controller) == "table" and type(controller.GetValue) == "function" and controller.GetValue()
	end)

	if ok and type(result) == "boolean" then
		return result
	end

	for _, v10 in ipairs({ "Get", "GetValue" }) do
		local ok2, result2 = pcall(function()
			return arg[v10]
		end)

		if ok2 and type(result2) == "function" then
			local ok3, result3 = pcall(result2, arg)
			if ok3 and type(result3) == "boolean" then
				return result3
			end
		end
	end

	return arg2 == true
end

espLib.SyncSoon = function(arg)
	arg()
	task.delay(0.35, arg)
end

espLib.GetGuardAreas = function()
	local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
	world = world and world:FindFirstChild("Areas")
	return world and world:FindFirstChild("GuardAreas")
end

espLib.FindGuardRoot = function(arg)
	local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")
	if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
		return humanoidRootPart
	end

	if arg.PrimaryPart then
		return arg.PrimaryPart
	end
	return arg:FindFirstChildWhichIsA("BasePart", true)
end

espLib.WatchGuards = function(arg)
	local tbl15 = {}
	local v10 = espLib.GetGuardAreas()
	if not v10 then
		return tbl15
	end

	local function fn18(child)
		local guard = child:FindFirstChild("Guard")

		if guard and guard:IsA("Model") then
			arg(child.Name, guard)
		end

		table.insert(tbl15, child.ChildAdded:Connect(function(child2)
			if child2.Name == "Guard" and child2:IsA("Model") then
				arg(child.Name, child2)
			end
		end))
	end

	for _, child in ipairs(v10:GetChildren()) do
		fn18(child)
	end

	table.insert(tbl15, v10.ChildAdded:Connect(fn18))
	return tbl15
end

espLib.DisconnectAll = function(arg)
	for _, v10 in ipairs(arg) do
		pcall(function()
			v10:Disconnect()
		end)
	end

	table.clear(arg)
end

-- ============================================================
-- ASSET INFO HELPERS (tbl7 de Chilli)
-- ============================================================

local espAsset = {}

espAsset.Paint = function(arg, arg2)
	return string.format("<font color=\"%s\">%s</font>", arg, arg2)
end

espAsset.Bold = function(arg)
	return "<b>" .. tostring(arg) .. "</b>"
end

espAsset.Escape = function(arg)
	return (string.gsub(tostring(arg), "[<>&]", { ["<"] = "&lt;", [">"] = "&gt;", ["&"] = "&amp;" }))
end

espAsset.Separator = function()
	return espAsset.Paint("#7A8CC0", "  " .. utf8.char(8226) .. "  ")
end

espAsset.FormatRate = function(arg)
	local n16 = tonumber(arg) or 0
	if n16 >= 1e12 then
		return string.format("%.2fT/s", n16 / 1e12)
	end
	if n16 >= 1e9 then
		return string.format("%.2fB/s", n16 / 1e9)
	end
	if n16 >= 1000000 then
		return string.format("%.2fM/s", n16 / 1000000)
	end
	if n16 >= 1000 then
		return string.format("%.1fK/s", n16 / 1000)
	end
	return string.format("%d/s", math.floor(n16))
end

espAsset.FormatWeight = function(arg)
	local n16 = tonumber(arg) or 0
	local str = n16 >= 1000 and string.format("%.0f", n16) or string.format("%.2f", n16)
	local v20, v21 = string.match(str, "^(%-?%d+)(%.%d+)$")
	v20 = v20 or str
	local v22

	while true do
		local v23
		v22, v23 = string.gsub(v20, "^(%-?%d+)(%d%d%d)", "%1,%2")

		if v23 ~= 0 then
			v20 = v22
		else
			break
		end
	end

	return v22 .. (v21 or "") .. " Kg"
end

espAsset.ScaleFactor = function(arg)
	if arg > 5 then
		return (arg / 5) ^ 1.2 * 19.637875755794113
	end
	return arg ^ 1.85
end

espAsset.MutationMultiplier = function(arg)
	arg = type(arg) == "table" and arg or {}
	local mutations = tbl and tbl.Mutations

	if type(mutations) == "table" and type(mutations.EarningsFor) == "function" then
		local ok, result = pcall(mutations.EarningsFor, arg)
		if ok and type(result) == "number" then
			return result
		end
	end

	return 1
end

local espMutationColors = {
	Golden = "#FFD34D",
	Silver = "#E6EEF7",
	Sakura = "#FF9ED8",
	GreatBloom = "#7CFFC4",
	Boss = "#FF7A7A",
	Monstrous = "#C08BFF",
}

local espRainbow = { "#FF6B6B", "#FFB36B", "#FFF06B", "#6BFF8A", "#6BC8FF", "#B96BFF" }

local espPalettesMut = {
	Golden = espPalettes.Gold,
	Silver = (function()
		local silver = {}
		local sequence2 = espLib.Sequence
		local tbl21 = {}
		local tbl22 = { 0, espColor(255, 255, 255) }
		local tbl23 = { 0.45, espColor(214, 222, 232) }
		local tbl24 = { 1, espColor(150, 160, 175) }
		tbl21[1] = tbl22
		tbl21[2] = tbl23
		tbl21[3] = tbl24
		silver.Text = sequence2(tbl21)
		local sequence3 = espLib.Sequence
		local tbl25 = {}
		local tbl26 = { 0, espColor(60, 66, 78) }
		local tbl27 = { 0.55, espColor(30, 33, 40) }
		local tbl28 = { 1, espColor(10, 11, 14) }
		tbl25[1] = tbl26
		tbl25[2] = tbl27
		tbl25[3] = tbl28
		silver.Stroke = sequence3(tbl25)
		silver.Outline = espColor(214, 222, 232)
		return silver
	end)(),
	Sakura = espLib.PaletteFromColor(espColor(255, 158, 216)),
	GreatBloom = espLib.PaletteFromColor(espColor(124, 255, 196)),
	Boss = espLib.PaletteFromColor(espColor(255, 122, 122)),
	Monstrous = espLib.PaletteFromColor(espColor(192, 139, 255)),
}

do
	local rainbow = {}
	local sequence2 = espLib.Sequence
	local tbl21 = {}
	local tbl22 = { 0, espColor(255, 107, 107) }
	local tbl23 = { 0.2, espColor(255, 179, 107) }
	local tbl24 = { 0.4, espColor(255, 240, 107) }
	local tbl25 = { 0.6, espColor(107, 255, 138) }
	local tbl26 = { 0.8, espColor(107, 200, 255) }
	local tbl27 = { 1, espColor(185, 107, 255) }
	tbl21[1] = tbl22
	tbl21[2] = tbl23
	tbl21[3] = tbl24
	tbl21[4] = tbl25
	tbl21[5] = tbl26
	tbl21[6] = tbl27
	rainbow.Text = sequence2(tbl21)
	local sequence3 = espLib.Sequence
	local tbl28 = {}
	local tbl29 = { 0, espColor(20, 20, 30) }
	local tbl30 = { 1, espColor(8, 8, 12) }
	tbl28[1] = tbl29
	tbl28[2] = tbl30
	rainbow.Stroke = sequence3(tbl28)
	rainbow.Outline = espColor(255, 255, 255)
	rainbow.Rotation = 0
	espPalettesMut.Rainbow = rainbow
end

espAsset.MutationText = function(arg)
	local tbl35 = {}

	if type(arg) == "table" then
		for _, v20 in ipairs(arg) do
			local v21 = string.upper(fn7 and fn7(v20) or tostring(v20))

			if v20 == "Rainbow" or v20 == "Prismatic" then
				local tbl36 = {}

				for i = 1, #v21 do
					table.insert(tbl36, espAsset.Paint(espRainbow[(i - 1) % #espRainbow + 1], string.sub(v21, i, i)))
				end

				table.insert(tbl35, espAsset.Bold(table.concat(tbl36)))
			else
				table.insert(tbl35, espAsset.Bold(espAsset.Paint(espMutationColors[v20] or "#8FE3FF", espAsset.Escape(v21))))
			end
		end
	end

	return table.concat(tbl35, " ")
end

local espRarityGradients = nil

local function espGetRarityGradient(arg)
	if type(arg) == "table" and typeof(arg.RarityGradient) == "Instance" then
		return arg.RarityGradient
	end

	if espRarityGradients == nil then
		local assets = replicatedStorage:FindFirstChild("Assets")
		assets = assets and assets:FindFirstChild("UI")
		espRarityGradients = assets and assets:FindFirstChild("RarityGradients") or false
	end

	if not espRarityGradients or type(arg) ~= "table" then
		return nil
	end
	local v20 = espRarityGradients:FindFirstChild(tostring(arg._id or arg.DisplayName or ""))
	return v20 and v20:FindFirstChild("RarityGradient") or nil
end

local espAssetCache = {}

espAsset.AssetInfo = function(arg)
	local category = tostring(arg)
	local v20 = espAssetCache[category]
	if v20 then
		return v20
	end
	local directory = tbl and tbl.Assets and tbl.Assets.Directory
	local flag11 = type(directory) == "table" and directory[category] or nil

	if flag11 == nil and type(directory) == "table" then
		local v21 = string.gsub(string.lower(category), "[^%a%d]", "")

		for k, v22 in pairs(directory) do
			if type(v22) == "table" then
				local tbl36 = {}
				local str = tostring(k)
				local str2 = tostring(v22._id or "")
				local v23 = tostring
				local displayName = v22.DisplayName or ""
				local v24 = table.pack(v23(displayName))
				tbl36[1] = str
				tbl36[2] = str2

				do
					local values = table.pack(table.unpack(v24, 1, v24.n))
					table.move(values, 1, values.n, 3, tbl36)
				end

				local egg = type(v22.Egg) == "table" and v22.Egg or nil

				if egg ~= nil then
					tbl36[#tbl36 + 1] = tostring(egg.ModelName or "")
				end

				for _, v25 in ipairs(tbl36) do
					if v25 ~= "" and string.gsub(string.lower(v25), "[^%a%d]", "") == v21 then
						flag11 = v22
						break
					end
				end
			end

			if flag11 == nil then
				continue
			end
			break
		end
	end

	local rarity = type(flag11) == "table" and type(flag11.Rarity) == "table" and flag11.Rarity or nil
	local icon = type(flag11) == "table" and flag11.Icon or nil
	local rarity2

	if rarity then
		rarity2 = tostring(rarity.DisplayName or rarity._id or "Common")
	else
		rarity2 = rarity
	end

	rarity2 = rarity2 or "Common"
	local color4 = rarity and typeof(rarity.Color) == "Color3" and rarity.Color or espColor(255, 255, 255)
	local tbl36 = {}
	local name = type(flag11) == "table"

	if name then
		name = tostring(flag11.DisplayName or category)
	end

	tbl36.Name = name or category
	tbl36.Category = category
	tbl36.Rarity = rarity2
	local rarityNumber

	if rarity then
		rarityNumber = tonumber(rarity.RarityNumber or rarity.Rank)
	else
		rarityNumber = rarity
	end

	tbl36.RarityNumber = rarityNumber or 0
	tbl36.Color = color4
	tbl36.Hex = "#" .. string.upper(color4:ToHex())
	tbl36.Gradient = espGetRarityGradient(rarity)
	tbl36.EarningRate = type(flag11) == "table" and tonumber(flag11.EarningRate) or 0
	tbl36.Icon = type(icon) == "string" and icon ~= "" and icon or nil
	espAssetCache[category] = tbl36
	return tbl36
end

espAsset.Income = function(arg, arg2, arg3)
	if type(arg2) ~= "number" or arg2 <= 0 then
		return 0
	end
	return math.max(math.round(arg.EarningRate * espAsset.ScaleFactor(arg2) * espAsset.MutationMultiplier(arg3)), 1)
end

espUi.PalettesMut = espPalettesMut
espUi.Asset = espAsset

-- ============================================================
-- FIN DE LA PARTE 1
-- ============================================================
-- ============================================================
-- ESP COMPLETO (migrado de Chilli - sin cambios de lógica)
-- Requiere: espSection (sección del UI), espLib, espAsset (Parte 1)
-- ============================================================

if not espSection then
	warn("[PotentHub] espSection no está definido. Crea la sección antes de cargar el ESP.")
	return
end

local espState = {
	Eggs = false,
	MinRarity = 5,
	Specific = {},
	MutationSet = {},
	AnyMutation = false,
	NoMutation = false,
	Info = {},
	Highlight = "Off",
	MinValue = 0,
	HighlightMin = 6,
	MaxDistance = math.huge,
	SizeScale = 0.75,
	FixedSize = false,
	OwnBase = true,
}

local espInfoOptions = {
	"Icon",
	"Name",
	"Rarity",
	"Mutation",
	"Value",
	"Weight",
	"Size",
	"Sell Price",
	"Distance",
	"Area",
	"State",
}

local espDefaultInfo = { "Icon", "Name", "Value" }
local espHighlightOptions = { "Off", "Rare Only", "All Shown" }
local espRowHeights = { Icon = 3.2, Name = 1.35, Rarity = 1.2, Mutation = 1, Value = 1.1, Info = 1 }

-- ============================================================
-- ESP EGGS
-- ============================================================

local function espEggsInit()
	local n4 = 18
	local espEggState = {
		Eggs = false,
		MinRarity = 5,
		Specific = {},
		MutationSet = {},
		AnyMutation = false,
		NoMutation = false,
		Info = espState.Info,
		Highlight = espHighlightOptions[1],
		MinValue = 0,
		HighlightMin = 6,
		MaxDistance = math.huge,
		SizeScale = 0.75,
		FixedSize = false,
		OwnBase = true,
	}

	local espEggRuntime = nil
	local espEggContainers = {}
	local espEggHighlightCount = 0
	local espEggHighlightMax = 18
	local espEggGeneration = 0
	local espEggBusy = false
	local espEggDirty = false

	local v10 = (function()
		local ok, result = pcall(Font.new, "rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		return ok and result or espLib.StatusFont
	end)()

	local v11 = (function()
		local sequence2 = espLib.Sequence
		local tbl19 = {}
		local tbl20 = { 0, espColor(255, 255, 255) }
		local tbl21 = { 0.2, espColor(206, 212, 224) }
		local tbl22 = { 0.42, espColor(74, 80, 94) }
		local tbl23 = { 0.58, espColor(42, 46, 56) }
		local tbl24 = { 0.78, espColor(158, 166, 182) }
		local tbl25 = { 1, espColor(250, 252, 255) }
		tbl19[1] = tbl20
		tbl19[2] = tbl21
		tbl19[3] = tbl22
		tbl19[4] = tbl23
		tbl19[5] = tbl24
		tbl19[6] = tbl25
		return sequence2(tbl19)
	end)()

	local v12 = espLib.PaletteFromColor(espColor(77, 255, 122))
	local tbl19 = {}

	do
		local sequence2 = espLib.Sequence
		local tbl20 = {}
		local tbl21 = { 0, espColor(255, 255, 255) }
		local tbl22 = { 0.5, espColor(222, 238, 255) }
		local tbl23 = { 1, espColor(255, 255, 255) }
		tbl20[1] = tbl21
		tbl20[2] = tbl22
		tbl20[3] = tbl23
		tbl19.Text = sequence2(tbl20)
	end

	do
		local sequence2 = espLib.Sequence
		local tbl20 = {}
		local tbl21 = { 0, espColor(8, 8, 8) }
		local tbl22 = { 1, espColor(8, 8, 8) }
		tbl20[1] = tbl21
		tbl20[2] = tbl22
		tbl19.Stroke = sequence2(tbl20)
	end

	tbl19.Outline = espColor(255, 255, 255)

	local n5 = 0.8
	local n6 = 4.5
	local n7 = 20
	local n8 = 0.002

	local espEggCache = {}
	local espEggActive = {}
	local espEggData = nil
	local espEggFocusId = nil
	local espEggFrame = false
	local espEggBusy2 = false
	local espEggInFlight = false
	local espEggLoop = 0
	local espEggPending = false

	local function espEggGetInfo(arg)
		local v16 = espEggCache[arg]
		if v16 then
			return v16
		end
		local directory = tbl and tbl.Assets and tbl.Assets.Directory
		local flag6 = type(directory) == "table" and directory[arg]
		local rarity = type(flag6) == "table" and type(flag6.Rarity) == "table" and flag6.Rarity or nil
		local color3 = rarity and typeof(rarity.Color) == "Color3" and rarity.Color or Color3.new(1, 1, 1)
		local v17 = espLib.PaletteFromColor(color3)
		local rarityGradient = rarity and rarity.RarityGradient

		if rarity and typeof(rarityGradient) ~= "Instance" then
			local assets = replicatedStorage:FindFirstChild("Assets")
			assets = assets and assets:FindFirstChild("UI")
			assets = assets and assets:FindFirstChild("RarityGradients")

			if assets then
				assets = assets:FindFirstChild(tostring(rarity._id or rarity.DisplayName or ""))
			end

			rarityGradient = assets and assets:FindFirstChild("RarityGradient") or nil
		end

		if typeof(rarityGradient) == "Instance" and rarityGradient:IsA("UIGradient") then
			v17.Text = rarityGradient.Color
			v17.Rotation = rarityGradient.Rotation
		end

		local name

		if rarity then
			name = tostring(rarity.DisplayName or rarity._id or "")
		else
			name = rarity
		end

		name = name or ""
		local rarityPalette

		if string.upper(name) ~= "SECRET" then
			rarityPalette = v17
		else
			rarityPalette = { Text = v11, Stroke = v17.Stroke, Outline = v17.Outline, Rotation = 90 }
		end

		local tbl25 = {}
		local number

		if rarity then
			number = tonumber(rarity.RarityNumber or rarity.Rank)
		else
			number = rarity
		end

		tbl25.Number = number or 0
		tbl25.Name = name
		tbl25.Color = color3
		tbl25.Palette = v17
		tbl25.RarityPalette = rarityPalette
		local displayName = type(flag6) == "table"

		if displayName then
			displayName = tostring(flag6.DisplayName or arg)
		end

		tbl25.DisplayName = displayName or tostring(arg)
		tbl25.Icon = type(flag6) == "table" and flag6.Icon or nil
		tbl25.EarningRate = type(flag6) == "table" and tonumber(flag6.EarningRate) or 0
		espEggCache[arg] = tbl25
		return tbl25
	end

	local function espEggGetSlot(arg)
		local areaEggSlotsClient = workspace:FindFirstChild("AreaEggSlotsClient")
		areaEggSlotsClient = areaEggSlotsClient and areaEggSlotsClient:FindFirstChild(arg)
		if areaEggSlotsClient and areaEggSlotsClient:IsA("Model") then
			local hitbox = areaEggSlotsClient:FindFirstChild("Hitbox")
			return areaEggSlotsClient, hitbox and hitbox:IsA("BasePart") and hitbox or nil
		end
		return nil, nil
	end

	local function espEggEnsureRuntime()
		if not espEggRuntime or not espEggRuntime.Parent then
			espEggRuntime = espLib.CreateRuntime()
		end
	end

	local function espEggFormatNumber(arg)
		local n13 = tonumber(arg) or 0
		local tbl26 = { "", "K", "M", "B", "T", "Qa", "Qi" }
		local n14 = 1

		while math.abs(n13) >= 1000 and n14 < #tbl26 do
			n13 /= 1000
			n14 += 1
		end

		return string.format(n14 == 1 and "%.0f%s" or "%.2f%s", n13, tbl26[n14])
	end

	local function espEggMaxDistance(arg)
		local currentCamera = workspace.CurrentCamera
		if not currentCamera then
			return espEggState.MaxDistance
		end
		return math.min(espEggState.MaxDistance, arg * currentCamera.ViewportSize.Y / 2 * n7 * math.tan(math.rad(currentCamera.FieldOfView) * 0.5))
	end

	local function espEggApplyLayout(arg)
		local tbl26 = {
			{ arg.IconHolder, espRowHeights.Icon, arg.ShowIcon },
			{ arg.NameRow.Holder, espRowHeights.Name, arg.ShowName },
			{ arg.RarityRow.Holder, espRowHeights.Rarity, arg.ShowRarity },
			{ arg.MutationRow.Holder, espRowHeights.Mutation, arg.ShowMutation },
			{ arg.ValueRow.Holder, espRowHeights.Value, arg.ShowValue },
			{ arg.ExtraRow.Holder, espRowHeights.Info, arg.ShowExtra },
		}

		local n13 = 0

		for _, v16 in ipairs(tbl26) do
			if v16[3] then
				n13 += v16[2]
			end
		end

		local n14 = math.max(n13, 1)

		for _, v16 in ipairs(tbl26) do
			v16[1].Visible = v16[3]
			v16[1].Size = UDim2.fromScale(1, v16[3] and v16[2] / n14 or 0)
		end

		local v16 = espLib.ScaledWidth(120, espEggState.SizeScale)
		local height = math.max(1, math.floor(espLib.RowHeight(espEggState.SizeScale) * n14))

		if arg.Width ~= v16 or arg.Height ~= height or arg.Fixed ~= espEggState.FixedSize then
			arg.Width = v16
			arg.Height = height
			arg.Fixed = espEggState.FixedSize

			if espEggState.FixedSize then
				local n15 = n6 * espEggState.SizeScale
				arg.Billboard.Size = UDim2.fromScale(n15, n15 * height / v16)
				arg.Billboard.MaxDistance = espEggMaxDistance(n15)
			else
				arg.Billboard.Size = UDim2.fromOffset(v16, height)
				arg.Billboard.MaxDistance = espEggState.MaxDistance
			end
		end
	end

	local function espEggMarkDirty(arg)
		arg.Width = nil
		espEggApplyLayout(arg)
	end

	local function espEggCreateTag()
		local v16, v17 = espLib.CreateTag(espEggRuntime, espEggState.MaxDistance)
		local frame = Instance.new("Frame")
		frame.Name = randomName()
		frame.BackgroundTransparency = 1
		frame.BorderSizePixel = 0
		frame.LayoutOrder = 0
		frame.Parent = v17
		local imageLabel = Instance.new("ImageLabel")
		imageLabel.Name = randomName()
		imageLabel.AnchorPoint = Vector2.new(0.5, 1)
		imageLabel.BackgroundTransparency = 1
		imageLabel.Position = UDim2.fromScale(0.5, 1)
		imageLabel.Size = UDim2.fromScale(1, 1)
		imageLabel.ScaleType = Enum.ScaleType.Fit
		imageLabel.Parent = frame
		local uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
		uiAspectRatioConstraint.Name = randomName()
		uiAspectRatioConstraint.AspectRatio = 1
		uiAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
		uiAspectRatioConstraint.Parent = imageLabel

		local tbl26 = {
			Billboard = v16,
			IconHolder = frame,
			Icon = imageLabel,
			NameRow = espLib.CreateTextRow(v17, espLib.MainFont, 1, 0.4),
			RarityRow = espLib.CreateTextRow(v17, v10, 2, 0.2),
			MutationRow = espLib.CreateTextRow(v17, espLib.MainFont, 3, 0.2),
			ValueRow = espLib.CreateTextRow(v17, espLib.MainFont, 4, 0.2),
			ExtraRow = espLib.CreateTextRow(v17, espLib.MainFont, 5, 0.2),
			Highlight = nil,
			Anchor = nil,
			CFrame = nil,
			Width = nil,
			Height = nil,
			ShowIcon = false,
			ShowName = true,
			ShowRarity = false,
			ShowMutation = false,
			ShowValue = false,
			ShowExtra = false,
		}

		espEggApplyLayout(tbl26)
		return tbl26
	end

	local function espEggDestroyHighlight(arg)
		if arg.Highlight then
			arg.Highlight:Destroy()
			arg.Highlight = nil
			espEggHighlightCount -= 1
		end
	end

	local function espEggComputeValue(arg, arg2)
		local n13 = tonumber(arg.AssetScale) or 1
		local n14 = n13 > 5 and (n13 / 5) ^ 1.2 * 19.637875755794113 or n13 ^ 1.85
		local mutations = tbl and tbl.Mutations
		local flag6 = type(mutations) == "table" and type(mutations.EarningsFor) == "function"
		local n15 = 1

		if flag6 then
			local ok, result = pcall(mutations.EarningsFor, type(arg.Mutations) == "table" and arg.Mutations or {})
			local flag7 = ok and type(result) == "number"
			local n16 = 1

			if flag7 then
				n15 = result
			else
				n15 = n16
			end
		end

		return arg2.EarningRate * n14 * n15
	end

	local function espEggReadOwnBase()
		local tbl26 = {}
		local eggState = tbl and tbl.EggState
		local placedEggRenders = workspace:FindFirstChild("PlacedEggRenders")
		if not placedEggRenders or type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
			return tbl26
		end
		local ok, result = pcall(eggState.ReadOwnerEggs, playersService.LocalPlayer.UserId)
		if not ok or type(result) ~= "table" then
			return tbl26
		end
		local str = tostring(playersService.LocalPlayer.UserId)
		local tbl27 = {}

		for _, child in ipairs(placedEggRenders:GetChildren()) do
			if string.find(child.Name, str, 1, true) then
				tbl27[#tbl27 + 1] = child
			end
		end

		for k, v16 in pairs(result) do
			if type(v16) == "table" and v16.Placement ~= nil and type(v16.AssetCategory) == "string" then
				local base = tostring(k)
				local v17 = nil

				for _, v18 in ipairs(tbl27) do
					if v18.Name == base or string.find(v18.Name, base, 1, true) or v18:GetAttribute("Uid") == base then
						v17 = v18
						break
					end
				end

				if v17 then
					local ok2, result2 = pcall(function()
						return v17:IsA("Model") and v17:GetPivot() or v17.CFrame
					end)

					local mutations = type(v16.Mutations) == "table" and v16.Mutations or {}

					tbl26[#tbl26 + 1] = {
						Uid = "base:" .. base,
						AssetCategory = v16.AssetCategory,
						AssetScale = v16.AssetScale,
						Mutations = mutations,
						BaseMutation = v16.BaseMutation or mutations[1],
						State = "Base",
						AreaId = "Your Base",
						BottomCFrame = ok2 and result2 or nil,
						Model = v17,
					}
				end
			end
		end

		return tbl26
	end

	local function espEggPassesFilter(arg, arg2)
		if arg.State == "Claimed" then
			return false
		end

		if espEggState.MinRarity > 0 and arg2.Number < espEggState.MinRarity then
			return false
		end
		local flag6 = espEggState.MinValue > 0

		if flag6 then
			local minValue = espEggState.MinValue
			flag6 = espEggComputeValue(arg, arg2) < minValue
		end

		if flag6 then
			return false
		end
		return true
	end

	local function espEggUpdate(arg, arg2, arg3)
		local model, hitbox

		if typeof(arg2.Model) == "Instance" then
			model = arg2.Model
			hitbox = model:FindFirstChild("Hitbox", true) or model:FindFirstChildWhichIsA("BasePart", true)
			hitbox = hitbox and hitbox:IsA("BasePart") and hitbox or nil
		else
			model, hitbox = espEggGetSlot(arg2.Uid)
		end

		local bottomCFrame = arg2.BottomCFrame

		if typeof(bottomCFrame) == "CFrame" then
			local terrain = hitbox or workspace.Terrain

			if arg.Anchor ~= terrain or arg.CFrame ~= bottomCFrame then
				arg.Anchor = terrain
				arg.CFrame = bottomCFrame
				arg.Billboard.Adornee = terrain
				arg.Billboard.StudsOffsetWorldSpace = bottomCFrame.Position - terrain.Position + Vector3.new(0, (hitbox and hitbox.Position.Y - bottomCFrame.Position.Y or 1) + n5, 0)
			end
		end

		local info = espEggState.Info
		local baseMutation = arg2.BaseMutation
		local showMutation = type(baseMutation) == "string" and baseMutation ~= ""
		local n13 = tonumber(arg2.AssetScale) or 1
		local showIcon = info.Icon == true and arg3.Icon ~= nil

		if showIcon and arg.Icon.Image ~= tostring(arg3.Icon) then
			arg.Icon.Image = tostring(arg3.Icon)
		end

		local showName = info.Name == true

		if showName then
			espLib.SetRow(arg.NameRow, arg3.DisplayName, tbl19)
		end

		local showRarity = info.Rarity == true and arg3.Name ~= ""

		if showRarity then
			local rarityPalette = arg3.RarityPalette
			espLib.SetRow(arg.RarityRow, string.upper(arg3.Name), rarityPalette)
		end

		showMutation = info.Mutation == true and showMutation

		if showMutation then
			espLib.SetRow(arg.MutationRow, string.upper(fn7 and fn7(baseMutation) or tostring(baseMutation)), espUi.PalettesMut[baseMutation] or v13)
		end

		local showValue = info.Value == true

		if showValue then
			espLib.SetRow(arg.ValueRow, "$" .. espEggFormatNumber(espEggComputeValue(arg2, arg3)) .. "/s", v12)
		end

		local tbl26 = {}
		local eggRecords = tbl and tbl.EggRecords

		if info.Weight and type(eggRecords) == "table" and type(eggRecords.WeightKgForScale) == "function" then
			local ok, result = pcall(eggRecords.WeightKgForScale, arg2.AssetCategory, n13)

			if ok and tonumber(result) then
				table.insert(tbl26, espEggFormatNumber(result) .. " kg")
			end
		end

		if info.Size then
			table.insert(tbl26, string.format("x%.2f", n13))
		end

		if info["Sell Price"] and type(eggRecords) == "table" and type(eggRecords.SellPrice) == "function" then
			local ok, result = pcall(eggRecords.SellPrice, arg2)

			if ok and tonumber(result) then
				table.insert(tbl26, "$" .. espEggFormatNumber(result))
			end
		end

		if info.Distance and typeof(bottomCFrame) == "CFrame" then
			local character = playersService.LocalPlayer.Character
			character = character and character:FindFirstChild("HumanoidRootPart")

			if character then
				table.insert(tbl26, string.format("%dm", math.floor((character.Position - bottomCFrame.Position).Magnitude + 0.5)))
			end
		end

		if info.Area and arg2.AreaId ~= nil then
			table.insert(tbl26, tostring(arg2.AreaId))
		end

		if info.State and arg2.State ~= nil and arg2.State ~= "Slot" then
			table.insert(tbl26, tostring(arg2.State))
		end

		local showExtra = #tbl26 > 0

		if showExtra then
			espLib.SetRow(arg.ExtraRow, table.concat(tbl26, "  |  "), espLib.Palettes.Sheen)
		end

		if arg.ShowIcon ~= showIcon or arg.ShowName ~= showName or arg.ShowRarity ~= showRarity or arg.ShowMutation ~= showMutation or arg.ShowValue ~= showValue or arg.ShowExtra ~= showExtra then
			arg.ShowIcon = showIcon
			arg.ShowName = showName
			arg.ShowRarity = showRarity
			arg.ShowMutation = showMutation
			arg.ShowValue = showValue
			arg.ShowExtra = showExtra
			espEggApplyLayout(arg)
		end

		if (espEggState.Highlight == espHighlightOptions[3] or espEggState.Highlight == espHighlightOptions[2] and arg3.Number >= espEggState.HighlightMin) and model then
			if not arg.Highlight and espEggHighlightCount < espEggHighlightMax then
				local highlight = Instance.new("Highlight")
				highlight.Name = randomName()
				highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				highlight.FillTransparency = 0.82
				highlight.OutlineTransparency = 0.05
				highlight.FillColor = arg3.Color
				highlight.OutlineColor = arg3.Palette.Outline
				highlight.Parent = espEggRuntime
				arg.Highlight = highlight
				espEggHighlightCount += 1
			end

			if arg.Highlight and arg.Highlight.Adornee ~= model then
				arg.Highlight.Adornee = model
			end
		else
			espEggDestroyHighlight(arg)
		end
	end

	local function espEggRemoveTag(arg)
		espEggDestroyHighlight(arg)
		arg.Billboard:Destroy()
	end

	local function espEggCleanAll()
		local v16 = espEggActive
		local v17 = espEggRuntime
		espEggActive = {}
		espEggRuntime = nil
		espEggHighlightCount = 0

		task.spawn(function()
			local now = os.clock()

			for _, v18 in pairs(v16) do
				if v18.Highlight then
					v18.Highlight:Destroy()
				end

				v18.Billboard:Destroy()

				if n8 < os.clock() - now then
					RunService.Heartbeat:Wait()
					now = os.clock()
				end
			end

			if v17 then
				v17:Destroy()
			end
		end)
	end

	local function espEggRender(arg, arg2, arg3)
		local function fn38()
			return arg2 == espEggGeneration and arg3 == espEggLoop and espEggFrame
		end

		espEggEnsureRuntime()
		local tbl26 = {}
		local now = os.clock()

		for _, v16 in pairs(arg) do
			local uid = type(v16) == "table" and v16.Uid

			if type(uid) == "string" and type(v16.AssetCategory) == "string" then
				local v17 = espEggGetInfo(v16.AssetCategory)

				if espEggState.Eggs and espEggPassesFilter(v16, v17) then
					tbl26[uid] = true
					local v18 = espEggActive[uid]

					if not v18 then
						v18 = espEggCreateTag()
						espEggActive[uid] = v18
					end

					espEggUpdate(v18, v16, v17)
				end
			end

			if not (n8 < os.clock() - now) then
				continue
			end
			RunService.Heartbeat:Wait()
			now = os.clock()
			if not fn38() then
				return
			end
		end

		if espEggState.Eggs and espEggState.OwnBase then
			for _, v16 in ipairs(espEggReadOwnBase()) do
				local v17 = espEggGetInfo(v16.AssetCategory)

				if espEggPassesFilter(v16, v17) then
					tbl26[v16.Uid] = true
					local v18 = espEggActive[v16.Uid]

					if not v18 then
						v18 = espEggCreateTag()
						espEggActive[v16.Uid] = v18
					end

					espEggUpdate(v18, v16, v17)
				end
			end
		end

		for k, v16 in pairs(espEggActive) do
			if not tbl26[k] then
				espEggActive[k] = nil
				espEggRemoveTag(v16)
			end
		end

		return true
	end

	local function espEggReadField()
		local eggState = tbl and tbl.EggState
		local flag8 = type(eggState) == "table" and type(eggState.ReadFieldEggs) == "function"
		local records = nil

		if flag8 then
			local ok, result = pcall(eggState.ReadFieldEggs)
			ok = ok and type(result) == "table" and type(result.Records) == "table"

			if ok then
				records = result.Records
			end
		end

		if records == nil then
			local rfEggWorldAskFieldEggSnapshot = replicatedStorage:FindFirstChild("Packages")
			rfEggWorldAskFieldEggSnapshot = rfEggWorldAskFieldEggSnapshot and rfEggWorldAskFieldEggSnapshot:FindFirstChild("Networking")
			rfEggWorldAskFieldEggSnapshot = rfEggWorldAskFieldEggSnapshot and rfEggWorldAskFieldEggSnapshot:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot")

			if rfEggWorldAskFieldEggSnapshot and rfEggWorldAskFieldEggSnapshot:IsA("RemoteFunction") then
				local ok, result = pcall(rfEggWorldAskFieldEggSnapshot.InvokeServer, rfEggWorldAskFieldEggSnapshot)

				if ok and type(result) == "table" and type(result.Records) == "table" then
					records = result.Records
				end
			end
		end

		return records
	end

	local function espEggRequestRefresh()
		local v16 = espEggLoop

		if espEggRuntime and next(espEggActive) == nil then
			espEggDirty = true
		end

		if espEggData then
			espEggDirty = true
		end

		if espEggFrame and not espEggBusy2 then
			espEggBusy2 = true

			task.defer(function()
				while espEggFrame and espEggDirty do
					espEggDirty = false
					espEggLoop += 1
					local ok, result = pcall(espEggRender, espEggData or {}, espEggGeneration, espEggLoop)

					if ok and result ~= true then
						espEggDirty = true
					end

					RunService.Heartbeat:Wait()
				end

				espEggBusy2 = false
			end)
		end
	end

	local function espEggCollect()
		local records = espEggReadField()

		if records ~= nil then
			local tbl26 = {}

			for k, record in pairs(records) do
				tbl26[k] = record
			end

			espEggData = tbl26
			espEggDirty = true
		end
	end

	local function espEggEnable()
		if espEggFrame then
			return
		end
		espEggFrame = true
		espEggGeneration += 1

		local gen = espEggGeneration
		local eggState = tbl and tbl.EggState

		if type(eggState) == "table" then
			for _, v17 in ipairs({ "FieldRefreshed", "FieldShifted", "FieldGone", "FieldClaimed", "SnapshotRefreshed" }) do
				local v18 = eggState[v17]

				if type(v18) == "table" and type(v18.Connect) == "function" then
					local ok, result = pcall(v18.Connect, v18, espEggRequestRefresh)

					if ok and result then
						table.insert(espEggContainers, result)
					end
				end
			end
		end

		for _, v17 in ipairs({ "AreaEggSlotsClient", "PlacedEggRenders" }) do
			local v18 = workspace:FindFirstChild(v17)

			if v18 then
				table.insert(espEggContainers, v18.ChildAdded:Connect(espEggRequestRefresh))
				table.insert(espEggContainers, v18.ChildRemoved:Connect(espEggRequestRefresh))
			end
		end

		task.spawn(function()
			while gen == espEggGeneration do
				task.wait(10)

				if gen == espEggGeneration then
					espEggRequestRefresh()
					continue
				end

				break
			end
		end)

		task.spawn(function()
			while gen == espEggGeneration do
				task.wait(1)

				if gen == espEggGeneration then
					if espEggState.Info.Distance then
						espEggRequestRefresh()
					end

					continue
				end

				break
			end
		end)

		task.spawn(pcall, espEggCollect)
	end

	local function espEggDisable()
		espEggFrame = false
		espEggGeneration += 1
		espEggLoop += 1
		espLib.DisconnectAll(espEggContainers)
		espEggCleanAll()
	end

	local espEggToggleHandle = espSection:CreateToggle({
		Name = "ESP Eggs",
		Default = false,
		Callback = function(arg)
			espEggState.Eggs = arg == true

			if espEggState.Eggs then
				espEggEnable()
			else
				espEggDisable()
			end
		end,
	})

	espSection:CreateToggle({
		Name = "ESP Fixed Size",
		Default = false,
		SubOf = espEggToggleHandle,
		Callback = function(arg)
			espEggState.FixedSize = arg == true

			for _, v16 in pairs(espEggActive) do
				espEggMarkDirty(v16)
			end
		end,
	})

	espSection:CreateToggle({
		Name = "ESP Own Base Eggs",
		Note = "Also show the eggs placed in your own base",
		Default = true,
		SubOf = espEggToggleHandle,
		Callback = function(arg)
			espEggState.OwnBase = arg ~= false
			espEggRequestRefresh()
		end,
	})

	-- Min Rarity dropdown
	local espEggRarities = { "Any" }
	local espEggRarityMap = { Any = 0 }
	local espEggRarityList = {}
	local espEggRarityDedupe = {}
	local directory = tbl and tbl.Assets and tbl.Assets.Directory

	if type(directory) == "table" then
		for k, v16 in pairs(directory) do
			local rarity = type(v16) == "table" and v16.Rarity or nil
			local flag6 = type(rarity) == "table"

			if flag6 then
				flag6 = tonumber(rarity.RarityNumber or rarity.Rank)
			end

			flag6 = flag6 or nil

			if flag6 then
				local str = tostring(rarity.DisplayName or rarity._id or flag6)
				espEggRarityDedupe[flag6] = espEggRarityDedupe[flag6] or str

				table.insert(espEggRarityList, {
					Category = tostring(k),
					Name = tostring(v16.DisplayName or k),
					Rarity = flag6,
					RarityName = str,
				})
			end
		end
	end

	local espEggSortedRarities = {}

	for k in pairs(espEggRarityDedupe) do
		table.insert(espEggSortedRarities, k)
	end

	table.sort(espEggSortedRarities)

	for _, v16 in ipairs(espEggSortedRarities) do
		local str = string.format("%d - %s", v16, espEggRarityDedupe[v16])
		table.insert(espEggRarities, str)
		espEggRarityMap[str] = v16
	end

	local function espEggRarityForNumber(arg)
		for _, v16 in ipairs(espEggRarities) do
			if espEggRarityMap[v16] == arg then
				return v16
			end
		end

		return espEggRarities[1]
	end

	espSection:CreateDropdown({
		Name = "ESP Min Rarity",
		Note = "Show eggs of the chosen rarity and every rarity above it",
		Options = espEggRarities,
		Default = espEggRarityForNumber(5),
		SubOf = espEggToggleHandle,
		Callback = function(arg)
			espEggState.MinRarity = espEggRarityMap[type(arg) == "table" and arg[1] or arg] or 0
			espEggRequestRefresh()
		end,
	})

	espSection:CreateMultiDropdown({
		Name = "ESP Show Info",
		Options = espInfoOptions,
		Default = espDefaultInfo,
		SubOf = espEggToggleHandle,
		Callback = function(arg)
			local tbl27 = {}

			if type(arg) == "table" then
				for k, v16 in pairs(arg) do
					k = v16 == true and type(k) == "string" and k
					local flag9

					if k then
						flag9 = k
					else
						flag9 = type(v16) == "string" and v16
					end

					flag9 = flag9 or nil

					if flag9 then
						tbl27[flag9] = true
					end
				end
			end

			espEggState.Info = tbl27
			espEggRequestRefresh()
		end,
	})

	local espEggValueUnits = {
		["K/s"] = { Mult = 1000 },
		["M/s"] = { Mult = 1000000 },
		["B/s"] = { Mult = 1e9 },
	}

	local espEggMinValue = 0
	local espEggMinValueUnit = "M/s"

	espSection:CreateSlider({
		Name = "Min ESP Value",
		Min = 0,
		Max = 1000,
		Default = 0,
		AllowDecimals = true,
		Increment = 0.01,
		SubOf = espEggToggleHandle,
		Callback = function(arg)
			local num = tonumber(arg) or 0
			espEggState.MinValue = math.max(0, math.floor(num)) * (espEggValueUnits[espEggMinValueUnit] or espEggValueUnits["M/s"]).Mult
			espEggRequestRefresh()
		end,
	})

	espSection:CreateSlider({
		Name = "ESP Egg Size",
		Min = 50,
		Max = 200,
		Default = 75,
		Increment = 5,
		Unit = "%",
		SubOf = espEggToggleHandle,
		Callback = function(arg)
			local num = tonumber(arg)

			if num and espEggState.SizeScale ~= num / 100 then
				espEggState.SizeScale = num / 100
				espLib.SetSizeScale(espEggState.SizeScale)

				for _, v16 in pairs(espEggActive) do
					espEggMarkDirty(v16)
				end
			end
		end,
	})

	espSection:CreateDropdown({
		Name = "ESP Egg Highlight",
		Options = espHighlightOptions,
		Default = espHighlightOptions[1],
		SubOf = espEggToggleHandle,
		Callback = function(arg)
			if table.find(espHighlightOptions, arg) then
				espEggState.Highlight = arg
				espEggRequestRefresh()
			end
		end,
	})
end

espEggsInit()

-- ============================================================
-- FIN DE LA PARTE 2
-- ============================================================
-- ============================================================
-- ESP GUARDS (migrado de Chilli - sin cambios de lógica)
-- ============================================================

local function espGuardsInit()
	local n13 = 1
	local n14 = 0.75

	local guardPalettes = {
		Sleeping = espLib.Palettes.Accent,
		Waking   = espLib.Palettes.Gold,
		Chasing  = espLib.Palettes.Red,
	}

	local orange = espLib.Palettes.Orange
	local guardActive = {}
	local guardRuntime = nil
	local guardFrame = false
	local guardConnections = {}
	local guardToggleHandle = nil
	local guardEnabled = false

	local function guardGetLabel(arg)
		local attribute = arg:GetAttribute("GuardState")
		if attribute == "Sleeping" then
			return "Sleeping"
		end

		if attribute == "Waking" then
			return "Waking Up"
		end

		if attribute == "Chasing" then
			local attribute2 = arg:GetAttribute("TargetPlayer")
			if attribute2 == tostring(playersService.LocalPlayer.UserId) then
				return "Chasing You"
			end
			local playerByUserId = tonumber(attribute2) and playersService:GetPlayerByUserId(tonumber(attribute2))
			return playerByUserId and "Chasing " .. playerByUserId.DisplayName or "Chasing"
		end

		return attribute and tostring(attribute) or "Awake"
	end

	local function guardApplyState(arg, adornee)
		local v17 = guardPalettes[adornee:GetAttribute("GuardState")] or orange
		arg.Highlight.FillColor = v17.Outline
		arg.Highlight.OutlineColor = v17.Outline
		espLib.SetRow(arg.StateRow, guardGetLabel(adornee), v17)
	end

	local function guardResizeTag(arg)
		local floor = math.floor
		arg.Tag.Size = UDim2.fromOffset(espLib.ScaledWidth(115, n14), floor(espLib.RowHeight(n14) * 1.6))
	end

	local function guardRemove(adornee)
		local v17 = guardActive[adornee]
		if not v17 then
			return
		end
		guardActive[adornee] = nil
		espLib.DisconnectAll(v17.Connections)
		v17.Highlight:Destroy()
		v17.Tag:Destroy()
	end

	local function guardAdd(name, adornee)
		if guardActive[adornee] then
			return
		end
		local v17 = espLib.FindGuardRoot(adornee)
		if not v17 then
			return
		end

		if not guardRuntime or not guardRuntime.Parent then
			guardRuntime = espLib.CreateRuntime()
		end

		local highlight = Instance.new("Highlight")
		highlight.Name = randomName()
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.FillTransparency = 0.76
		highlight.OutlineTransparency = 0.02
		highlight.Adornee = adornee
		highlight.Parent = guardRuntime
		local ok, result, result2 = pcall(adornee.GetBoundingBox, adornee)
		local flag7 = ok and typeof(result) == "CFrame"
		local n15 = 6

		if flag7 then
			n15 = result.Position.Y + result2.Y * 0.5 - v17.Position.Y + n13
		end

		local v18, v19 = espLib.CreateTag(guardRuntime, math.huge)
		v18.Adornee = v17
		v18.StudsOffsetWorldSpace = Vector3.new(0, n15, 0)
		local v20 = espLib.CreateTextRow(v19, espLib.StatusFont, 1, 0.45)
		local v21 = espLib.CreateTextRow(v19, espLib.StatusFont, 2, 0.55)
		local sheen = espLib.Palettes.Sheen
		espLib.SetRow(v20, tostring(name) .. " Guard", sheen)
		local tbl29 = { Highlight = highlight, Tag = v18, StateRow = v21, Connections = {} }
		guardActive[adornee] = tbl29
		guardResizeTag(tbl29)
		guardApplyState(tbl29, adornee)

		local function guardUpdate()
			guardApplyState(tbl29, adornee)
		end

		table.insert(tbl29.Connections, adornee:GetAttributeChangedSignal("GuardState"):Connect(guardUpdate))
		table.insert(tbl29.Connections, adornee:GetAttributeChangedSignal("TargetPlayer"):Connect(guardUpdate))

		table.insert(tbl29.Connections, adornee.AncestryChanged:Connect(function()
			if not adornee:IsDescendantOf(workspace) then
				guardRemove(adornee)
			end
		end))
	end

	local function guardCleanAll()
		guardFrame = false
		espLib.DisconnectAll(guardConnections)

		for k in pairs(guardActive) do
			guardRemove(k)
		end

		if guardRuntime then
			guardRuntime:Destroy()
			guardRuntime = nil
		end
	end

	local function guardEnable()
		if guardFrame then
			return
		end
		guardFrame = true
		guardConnections = espLib.WatchGuards(guardAdd)
	end

	local function guardToggle(arg)
		guardEnabled = arg == true

		if guardEnabled then
			guardEnable()
		elseif guardFrame then
			guardCleanAll()
		end
	end

	guardToggleHandle = espSection:CreateToggle({
		Name = "ESP Guards",
		Default = false,
		Callback = function(arg)
			guardEnabled = arg == true
			espLib.SyncSoon(function() guardToggle(guardEnabled) end)
		end,
	})

	espSection:CreateSlider({
		Name = "ESP Guard Size",
		Min = 50,
		Max = 200,
		Default = 75,
		Increment = 5,
		Unit = "%",
		SubOf = guardToggleHandle,
		Callback = function(arg)
			local num = tonumber(arg)

			if num and n14 ~= num / 100 then
				n14 = num / 100

				for _, v18 in pairs(guardActive) do
					guardResizeTag(v18)
				end
			end
		end,
	})
end

espGuardsInit()

-- ============================================================
-- ESP LOST PARTS (Dr Scramble Event)
-- ============================================================

local function espLostPartsInit()
	local lostPartsList = {
		{ Id = "LostPart1", Label = "Mechanical Gear" },
		{ Id = "LostPart2", Label = "Wiring Harness" },
	}

	local yellowPalette = espLib.PaletteFromColor(espColor(255, 216, 61))
	local accent = espLib.Palettes.Accent
	local lostRuntime = nil
	local lostActive = {}
	local lostFrame = false
	local lostConnection = nil
	local lostToggleHandle = nil
	local lostEnabled = false
	local lostAccum = 0

	local function lostRemove(id)
		local v19 = lostActive[id]
		if not v19 then
			return
		end
		lostActive[id] = nil

		pcall(function()
			v19.Highlight:Destroy()
			v19.Tag:Destroy()
		end)
	end

	local function lostUpdate()
		local drScrambleEvent = workspace:FindFirstChild("DrScrambleEvent")

		for _, v19 in ipairs(lostPartsList) do
			local v20 = drScrambleEvent and drScrambleEvent:FindFirstChild(v19.Id)
			local hitbox = v20 and (v20:FindFirstChild("Hitbox", true) or v20.PrimaryPart or v20:FindFirstChildWhichIsA("BasePart", true))
			local tbl28 = lostActive[v19.Id]

			if tbl28 and (tbl28.Model ~= v20 or not hitbox) then
				lostRemove(v19.Id)
				tbl28 = nil
			end

			if hitbox and not tbl28 then
				if not lostRuntime or not lostRuntime.Parent then
					lostRuntime = espLib.CreateRuntime()
				end

				local highlight = Instance.new("Highlight")
				highlight.Name = randomName()
				highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				highlight.FillTransparency = 0.7
				highlight.OutlineTransparency = 0.02
				highlight.Adornee = v20
				highlight.Parent = lostRuntime
				local v21, v22 = espLib.CreateTag(lostRuntime, 25000)
				v21.Adornee = hitbox
				v21.StudsOffsetWorldSpace = Vector3.new(0, 4, 0)
				local floor = math.floor
				v21.Size = UDim2.fromOffset(espLib.ScaledWidth(160), floor(espLib.RowHeight() * 1.6))
				local v23 = espLib.CreateTextRow(v22, espLib.StatusFont, 1, 0.5)
				local v24 = espLib.CreateTextRow(v22, espLib.StatusFont, 2, 0.5)
				espLib.SetRow(v23, v19.Label, espLib.Palettes.Sheen)
				tbl28 = { Model = v20, Hitbox = hitbox, Highlight = highlight, Tag = v21, InfoRow = v24 }
				lostActive[v19.Id] = tbl28
			end

			if tbl28 then
				local collected = false

				if type(tbl4) == "table" and type(tbl4.ScrambleLostPart) == "function" then
					local ok, result = pcall(tbl4.ScrambleLostPart, v19.Id)
					collected = ok and result == true
				end

				local v21 = collected and accent or yellowPalette
				local distance = 0
				if type(tbl4) == "table" and type(tbl4.DistanceTo) == "function" then
					local ok, result = pcall(tbl4.DistanceTo, tbl28.Hitbox.Position)
					if ok and tonumber(result) then
						distance = result
					end
				end
				espLib.SetRow(tbl28.InfoRow, collected and "Collected" or string.format("%d studs", math.floor(distance)), v21)
				tbl28.Highlight.FillColor = v21.Outline
				tbl28.Highlight.OutlineColor = v21.Outline
			end
		end
	end

	local function lostDisable()
		lostFrame = false

		if lostConnection then
			lostConnection:Disconnect()
			lostConnection = nil
		end

		for k in pairs(lostActive) do
			lostRemove(k)
		end

		if lostRuntime then
			lostRuntime:Destroy()
			lostRuntime = nil
		end
	end

	local function lostEnable()
		if lostFrame then
			return
		end
		lostFrame = true
		lostAccum = 0

		lostConnection = RunService.Heartbeat:Connect(function(deltaTime)
			lostAccum += deltaTime

			if lostAccum >= 0.3 then
				lostAccum = 0
				pcall(lostUpdate)
			end
		end)
	end

	local function lostToggle(arg)
		lostEnabled = arg == true

		if lostEnabled then
			lostEnable()
		elseif lostFrame then
			lostDisable()
		end
	end

	lostToggleHandle = espSection:CreateToggle({
		Name = "ESP Lost Parts",
		Default = false,
		Callback = function(arg)
			lostEnabled = arg == true
			espLib.SyncSoon(function() lostToggle(lostEnabled) end)
		end,
	})
end

espLostPartsInit()

-- ============================================================
-- ESP PLAYERS (con info Name/Username/Avatar/Tool)
-- ============================================================

local function espPlayersInit()
	local TextService = game:GetService("TextService")
	local playerFont = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)

	local nameGradient = ColorSequence.new({
		ColorSequenceKeypoint.new(0, espColor(138, 255, 205)),
		ColorSequenceKeypoint.new(0.5, espColor(125, 225, 255)),
		ColorSequenceKeypoint.new(1, espColor(210, 135, 255)),
	})

	local strokeGradient = ColorSequence.new({
		ColorSequenceKeypoint.new(0, espColor(7, 73, 66)),
		ColorSequenceKeypoint.new(1, espColor(35, 17, 79)),
	})

	local playerFrame = false
	local playerRuntime = nil
	local playerActive = {}
	local playerConnections = {}
	local playerToggleHandle = nil
	local playerEnabled = false
	local playerSizeScale = 0.75
	local playerInfo = { Name = true, Username = false, Avatar = false, Tool = true }
	local playerThumbCache = {}
	local playerGeneration = 0

	local function playerFormatImage(arg)
		local str = tostring(arg or "")
		if str:match("^%d+$") then
			return "rbxassetid://" .. str
		end
		return str
	end

	local function playerToolIcon(tool)
		if not tool or not tool:IsA("Tool") then
			return ""
		end
		local v19 = playerFormatImage(tool.TextureId)
		if v19 ~= "" then
			return v19
		end

		for _, v20 in ipairs({ "Icon", "Image", "Thumbnail", "TextureId" }) do
			local attribute = tool:GetAttribute(v20)
			if type(attribute) == "string" and playerFormatImage(attribute) ~= "" then
				return playerFormatImage(attribute)
			end
		end

		for _, descendant in ipairs(tool:GetDescendants()) do
			if descendant:IsA("Decal") or descendant:IsA("Texture") then
				v19 = playerFormatImage(descendant.Texture)
			elseif descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
				v19 = playerFormatImage(descendant.Image)
			end

			if v19 ~= "" then
				return v19
			end
		end

		return ""
	end

	local function playerRowHeight()
		local currentCamera = workspace.CurrentCamera
		return math.max(1, math.floor(math.clamp((currentCamera and currentCamera.ViewportSize.Y or 1080) * 0.024, 26, 35) * playerSizeScale))
	end

	local playerTextCache = {}
	local function playerMeasure(text, size)
		local str = text .. "@" .. size
		local v19 = playerTextCache[str]
		if v19 then
			return v19
		end
		local getTextBoundsParams = Instance.new("GetTextBoundsParams")
		getTextBoundsParams.Text = text
		getTextBoundsParams.Font = playerFont
		getTextBoundsParams.Size = size
		getTextBoundsParams.Width = 1000

		local ok, result = pcall(function()
			return TextService:GetTextBoundsAsync(getTextBoundsParams)
		end)

		getTextBoundsParams:Destroy()
		ok = ok and result.X

		if not ok then
			ok = (utf8.len(text) or #text) * size * 0.56
		end

		playerTextCache[str] = ok
		return ok
	end

	local function playerSetupStroke(arg, color3, arg2, arg3)
		arg.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
		arg.Color = color3
		arg.LineJoinMode = Enum.LineJoinMode.Round
		arg.Transparency = 0

		arg.Thickness = pcall(function()
			arg.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
		end) and arg2 or arg3
	end

	local function playerCreateTextLabel(parent, zIndex)
		local textLabel = Instance.new("TextLabel")
		textLabel.Name = randomName()
		textLabel.AnchorPoint = Vector2.new(0, 0.5)
		textLabel.BackgroundTransparency = 1
		textLabel.FontFace = playerFont
		textLabel.Text = ""
		textLabel.TextScaled = true
		textLabel.TextStrokeTransparency = 1
		textLabel.TextXAlignment = Enum.TextXAlignment.Center
		textLabel.TextYAlignment = Enum.TextYAlignment.Center
		textLabel.ZIndex = zIndex
		textLabel.Parent = parent
		return textLabel
	end

	local function playerCreateImageLabel(parent, zIndex)
		local imageLabel = Instance.new("ImageLabel")
		imageLabel.Name = randomName()
		imageLabel.AnchorPoint = Vector2.new(0, 0.5)
		imageLabel.BackgroundTransparency = 1
		imageLabel.ScaleType = Enum.ScaleType.Fit
		imageLabel.ZIndex = zIndex
		imageLabel.Parent = parent
		local uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
		uiAspectRatioConstraint.Name = randomName()
		uiAspectRatioConstraint.AspectRatio = 1
		uiAspectRatioConstraint.Parent = imageLabel
		return imageLabel
	end

	local function playerApplyLayout(arg)
		local v19 = playerRowHeight()
		local visible = playerInfo.Name == true or playerInfo.Username == true
		local visible2 = playerInfo.Avatar == true
		local visible3 = playerInfo.Tool == true and arg.ToolIcon.Image ~= ""
		local n15 = visible2 and math.floor(v19 * 0.72) or 0
		local n16 = visible3 and math.floor(v19 * 0.82) or 0
		local n17 = math.floor(v19 * 0.7)
		local n18 = math.max(1, math.floor(v19 * 0.04))
		local name = playerInfo.Username == true and arg.Player.Name or arg.Player.DisplayName
		arg.Name.Text = name
		arg.Shadow.Text = name
		local n19 = visible and math.floor(math.clamp(playerMeasure(name, n17) + 4, n17, 230)) or 0
		local n20 = 0
		local n21 = 0

		if visible2 then
			n20 = 0 + n15
		end

		local n22 = 0

		if visible then
			if not (n20 > 0) then
				n22 = n20
			else
				n22 = n20 + n18
			end

			n20 = n22 + n19
		end

		local n23 = 0

		if visible3 then
			if not (n20 > 0) then
				n23 = n20
			else
				n23 = n20 + n18
			end

			n20 = n23 + n16
		end

		local n24 = math.max(n20, 1)
		local n25 = 1 / n24
		local n26 = 1 / v19
		arg.Billboard.Size = UDim2.fromOffset(n24, v19)
		arg.Avatar.Visible = visible2
		arg.Name.Visible = visible
		arg.Shadow.Visible = visible
		arg.ToolIcon.Visible = visible3
		arg.ToolShadow.Visible = visible3
		arg.Avatar.Position = UDim2.fromScale(n21 / n24, 0.5)
		arg.Avatar.Size = UDim2.fromScale(n15 / n24, n15 / v19)
		arg.Name.Position = UDim2.fromScale(n22 / n24, 0.5)
		arg.Name.Size = UDim2.fromScale(n19 / n24, n17 / v19)
		arg.Shadow.Position = UDim2.fromScale(n22 / n24 + n25, 0.5 + n26)
		arg.Shadow.Size = arg.Name.Size
		arg.ToolIcon.Position = UDim2.fromScale(n23 / n24, 0.5)
		arg.ToolIcon.Size = UDim2.fromScale(n16 / n24, n16 / v19)
		arg.ToolShadow.Position = UDim2.fromScale(n23 / n24 + n25, 0.5 + n26)
		arg.ToolShadow.Size = arg.ToolIcon.Size
	end

	local function playerCreateTag(player, character, head, hrp)
		local highlight = Instance.new("Highlight")
		highlight.Name = randomName()
		highlight.Adornee = character
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.FillColor = espColor(0, 67, 148)
		highlight.FillTransparency = 0.76
		highlight.OutlineColor = espColor(72, 207, 255)
		highlight.OutlineTransparency = 0.02
		highlight.Parent = playerRuntime
		hrp = hrp or head
		local n15 = 3.1

		if hrp ~= head then
			n15 = math.clamp(head.Position.Y - hrp.Position.Y + 3.1, 3.8, 6)
		end

		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Name = randomName()
		billboardGui.Adornee = hrp
		billboardGui.AlwaysOnTop = true
		billboardGui.LightInfluence = 0
		billboardGui.MaxDistance = math.huge
		billboardGui.Size = UDim2.fromOffset(1, 1)
		billboardGui.StudsOffsetWorldSpace = Vector3.new(0, n15, 0)
		billboardGui.Parent = playerRuntime
		local frame = Instance.new("Frame")
		frame.Name = randomName()
		frame.Size = UDim2.fromScale(1, 1)
		frame.BackgroundTransparency = 1
		frame.Parent = billboardGui
		local v19 = playerCreateImageLabel(frame, 2)
		v19.ScaleType = Enum.ScaleType.Crop
		local uiCorner = Instance.new("UICorner")
		uiCorner.Name = randomName()
		uiCorner.CornerRadius = UDim.new(1, 0)
		uiCorner.Parent = v19
		local v20 = playerCreateTextLabel(frame, 1)
		v20.TextColor3 = espColor(7, 19, 34)
		v20.TextTransparency = 0.05
		local v21 = playerCreateTextLabel(frame, 2)
		v21.TextColor3 = espColor(255, 255, 255)
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Name = randomName()
		playerSetupStroke(uiStroke, espColor(255, 255, 255), 0.044, 1.4)
		uiStroke.Parent = v21
		local uiGradient = Instance.new("UIGradient")
		uiGradient.Name = randomName()
		uiGradient.Color = strokeGradient
		uiGradient.Rotation = 90
		uiGradient.Parent = uiStroke
		local uiGradient2 = Instance.new("UIGradient")
		uiGradient2.Name = randomName()
		uiGradient2.Color = nameGradient
		uiGradient2.Rotation = 90
		uiGradient2.Parent = v21
		local v22 = playerCreateImageLabel(frame, 1)
		v22.ImageColor3 = espColor(0, 0, 0)
		v22.ImageTransparency = 0.35

		local tbl31 = {
			Player = player,
			Highlight = highlight,
			Billboard = billboardGui,
			Avatar = v19,
			Shadow = v20,
			Name = v21,
			ToolShadow = v22,
			ToolIcon = playerCreateImageLabel(frame, 2),
		}

		playerApplyLayout(tbl31)
		return tbl31
	end

	local function playerRestoreName(arg)
		if arg.NameHumanoid and arg.NameHumanoid.Parent and arg.NameDistance ~= nil then
			pcall(function()
				arg.NameHumanoid.NameDisplayDistance = arg.NameDistance
			end)
		end

		arg.NameHumanoid = nil
		arg.NameDistance = nil
	end

	local function playerHideName(arg, character)
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end

		if arg.NameHumanoid ~= humanoid then
			playerRestoreName(arg)
			arg.NameHumanoid = humanoid
			arg.NameDistance = humanoid.NameDisplayDistance
		end

		pcall(function()
			humanoid.NameDisplayDistance = 0
		end)
	end

	local function playerCleanEntry(arg)
		espLib.DisconnectAll(arg.CharacterConnections)

		if arg.Tag then
			pcall(function()
				arg.Tag.Highlight:Destroy()
			end)

			pcall(function()
				arg.Tag.Billboard:Destroy()
			end)

			arg.Tag = nil
		end

		playerRestoreName(arg)
		arg.Character = nil
	end

	local function playerUpdateTool(arg)
		if not arg.Tag or not arg.Character then
			return
		end
		local v19 = playerToolIcon(arg.Character:FindFirstChildOfClass("Tool"))
		arg.Tag.ToolIcon.Image = v19
		arg.Tag.ToolShadow.Image = v19
		playerApplyLayout(arg.Tag)
	end

	local function playerFetchThumbnail(arg, player, version)
		local image = playerThumbCache[player.UserId]

		if image == nil then
			local ok, result = pcall(function()
				return playersService:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
			end)

			image = ok and result or ""
			playerThumbCache[player.UserId] = image
		end

		if playerFrame and arg.Version == version and arg.Tag then
			arg.Tag.Avatar.Image = image
		end
	end

	local function playerBuildEntry(arg, player, character)
		playerCleanEntry(arg)
		arg.Version += 1
		local version = arg.Version
		if not playerFrame or not character then
			return
		end
		arg.Character = character

		task.spawn(function()
			local head = character:FindFirstChild("Head") or character:WaitForChild("Head", 5)
			if not playerFrame or arg.Version ~= version or not head or not head:IsA("BasePart") or not character:IsDescendantOf(workspace) then
				return
			end

			if not playerRuntime or not playerRuntime.Parent then
				playerRuntime = espLib.CreateRuntime()
			end

			local hrp = character:FindFirstChild("HumanoidRootPart")
			arg.Tag = playerCreateTag(player, character, head, hrp and hrp:IsA("BasePart") and hrp or nil)
			playerHideName(arg, character)

			local function deferToolUpdate()
				task.defer(function()
					if playerFrame and arg.Version == version then
						playerUpdateTool(arg)
					end
				end)
			end

			table.insert(arg.CharacterConnections, character.ChildAdded:Connect(function(child)
				if child:IsA("Tool") then
					deferToolUpdate()
				elseif child:IsA("Humanoid") then
					playerHideName(arg, character)
				end
			end))

			table.insert(arg.CharacterConnections, character.ChildRemoved:Connect(function(child)
				if child:IsA("Tool") then
					deferToolUpdate()
				end
			end))

			table.insert(arg.CharacterConnections, character.AncestryChanged:Connect(function()
				if arg.Version == version and not character:IsDescendantOf(workspace) then
					arg.Version += 1
					playerCleanEntry(arg)
				end
			end))

			playerUpdateTool(arg)
			playerFetchThumbnail(arg, player, version)
		end)
	end

	local function playerRemoveEntry(player)
		local v19 = playerActive[player]
		if not v19 then
			return
		end
		v19.Version += 1
		playerCleanEntry(v19)
		espLib.DisconnectAll(v19.PlayerConnections)
		playerActive[player] = nil
	end

	local function playerAddEntry(player)
		if player == playersService.LocalPlayer or playerActive[player] then
			return
		end

		local tbl31 = {
			Version = 0,
			Character = nil,
			Tag = nil,
			NameHumanoid = nil,
			NameDistance = nil,
			CharacterConnections = {},
			PlayerConnections = {},
		}

		playerActive[player] = tbl31

		table.insert(tbl31.PlayerConnections, player.CharacterAdded:Connect(function(character)
			playerBuildEntry(tbl31, player, character)
		end))

		table.insert(tbl31.PlayerConnections, player.CharacterRemoving:Connect(function(character)
			if tbl31.Character == character then
				tbl31.Version += 1
				playerCleanEntry(tbl31)
			end
		end))

		playerBuildEntry(tbl31, player, player.Character)
	end

	local function playerRelayout()
		for _, v19 in pairs(playerActive) do
			if v19.Tag then
				playerApplyLayout(v19.Tag)
			end
		end
	end

	local function playerDisable()
		playerFrame = false
		playerGeneration += 1
		espLib.DisconnectAll(playerConnections)
		local tbl31 = {}

		for k in pairs(playerActive) do
			table.insert(tbl31, k)
		end

		for _, v19 in ipairs(tbl31) do
			playerRemoveEntry(v19)
		end

		if playerRuntime then
			playerRuntime:Destroy()
			playerRuntime = nil
		end
	end

	local function playerEnable()
		if playerFrame then
			return
		end
		playerFrame = true
		playerGeneration += 1
		local v19 = playerGeneration
		playerRuntime = espLib.CreateRuntime()

		for _, player in ipairs(playersService:GetPlayers()) do
			playerAddEntry(player)
		end

		table.insert(playerConnections, playersService.PlayerAdded:Connect(playerAddEntry))
		table.insert(playerConnections, playersService.PlayerRemoving:Connect(playerRemoveEntry))
		local currentCamera = workspace.CurrentCamera

		if currentCamera then
			table.insert(playerConnections, currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(playerRelayout))
		end

		task.spawn(function()
			while true do
				if playerFrame and v19 == playerGeneration then
					task.wait(1)

					if not (not playerFrame or v19 ~= playerGeneration) then
						for k, v20 in pairs(playerActive) do
							local character = k.Character
							local adornee = v20.Tag and v20.Tag.Billboard.Parent and v20.Tag.Billboard.Adornee and v20.Tag.Billboard.Adornee:IsDescendantOf(workspace)

							if character and character:IsDescendantOf(workspace) and (v20.Character ~= character or not adornee) then
								playerBuildEntry(v20, k, character)
							end
						end

						continue
					end
				end

				break
			end
		end)
	end

	local function playerToggle(arg)
		playerEnabled = arg == true

		if playerEnabled then
			playerEnable()
		elseif playerFrame then
			playerDisable()
		end
	end

	playerToggleHandle = espSection:CreateToggle({
		Name = "ESP Players",
		Default = false,
		Callback = function(arg)
			playerEnabled = arg == true
			espLib.SyncSoon(function() playerToggle(playerEnabled) end)
		end,
	})

	espSection:CreateMultiDropdown({
		Name = "ESP Player Info",
		Options = { "Name", "Username", "Avatar", "Tool" },
		Default = { "Name", "Tool" },
		SubOf = playerToggleHandle,
		Callback = function(arg)
			local tbl31 = { Name = false, Username = false, Avatar = false, Tool = false }

			if type(arg) == "table" then
				for k, v19 in pairs(arg) do
					if type(v19) == "string" and tbl31[v19] ~= nil then
						tbl31[v19] = true
					elseif type(k) == "string" and v19 == true and tbl31[k] ~= nil then
						tbl31[k] = true
					end
				end
			end

			playerInfo = tbl31
			playerRelayout()
		end,
	})

	espSection:CreateSlider({
		Name = "ESP Player Size",
		Min = 50,
		Max = 200,
		Default = 75,
		Increment = 5,
		Unit = "%",
		SubOf = playerToggleHandle,
		Callback = function(arg)
			local num = tonumber(arg)

			if num and playerSizeScale ~= num / 100 then
				playerSizeScale = math.clamp(num / 100, 0.5, 2)
				playerRelayout()
			end
		end,
	})
end

espPlayersInit()

-- ============================================================
-- FIN DE LA PARTE 3
-- ============================================================
-- ============================================================
-- BOOTSTRAP: networking + tbl (módulos del juego)
-- Necesario para ESP (Parte 2/3) y Anti Guard (Parte 4)
-- ============================================================

local networking
local tbl
local localPlayer = playersService.LocalPlayer

do
	networking = replicatedStorage:WaitForChild("Packages", 10)
	networking = networking and networking:WaitForChild("Networking", 10)

	local function safeRequire(arg)
		local ok, result = pcall(function()
			return require(arg())
		end)
		return ok and result or nil
	end

	tbl = {
		EggState = safeRequire(function() return replicatedStorage.Client.EggState end),
		AreaEggs = safeRequire(function() return replicatedStorage.Shared.Types.AreaEggs end),
		ToolGameplayGuard = safeRequire(function() return replicatedStorage.Client.ToolGameplayGuard end),
		Assets = safeRequire(function() return replicatedStorage.Data.Assets end),
		Guards = safeRequire(function() return replicatedStorage.Data.Guards end),
		EggRecords = safeRequire(function() return replicatedStorage.Shared.Util.EggRecords end),
		Mutations = safeRequire(function() return replicatedStorage.Shared.Modules.Mutations end),
		Save = safeRequire(function() return replicatedStorage.Shared.Save end),
		FuseKernel = safeRequire(function() return replicatedStorage.Shared.Util.FuseKernel end),
		AreaEggCycle = safeRequire(function() return replicatedStorage.Shared.Util.AreaEggCycle end),
		AreaEggResetWall = safeRequire(function() return replicatedStorage.Client.AreaEggResetWall end),
		AreaEggResetCycle = safeRequire(function() return replicatedStorage.Data.AreaEggResetCycle end),
		Gears = safeRequire(function() return replicatedStorage.Data.Gears end),
		Areas = safeRequire(function() return replicatedStorage.Data.Areas end),
		LimitedEgg = safeRequire(function() return replicatedStorage.Data.LimitedEgg end),
		BrainrotEgg = safeRequire(function() return replicatedStorage.Data.BrainrotEgg end),
		MonsterEgg = safeRequire(function() return replicatedStorage.Data.MonsterEgg end),
	}

	-- Fix Save (Chilli compat)
	local save = tbl.Save

	if type(save) == "table" and (type(save.Get) ~= "function" or type(save.FieldSignal) ~= "function") then
		tbl.Save = setmetatable({
			Get = type(save.Get) == "function" and save.Get or save.Peek,
			FieldSignal = type(save.FieldSignal) == "function" and save.FieldSignal or save.Watch,
		}, { __index = save })
	end
end

-- ============================================================
-- BOOTSTRAP: tbl4 (movement + steal state compartido)
-- ============================================================

local tbl4 = {
	Steal = {
		Active = false,
		Carrying = false,
		CarryUid = nil,
		CarryAreaId = nil,
		Wanted = false,
		LastFinishedAt = 0,
		GuessedDrop = false,
		HeldSeenAt = 0,
	},
	SafeCarry = {
		Enabled = true,
		LineDrop = false,
		InstantHandle = nil,
		SlowUntil = 0,
		SlowFactor = 0.3,
		Mult = 1,
		Category = nil,
		PlanOk = true,
		LastSkip = nil,
		Seen = {},
	},
	Movement = {
		Owner = nil,
		PlaceWanted = false,
		StealFirst = false,
		MutationWanted = false,
		FracturedWanted = false,
	},
	AntiGuard = {
		Enabled = false,
		Busy = false,
		BusySince = 0,
		HitArms = 0,
		HitArmedAt = 0,
		Handle = nil,
		Render = nil,
		PanelHandle = nil,
		PanelShown = true,
		ShowPanel = nil,
		Options = nil,
	},
	InvisSuspended = false,
	InvisMech = false,
}

-- Helper: Root del personaje
tbl4.Root = function()
	local character = localPlayer.Character
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
	return humanoidRootPart and humanoidRootPart:IsDescendantOf(workspace) and humanoidRootPart or nil
end

-- Helper: distancia al punto
tbl4.DistanceTo = function(arg)
	local v14 = tbl4.Root()
	if not v14 or not arg then
		return math.huge
	end
	return (v14.Position - arg).Magnitude
end

-- Helper: Claim movement
tbl4.ClaimMovement = function(owner)
	local movement = tbl4.Movement
	if movement.Owner == nil or movement.Owner == owner or movement.Owner == "treadmill" and owner ~= "treadmill" or movement.Owner == "scramble" and owner == "steal" then
		movement.Owner = owner
		return true
	end
	return false
end

tbl4.ReleaseMovement = function(arg)
	if tbl4.Movement.Owner == arg then
		tbl4.Movement.Owner = nil
	end
end

-- Helper: Grounded
tbl4.Grounded = function(arg)
	if not arg then
		local character = localPlayer.Character
		arg = character and character:FindFirstChildOfClass("Humanoid")
	end

	if not arg or arg.Health <= 0 or arg.FloorMaterial == Enum.Material.Air then
		return false
	end

	local states = {
		[Enum.HumanoidStateType.Running] = true,
		[Enum.HumanoidStateType.RunningNoPhysics] = true,
		[Enum.HumanoidStateType.Landed] = true,
	}
	return states[arg:GetState()] == true
end

tbl4.Toggle = function(arg, arg2)
	if type(arg) ~= "table" then
		return arg2 == true
	end

	local ok, result = pcall(function()
		local controller = arg._controller
		return type(controller) == "table" and type(controller.GetValue) == "function" and controller.GetValue()
	end)

	if ok and type(result) == "boolean" then
		return result
	end

	for _, v14 in ipairs({ "Get", "GetValue" }) do
		local ok2, result2 = pcall(function()
			return arg[v14]
		end)

		if ok2 and type(result2) == "function" then
			local ok3, result3 = pcall(result2, arg)
			if ok3 and type(result3) == "boolean" then
				return result3
			end
		end
	end

	return arg2 == true
end

-- Helper: Inside base
tbl4.InsideBase = function(arg)
	if not arg then
		arg = tbl4.Root()
		arg = arg and arg.Position
	end

	if arg == nil then
		return false
	end
	local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
	local areas = world and world:FindFirstChild("Areas")
	areas = areas and areas:FindFirstChild("SeparationLine")
	return arg.X < (areas and areas:IsA("BasePart") and areas.Position.X or 552)
end

-- Helper: IsBatTool
tbl4.IsBatTool = function(arg)
	if typeof(arg) ~= "Instance" or not arg:IsA("Tool") then
		return false
	end

	if arg:GetAttribute("IsBat") == true then
		return true
	end
	local attribute = arg:GetAttribute("GearName")

	if type(attribute) == "string" then
		local gears = tbl.Gears
		local directory = type(gears) == "table" and gears.Directory or nil
		local flag = type(directory) == "table" and directory[attribute] or nil
		return type(flag) == "table" and flag.BatControllerData ~= nil
	end

	if arg:GetAttribute("ItemType") ~= nil then
		return false
	end
	local v14 = string.lower(arg.Name)
	local batList = { "bat", "katana", "axe", "staff", "club", "hammer", "sword", "blade" }

	for _, v15 in ipairs(batList) do
		if string.find(v14, v15, 1, true) then
			return true
		end
	end

	return false
end

tbl4.FindBat = function()
	local character = localPlayer.Character
	local tool = character and character:FindFirstChildWhichIsA("Tool")
	if tbl4.IsBatTool(tool) then
		return tool
	end
	local backpack = localPlayer:FindFirstChildOfClass("Backpack")

	if backpack then
		for _, child in ipairs(backpack:GetChildren()) do
			if tbl4.IsBatTool(child) then
				return child
			end
		end
	end

	if character then
		for _, child in ipairs(character:GetChildren()) do
			if tbl4.IsBatTool(child) then
				return child
			end
		end
	end

	return nil
end

tbl4.WalkSpeed = function()
	local character = localPlayer.Character
	character = character and character:FindFirstChildOfClass("Humanoid")
	character = character and character.WalkSpeed or 16

	local ok, result = pcall(function()
		local leaderstats = localPlayer:FindFirstChild("leaderstats")
		leaderstats = leaderstats and leaderstats:FindFirstChild("Speed")
		local TreadmillUtil = require(replicatedStorage.Shared.Util.TreadmillUtil)
		return leaderstats and TreadmillUtil.SpeedPowerToWalkSpeed(leaderstats.Value) or nil
	end)

	if ok and tonumber(result) and result > 0 then
		return math.min(character, result)
	end

	return character
end

-- Helpers de detección de estado
tbl4.IsNight = function()
	local areaEggCycle = tbl.AreaEggCycle
	if type(areaEggCycle) ~= "table" or type(areaEggCycle.IsNightPhase) ~= "function" then
		return false
	end
	local ok, result = pcall(areaEggCycle.IsNightPhase, workspace:GetServerTimeNow())
	return ok and result == true
end

tbl4.WallSealed = function()
	local areaEggResetWall = tbl.AreaEggResetWall
	if type(areaEggResetWall) ~= "table" or type(areaEggResetWall.IsSealed) ~= "function" then
		return false
	end
	local ok, result = pcall(areaEggResetWall.IsSealed)
	return ok and result == true
end

tbl4.WallOpenDelay = function()
	local areaEggResetCycle = tbl.AreaEggResetCycle
	if type(areaEggResetCycle) ~= "table" then
		return 5
	end
	return (tonumber(areaEggResetCycle.WallCountdownDelayAfterDayStartsSeconds) or 2) + (tonumber(areaEggResetCycle.WallCountdownSeconds) or 3)
end

tbl4.ScrambleLostPart = function(arg)
	local eggState = tbl.EggState
	if type(eggState) ~= "table" or type(eggState.ReadFieldEggs) ~= "function" then
		return false
	end
	local ok, result = pcall(eggState.ReadFieldEggs)
	if not ok or type(result) ~= "table" or type(result.LostParts) ~= "table" then
		return false
	end
	local lostParts = result.LostParts

	if lostParts[arg] then
		return true
	end

	for _, lostPart in pairs(lostParts) do
		if lostPart == arg then
			return true
		end
	end

	return false
end

-- ============================================================
-- ANTI GUARD (panel flotante + lógica completa)
-- ============================================================

local antiGuard = tbl4.AntiGuard

-- Configs
local function fn20(arg, arg2, arg3, arg4, arg5, arg6)
	local tbl15 = {}

	for i = 1, arg do
		tbl15[#tbl15 + 1] = { At = arg2 + arg3 * (i - 1), To = "home" }
	end

	tbl15[#tbl15 + 1] = { At = arg4, To = "start" }

	return {
		Target = "home",
		LineOffset = 8,
		Height = 0,
		OffsetX = 0,
		OffsetZ = 0,
		Jitter = 0,
		Point = false,
		Disguise = true,
		Limp = false,
		Facing = "Zero",
		Freeze = true,
		StartAt = 0,
		StartRandom = 0,
		HopRandom = 0.085,
		HoldRandom = 0.395,
		Steps = tbl15,
		ReleaseAt = arg5,
		WeldScanGap = 0.03,
		BusyLimit = arg6,
	}
end

local chilliAntiGuard = {
	LightDark = {
		Target = "line",
		LineOffset = 8,
		Height = 45,
		OffsetX = -90,
		OffsetZ = -35,
		Jitter = 0,
		Point = false,
		Disguise = true,
		Limp = true,
		Facing = "Zero",
		Freeze = false,
		StartAt = 0,
		Steps = {
			{ At = 0.1, To = "home" },
			{ At = 0.33, To = "home" },
			{ At = 0.56, To = "home" },
			{ At = 0.75, To = "start" },
		},
		ReleaseAt = 0.8,
		WeldScanGap = 0.03,
		BusyLimit = 2.5,
	},
	Default = fn20(25, 0, 0.05, 1.27, 1.52, 2.5),
}

pcall(function()
	genv.PotentAntiGuard = chilliAntiGuard
end)

-- Paletas del panel
local tbl15 = {
	Card = espColor(15, 15, 19),
	CardTop = espColor(24, 22, 28),
	Stroke = espColor(48, 46, 56),
	Text = espColor(240, 238, 244),
	AccentA = espColor(255, 72, 72),
	AccentB = espColor(255, 150, 60),
	Good = espColor(80, 220, 140),
	Work = espColor(255, 190, 70),
	Bad = espColor(240, 90, 90),
	Off = espColor(58, 56, 66),
}

-- Referencias a Rockstar Rift location (para fn27)
local antiGuardRiftPaths = {
	{ Path = { "GearGiver_Slap", "Podium" }, Offset = Vector3.new(-16.415, 21.072, -6.106) },
	{
		Path = { "World", "Machines", "RiftMachine", "Rift", "Meshes/VoidPortal_Cube.003" },
		Offset = Vector3.new(-26.776, 1.75, 18.665),
	},
	{
		Path = { "__OBJECTS", "Machines", "RiftMachine", "Rift", "Meshes/VoidPortal_Cube.003" },
		Offset = Vector3.new(-26.776, 1.75, 18.665),
	},
}

local n4 = 52
local flag4 = true
local antiGuardConnections = {}
local antiGuardState = {
	AreaId = nil,
	SignalCarrying = false,
	WeldCarrying = false,
	Carrying = false,
	Active = false,
	Disguise = nil,
	FlashRequest = nil,
	FlashUntil = 0,
}

local function fn19()
	local tbl19 = {}

	for i = 1, math.random(10, 16) do
		tbl19[i] = string.char(math.random(97, 122))
	end

	return table.concat(tbl19)
end

local hui = nil
pcall(function()
	hui = gethui()
end)
hui = hui or coreGui

local function fn20instance(arg, parent, arg2)
	local instance = Instance.new(arg)
	instance.Name = fn19()
	local v10 = pairs
	local tbl19 = arg2 or {}

	for k, v11 in v10(tbl19) do
		instance[k] = v11
	end

	instance.Parent = parent
	return instance
end

local function fn21(arg, arg2, arg3, arg4)
	local ok, result = pcall(function()
		local v10 = tweenService
		local create = v10.Create
		local tweenInfo = TweenInfo.new
		local v11 = arg4
		local quint

		if arg4 then
			quint = v11
		else
			quint = Enum.EasingStyle.Quint
		end

		return create(v10, arg, tweenInfo(arg2, quint, Enum.EasingDirection.Out), arg3)
	end)

	if ok and result then
		result:Play()
	end
end

-- Panel UI
local ScreenGui = fn20instance("ScreenGui", nil, {
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	DisplayOrder = -100,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
})
ScreenGui:SetAttribute("PotentOwned", true)

local Frame = fn20instance("Frame", ScreenGui, {
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.new(0.5, 0, 1, -120),
	Size = UDim2.fromOffset(226, 52),
	BackgroundTransparency = 1,
})

local UIScale = fn20instance("UIScale", Frame, { Scale = 1 })
local Frame2 = fn20instance("Frame", Frame, { Size = UDim2.fromScale(1, 1), BackgroundColor3 = tbl15.Card, BorderSizePixel = 0, Active = true })
fn20instance("UICorner", Frame2, { CornerRadius = UDim.new(0, 14) })
local UIScale2 = fn20instance("UIScale", Frame2, { Scale = 0.86 })
fn20instance("UIGradient", Frame2, { Color = ColorSequence.new(tbl15.CardTop, tbl15.Card), Rotation = 90 })

local UIGradient, Frame3, render, flash
do
	local UIStroke = fn20instance("UIStroke", Frame2, {
		Thickness = 1.5,
		Color = espColor(255, 255, 255),
		Transparency = 0.2,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	})

	UIGradient = fn20instance("UIGradient", UIStroke, { Color = ColorSequence.new(tbl15.Stroke, tbl15.Stroke) })

	Frame3 = fn20instance("Frame", Frame2, {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 10, 0.5, 0),
		Size = UDim2.fromOffset(36, 36),
		BackgroundColor3 = espColor(28, 26, 32),
		BorderSizePixel = 0,
		ZIndex = 2,
	})

	fn20instance("UICorner", Frame3, { CornerRadius = UDim.new(0, 11) })
	local UIStroke2 = fn20instance("UIStroke", Frame3, { Thickness = 1.5, Color = tbl15.Off, ApplyStrokeMode = Enum.ApplyStrokeMode.Border })

	local ImageLabel = fn20instance("ImageLabel", Frame3, {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.86, 0.86),
		BackgroundTransparency = 1,
		Image = "rbxassetid://128961717706452",
		ImageTransparency = 0.35,
		ScaleType = Enum.ScaleType.Crop,
		ZIndex = 3,
	})

	fn20instance("UICorner", ImageLabel, { CornerRadius = UDim.new(0, 8) })
	local UIScale3 = fn20instance("UIScale", ImageLabel, { Scale = 1 })
	local color3 = espColor

	fn20instance("UIGradient", fn20instance("TextLabel", Frame2, {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 56, 0, 7),
		Size = UDim2.new(1, -112, 0, 15),
		Font = Enum.Font.BuilderSansExtraBold,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = espColor(255, 255, 255),
		Text = "Potent Hub",
		ZIndex = 2,
	}), { Color = ColorSequence.new(espColor(255, 120, 100), color3(255, 190, 110)) })

	fn20instance("TextLabel", Frame2, {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 56, 0, 22),
		Size = UDim2.new(1, -112, 0, 20),
		Font = Enum.Font.GothamBlack,
		TextSize = 15,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = tbl15.Text,
		Text = "Anti Guard",
		ZIndex = 2,
	})

	local TextButton = fn20instance("TextButton", Frame2, {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -12, 0.5, 0),
		Size = UDim2.fromOffset(42, 22),
		BackgroundColor3 = espColor(255, 255, 255),
		AutoButtonColor = false,
		BorderSizePixel = 0,
		Text = "",
		ZIndex = 2,
	})

	fn20instance("UICorner", TextButton, { CornerRadius = UDim.new(1, 0) })
	local UIGradient2 = fn20instance("UIGradient", TextButton, { Color = ColorSequence.new(tbl15.Off, tbl15.Off) })

	local Frame4 = fn20instance("Frame", TextButton, {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 3, 0.5, 0),
		Size = UDim2.fromOffset(16, 16),
		BackgroundColor3 = espColor(245, 245, 250),
		BorderSizePixel = 0,
		ZIndex = 3,
	})

	fn20instance("UICorner", Frame4, { CornerRadius = UDim.new(1, 0) })

	local function fn23()
		return antiGuard.Enabled and tbl15.AccentA or tbl15.Off
	end

	render = function(arg)
		local n5 = arg and 0 or 0.28

		if antiGuard.Enabled then
			UIGradient2.Color = ColorSequence.new(tbl15.AccentA, tbl15.AccentB)
			local v10 = UIGradient
			local colorSequence = ColorSequence.new
			local tbl19 = {}
			local v11 = ColorSequenceKeypoint.new(0, tbl15.Stroke)
			local v12 = ColorSequenceKeypoint.new(0.45, tbl15.AccentA)
			local v13 = ColorSequenceKeypoint.new(0.55, tbl15.AccentB)
			local new = ColorSequenceKeypoint.new
			local stroke = tbl15.Stroke
			tbl19[1] = v11
			tbl19[2] = v12
			tbl19[3] = v13

			do
				local values = table.pack(new(1, stroke))
				table.move(values, 1, values.n, 4, tbl19)
			end

			v10.Color = colorSequence(tbl19)
			fn21(Frame4, n5, { Position = UDim2.new(1, -19, 0.5, 0) }, Enum.EasingStyle.Back)
			fn21(ImageLabel, n5, { ImageTransparency = 0 })
			fn21(UIStroke, 0.3, { Transparency = 0 })
		else
			UIGradient2.Color = ColorSequence.new(tbl15.Off, tbl15.Off)
			UIGradient.Color = ColorSequence.new(tbl15.Stroke, tbl15.Stroke)
			fn21(Frame4, n5, { Position = UDim2.new(0, 3, 0.5, 0) }, Enum.EasingStyle.Back)
			fn21(ImageLabel, n5, { ImageTransparency = 0.35 })
			fn21(UIStroke, 0.3, { Transparency = 0.2 })
		end

		if antiGuardState.FlashUntil <= os.clock() then
			fn21(UIStroke2, n5, { Color = fn23() })
		end
	end

	flash = function(arg, arg2)
		antiGuardState.FlashRequest = { Color = arg, Hold = arg2 }
	end

	local function fn24()
		local flashRequest = antiGuardState.FlashRequest
		if not flashRequest then
			return
		end
		antiGuardState.FlashRequest = nil
		antiGuardState.FlashUntil = os.clock() + (flashRequest.Hold or 0)
		fn21(UIStroke2, 0.2, { Color = flashRequest.Color })

		if flashRequest.Hold then
			task.delay(flashRequest.Hold, function()
				local flag5 = flag4

				if flag4 then
					local flashUntil = antiGuardState.FlashUntil
					flag5 = os.clock() >= flashUntil
				end

				if flag5 then
					fn21(UIStroke2, 0.3, { Color = fn23() })
				end
			end)
		end
	end

	local function fn25(arg)
		local handle = antiGuard.Handle
		if type(handle) ~= "table" then
			return
		end

		for _, v10 in ipairs({ "Set", "SetValue" }) do
			local ok, result = pcall(function()
				return handle[v10]
			end)

			if ok and type(result) == "function" and pcall(result, handle, arg) then
				return
			end
		end
	end

	antiGuard.Render = render

	local TextButton2 = fn20instance("TextButton", Frame2, {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "",
		ZIndex = 10,
	})

	antiGuardConnections[#antiGuardConnections + 1] = TextButton2.MouseButton1Click:Connect(function()
		antiGuard.Enabled = not antiGuard.Enabled
		render(false)
		fn25(antiGuard.Enabled)
		fn21(UIScale3, 0.12, { Scale = 1.15 })

		task.delay(0.12, function()
			if flag4 then
				fn21(UIScale3, 0.3, { Scale = 1 }, Enum.EasingStyle.Back)
			end
		end)
	end)

	local size = TextButton.Size

	antiGuardConnections[#antiGuardConnections + 1] = TextButton2.MouseEnter:Connect(function()
		fn21(TextButton, 0.15, { Size = size + UDim2.fromOffset(2, 2) })
	end)

	antiGuardConnections[#antiGuardConnections + 1] = TextButton2.MouseLeave:Connect(function()
		fn21(TextButton, 0.15, { Size = size })
	end)

	local tbl19 = {
		Hotbar = true,
		HotBar = true,
		Toolbar = true,
		ToolBar = true,
		Backpack = true,
		Inventory = true,
	}

	local tbl20 = {}
	local huge = math.huge
	local huge2 = math.huge
	local rotation = 0
	local n5 = nil

	local function fn26(arg)
		while arg do
			if arg:IsA("GuiObject") and not arg.Visible then
				return false
			end

			if arg:IsA("LayerCollector") then
				return arg.Enabled
			end
			arg = arg.Parent
		end

		return false
	end

	local function fn27()
		local ok, result = pcall(function()
			return guiService:GetGuiInset().Y
		end)

		return ok and result or 0
	end

	local function fn28(arg)
		local v10 = nil

		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant:IsA("GuiButton") and descendant.Visible and descendant.AbsoluteSize.Y > 8 and descendant.AbsoluteSize.X > 8 then
				local y = descendant.AbsolutePosition.Y

				if not v10 or y < v10 then
					v10 = y
				end
			end
		end

		return v10 or arg.AbsolutePosition.Y
	end

	local function fn29()
		table.clear(tbl20)
		local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
		if not playerGui then
			return
		end

		for _, descendant in ipairs(playerGui:GetDescendants()) do
			if descendant:IsA("GuiObject") and tbl19[descendant.Name] then
				tbl20[#tbl20 + 1] = descendant
			end
		end
	end

	local function fn30()
		local tbl21 = {}

		pcall(function()
			if not starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) then
				return
			end

			for _, child in ipairs(coreGui.RobloxGui.Backpack:GetChildren()) do
				if child:IsA("GuiObject") then
					tbl21[#tbl21 + 1] = child
				end
			end
		end)

		for _, v10 in ipairs(tbl20) do
			if v10.Parent then
				tbl21[#tbl21 + 1] = v10
			end
		end

		return tbl21
	end

	local function fn31()
		local currentCamera = workspace.CurrentCamera
		if not currentCamera then
			return
		end
		local viewportSize = currentCamera.ViewportSize
		if viewportSize.X < 10 or viewportSize.Y < 10 then
			return
		end
		local flag5 = userInputService.TouchEnabled and not userInputService.KeyboardEnabled
		local n6 = math.min(viewportSize.X / 1280, viewportSize.Y / 720)
		local scale = flag5 and math.clamp(n6 * 1.05, 0.6, 0.8) * 0.97 or math.clamp(n6, 0.8, 1.1)
		UIScale.Scale = scale
		local backgroundTransparency = flag5 and 0.3 or 0

		if Frame2.BackgroundTransparency ~= backgroundTransparency then
			Frame2.BackgroundTransparency = backgroundTransparency
			Frame3.BackgroundTransparency = backgroundTransparency
		end

		local n7 = viewportSize.Y - 8 * scale
		local flag6 = false

		for _, v10 in ipairs(fn30()) do
			local ok, result = pcall(fn26, v10)

			if ok and result then
				local absoluteSize = v10.AbsoluteSize
				local y = v10.AbsolutePosition.Y

				if absoluteSize.X > 20 and absoluteSize.Y > 20 and absoluteSize.Y < viewportSize.Y * 0.4 and y + absoluteSize.Y / 2 > viewportSize.Y * 0.5 then
					local ok2, result2 = pcall(fn28, v10)
					y = ok2 and result2 or y
					flag6 = true
					n7 = math.min(n7, y + fn27(v10))
				end
			end
		end

		if flag6 then
			n5 = viewportSize.Y - n7
		elseif n5 then
			n7 = viewportSize.Y - n5
		end

		local n8 = math.max(n7 - (flag5 and 4 or 6) * scale - n4 * scale / 2, n4 * scale / 2 + 8)
		Frame.Position = UDim2.new(0.5, 0, 0, n8)
	end

	antiGuardConnections[#antiGuardConnections + 1] = RunService.RenderStepped:Connect(function(deltaTime)
		fn24()
		huge += deltaTime
		huge2 += deltaTime

		if huge >= 3 then
			huge = 0
			pcall(fn29)
		end

		if huge2 >= 0.2 then
			huge2 = 0
			pcall(fn31)
		end

		if antiGuard.Enabled then
			rotation = (rotation + deltaTime * (antiGuardState.Active and 360 or 90)) % 360
			UIGradient.Rotation = rotation
		end
	end)
end

render(true)

antiGuard.ShowPanel = function(arg)
	ScreenGui.Enabled = arg == true
end

ScreenGui.Enabled = antiGuard.PanelShown == true
ScreenGui.Parent = hui
fn21(UIScale2, 0.45, { Scale = 1 }, Enum.EasingStyle.Back)

-- ============================================================
-- ANTI GUARD: lógica de moverse y esconderse
-- ============================================================

local starterGui = game:GetService("StarterGui")

local function fn23l()
	local v10 = tbl4.Root()
	if not v10 then
		return nil
	end

	for _, child in ipairs(workspace:GetChildren()) do
		if child:IsA("Model") and child:FindFirstChild("Hitbox") then
			for _, descendant in ipairs(child:GetDescendants()) do
				if descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint") or descendant:IsA("RigidConstraint") then
					local ok, result, result2 = pcall(function()
						return descendant.Part0, descendant.Part1
					end)

					if ok and (result == v10 or result2 == v10) then
						return child
					end
				end
			end
		end
	end

	return nil
end

local function fn24l()
	local function fn25(arg, parent)
		local tbl19 = {}

		for _, descendant in ipairs(arg:GetDescendants()) do
			tbl19[descendant] = descendant.Archivable

			pcall(function()
				descendant.Archivable = true
			end)
		end

		local archivable = arg.Archivable
		arg.Archivable = true

		local ok, result = pcall(function()
			return arg:Clone()
		end)

		arg.Archivable = archivable

		for k, v10 in pairs(tbl19) do
			pcall(function()
				k.Archivable = v10
			end)
		end

		if not ok or not result then
			return nil
		end
		result.Name = fn19()

		for _, descendant in ipairs(result:GetDescendants()) do
			if descendant:IsA("LuaSourceContainer") or descendant:IsA("Sound") or descendant:IsA("ForceField") or descendant:IsA("JointInstance") or descendant:IsA("Constraint") or descendant:IsA("WeldConstraint") or descendant:IsA("BodyMover") or descendant:IsA("ProximityPrompt") or descendant:IsA("BillboardGui") then
				pcall(function()
					descendant:Destroy()
				end)
			elseif descendant:IsA("BasePart") then
				descendant.Anchored = true
				descendant.CanCollide = false
				descendant.CanQuery = false
				descendant.CanTouch = false
			elseif descendant:IsA("Humanoid") then
				descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
				descendant.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
			end
		end

		result.Parent = parent
		return result
	end

	local function fn26l(arg, arg2)
		local currentCamera = workspace.CurrentCamera
		if not arg or not currentCamera or antiGuardState.Disguise then
			return
		end
		arg2 = arg2 or Vector3.zero
		local disguise = { Camera = currentCamera, CameraType = currentCamera.CameraType, CameraCFrame = currentCamera.CFrame, Copies = {}, Hidden = {} }
		antiGuardState.Disguise = disguise
		local tbl19 = { arg }
		local ok, result = pcall(fn23l)

		if ok and result then
			tbl19[#tbl19 + 1] = result
		end

		for _, v10 in ipairs(tbl19) do
			for _, descendant in ipairs(v10:GetDescendants()) do
				if descendant:IsA("BasePart") or descendant:IsA("Decal") or descendant:IsA("Texture") then
					disguise.Hidden[#disguise.Hidden + 1] = descendant
				end
			end
		end

		local function fn27l()
			for _, v10 in ipairs(disguise.Hidden) do
				pcall(function()
					v10.LocalTransparencyModifier = 1
				end)
			end

			pcall(function()
				if currentCamera.CameraType ~= Enum.CameraType.Scriptable then
					currentCamera.CameraType = Enum.CameraType.Scriptable
				end

				currentCamera.CFrame = disguise.CameraCFrame
			end)
		end

		fn27l()
		disguise.BindName = fn19()

		if not pcall(function()
			RunService:BindToRenderStep(disguise.BindName, Enum.RenderPriority.Last.Value + 1, fn27l)
		end) then
			disguise.BindName = nil
			disguise.Link = RunService.RenderStepped:Connect(fn27l)
		end

		disguise.Beat = RunService.Heartbeat:Connect(fn27l)

		for _, v10 in ipairs(tbl19) do
			local ok2, result2 = pcall(fn25, v10, currentCamera)

			if ok2 and result2 then
				if arg2.Magnitude > 0.01 then
					for _, descendant in ipairs(result2:GetDescendants()) do
						if descendant:IsA("BasePart") then
							pcall(function()
								descendant.CFrame = descendant.CFrame + arg2
							end)
						end
					end
				end

				disguise.Copies[#disguise.Copies + 1] = result2
			end
		end
	end

	fn24l = function()
		local disguise = antiGuardState.Disguise
		if not disguise then
			return
		end
		antiGuardState.Disguise = nil

		if disguise.BindName then
			pcall(function()
				RunService:UnbindFromRenderStep(disguise.BindName)
			end)
		end

		if disguise.Link then
			pcall(function()
				disguise.Link:Disconnect()
			end)
		end

		if disguise.Beat then
			pcall(function()
				disguise.Beat:Disconnect()
			end)
		end

		for _, v10 in ipairs(disguise.Hidden) do
			pcall(function()
				v10.LocalTransparencyModifier = 0
			end)
		end

		pcall(function()
			disguise.Camera.CameraType = disguise.CameraType
		end)

		for _, copy in ipairs(disguise.Copies) do
			pcall(function()
				copy:Destroy()
			end)
		end
	end

	local function fn27l()
		for _, v10 in ipairs(antiGuardRiftPaths) do
			local v11 = workspace

			for _, v12 in ipairs(v10.Path) do
				v11 = v11 and v11:FindFirstChild(v12) or nil
			end

			if v11 and v11:IsA("BasePart") then
				return v11.CFrame:PointToWorldSpace(v10.Offset)
			end
		end

		return Vector3.new(528.7, 70.57, -364.11)
	end

	local function fn28l(arg, arg2, arg3, arg4, arg5)
		local cFrame = CFrame.new(arg3) * arg4

		pcall(function()
			arg:PivotTo(cFrame)
		end)

		if (arg2.Position - arg3).Magnitude > 3 then
			pcall(function()
				arg2.CFrame = cFrame
			end)
		end

		if arg5 == false then
			return
		end

		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant:IsA("BasePart") then
				pcall(function()
					descendant.AssemblyLinearVelocity = Vector3.zero
					descendant.AssemblyAngularVelocity = Vector3.zero
				end)
			end
		end
	end

	local function fn29l()
		local areaId = antiGuardState.AreaId

		if type(areaId) ~= "string" or areaId == "" then
			areaId = type(tbl4.Steal) == "table" and tbl4.Steal.CarryAreaId or nil
		end

		if type(areaId) ~= "string" or areaId == "" then
			local attribute = localPlayer:GetAttribute("AreaId")
			areaId = type(attribute) == "string" and attribute or nil
		end

		return areaId
	end

	local tbl19 = { lightdark = "LightDark" }

	local function fn30l(arg)
		if type(arg) ~= "string" then
			return "Default"
		end
		local lower = string.lower
		local v10 = string.gsub(arg, "[^%a]", "")
		return tbl19[lower(v10)] or "Default"
	end

	local function fn31l()
		local ok, result = pcall(function()
			return genv.PotentAntiGuard
		end)

		if ok and type(result) == "table" then
			if type(result.Steps) == "table" then
				return result
			end
			local default = result[fn30l(fn29l())] or result.Default
			if type(default) == "table" then
				return default
			end
		end

		return chilliAntiGuard[fn30l(fn29l())] or chilliAntiGuard.Default
	end

	local function fn32l()
		local v10 = fn31l()
		local options = antiGuard.Options
		if type(options) ~= "table" or options.Destination == "Safe Zone" and not options.Stay then
			return v10
		end
		local tbl20 = {}

		for k, v11 in pairs(v10) do
			tbl20[k] = v11
		end

		if options.Destination == "Next To Line" then
			tbl20.Target = "edge"
			tbl20.LineOffset = 6
			tbl20.Height = 0
			tbl20.OffsetX = 0
			tbl20.OffsetZ = 0
		elseif options.Destination == "Saved Spot" and typeof(options.Spot) == "Vector3" then
			tbl20.Target = "point"
			tbl20.Point = options.Spot
			tbl20.Height = 0
			tbl20.OffsetX = 0
			tbl20.OffsetZ = 0
		end

		if options.Stay and type(v10.Steps) == "table" then
			local steps = {}

			for _, step in ipairs(v10.Steps) do
				if type(step) == "table" and step.To ~= "start" then
					steps[#steps + 1] = step
				end
			end

			tbl20.Steps = steps
		end

		return tbl20
	end

	local function fn33l(arg, arg2)
		local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
		world = world and world:FindFirstChild("Areas")
		world = world and world:FindFirstChild("SeparationLine")

		if world and world:IsA("BasePart") then
			local cFrame = world.CFrame
			local v10 = (Vector3.new(0, 1, 0)):Cross(world.Size.X >= world.Size.Z and cFrame.RightVector or cFrame.LookVector)
			local vector = Vector3.new(v10.X, 0, v10.Z)

			if vector.Magnitude > 0.001 then
				local unit = vector.Unit
				local n5 = cFrame.Position + ((arg2 - cFrame.Position):Dot(unit) >= 0 and -unit or unit) * (tonumber(arg.LineOffset) or 8)
				return Vector3.new(n5.X, arg2.Y + 0.5, n5.Z)
			end
		end

		return nil
	end

	local function fn34l(arg, arg2)
		local str = tostring(arg.Target or "home")
		if str == "sky" then
			return arg2
		end

		if str == "point" then
			if typeof(arg.Point) == "Vector3" then
				return arg.Point
			end
			return arg2
		end

		if str == "line" then
			local v10 = fn33l(arg, arg2)
			if v10 then
				return v10
			end
		end

		if str == "edge" then
			local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
			world = world and world:FindFirstChild("Areas")
			world = world and world:FindFirstChild("SeparationLine")

			if world and world:IsA("BasePart") then
				local cFrame = world.CFrame
				local rightVector = world.Size.X >= world.Size.Z and cFrame.RightVector or cFrame.LookVector
				local vector = Vector3.new(rightVector.X, 0, rightVector.Z)
				local v10 = (Vector3.new(0, 1, 0)):Cross(vector)
				local vector2 = Vector3.new(v10.X, 0, v10.Z)

				if vector2.Magnitude > 0.001 and vector.Magnitude > 0.001 then
					local unit = vector.Unit
					local unit2 = vector2.Unit
					local n5 = arg2 - cFrame.Position
					local n6 = -world.Size.Magnitude / 2
					local n7 = world.Size.Magnitude / 2
					local n8 = cFrame.Position + unit * math.clamp(n5:Dot(unit), n6, n7) + (n5:Dot(unit2) >= 0 and unit2 or -unit2) * (tonumber(arg.LineOffset) or 6)
					local v11 = fn27l()
					return Vector3.new(n8.X, (v11 and v11.Y or arg2.Y) + 3, n8.Z)
				end
			end
		end

		return fn27l()
	end

	local function fn35l(arg, arg2)
		return fn34l(arg, arg2) + Vector3.new(tonumber(arg.OffsetX) or 0, tonumber(arg.Height) or 0, tonumber(arg.OffsetZ) or 0)
	end

	local function fn36l()
		antiGuardState.Active = false
		antiGuard.Busy = false
	end

	local function fn37l(arg)
		local n5 = math.max(tonumber(arg) or 0, 0)
		if n5 <= 0 then
			return 0
		end
		return (math.random() * 2 - 1) * n5
	end

	local function fn38l(arg)
		local steps = type(arg.Steps) == "table" and arg.Steps or {}
		local n5 = tonumber(arg.ReleaseAt) or 0
		local n6 = math.max(tonumber(arg.StartAt) or 0, 0)
		local n7 = math.max(tonumber(arg.StartRandom) or 0, 0)
		local n8 = math.max(tonumber(arg.HopRandom) or 0, 0)
		local n9 = math.max(tonumber(arg.HoldRandom) or 0, 0)
		if n7 <= 0 and n8 <= 0 and n9 <= 0 then
			return steps, n5, n6
		end
		local n10 = math.max(n6 + fn37l(n7), 0)
		local tbl20 = {}
		local n11 = 0
		local n12 = 0

		for i, step in ipairs(steps) do
			if type(step) == "table" then
				local n13 = math.max(tonumber(step.At) or 0, 0)
				n12 = math.max(n12 + math.max(n13 - n11, 0) + fn37l(step.To == "start" and n9 or n8), n10)
				tbl20[i] = { At = n12, To = step.To, Glide = step.Glide }
				n11 = n13
				continue
			end

			break
		end

		return tbl20, n12 + math.max(n5 - n11, 0), n10
	end

	local function fn39l(arg)
		local character = localPlayer.Character
		local v10 = tbl4.Root()
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")

		if not v10 or not humanoid or humanoid.Health <= 0 then
			fn36l()
			flash(tbl15.Bad, 1.6)
			return
		end

		local function fn40l()
			return flag4 and v10.Parent ~= nil and humanoid.Parent ~= nil and humanoid.Health > 0
		end

		local platformStand = humanoid.PlatformStand
		local cFrame = v10.CFrame
		local position = cFrame.Position
		local v11 = fn32l()
		local v12, v13, v14 = fn38l(v11)
		local flag5 = v11.Freeze ~= false
		local str = tostring(v11.Facing or "Keep")
		local n5 = math.max(tonumber(v11.Jitter) or 0, 0)
		local cframe = str == "Zero" and CFrame.new() or cFrame.Rotation

		local function fn41l()
			if str == "Spin" then
				return CFrame.Angles(0, math.rad(math.random(0, 359)), 0)
			end
			return cframe
		end

		local function fn42l(arg2)
			if n5 <= 0 then
				return arg2
			end
			return arg2 + Vector3.new((math.random() * 2 - 1) * n5, 0, (math.random() * 2 - 1) * n5)
		end

		local v15 = fn35l(v11, position)

		local function fn43l(arg2)
			while fn40l() and os.clock() - arg < arg2 do
				RunService.Heartbeat:Wait()

				if flag5 then
					pcall(function()
						v10.AssemblyLinearVelocity = Vector3.zero
						v10.AssemblyAngularVelocity = Vector3.zero
					end)
				end
			end

			return fn40l()
		end

		local function fn44l(arg2, arg3)
			fn28l(character, v10, arg2, arg3, flag5)
			RunService.PreSimulation:Wait()

			if fn40l() and (v10.Position - arg2).Magnitude > 3 then
				fn28l(character, v10, arg2, arg3, flag5)
			end
		end

		pcall(function()
			humanoid.BreakJointsOnDeath = false
		end)

		if v11.Disguise ~= false then
			pcall(fn26l, character, Vector3.zero)
		end

		flash(tbl15.Work)

		if fn43l(v14) and v11.Limp ~= false then
			humanoid.PlatformStand = true
		end

		local v16 = position

		for _, v17 in ipairs(v12) do
			local flag6 = type(v17) ~= "table"

			if not flag6 then
				flag6 = not fn43l(tonumber(v17.At) or 0)
			end

			if not flag6 then
				local flag7 = v17.To == "start" and position or fn42l(v15)
				local v18 = fn41l()

				if type(v17.Glide) == "table" and #v17.Glide > 0 then
					for _, v19 in ipairs(v17.Glide) do
						if fn40l() then
							local clamp = math.clamp
							local n6 = tonumber(v19) or 1
							local v20 = fn28l
							local v21 = clamp(n6, 0, 1)
							v20(character, v10, v16:Lerp(flag7, v21), v18, flag5)
							RunService.Heartbeat:Wait()
							continue
						end

						break
					end

					v16 = flag7
				else
					fn44l(flag7, v18)
					v16 = flag7
				end

				continue
			end

			break
		end

		fn43l(v13)

		pcall(function()
			humanoid.PlatformStand = platformStand
		end)

		fn24l()
		fn36l()

		if fn40l() and antiGuardState.Carrying then
			flash(tbl15.Good, 1.6)
		else
			flash(tbl15.Bad, 1.6)
		end
	end

	local function fn40(arg)
		if not pcall(fn39l, arg) then
			pcall(function()
				local character = localPlayer.Character
				character = character and character:FindFirstChildOfClass("Humanoid")

				if character then
					character.PlatformStand = false
				end
			end)

			fn24l()
			fn36l()
			flash(tbl15.Bad, 1.6)
		end
	end

	local n5 = 25

	local function fn41()
		if antiGuard.HitArms <= 0 then
			return false
		end

		if n5 < os.clock() - (antiGuard.HitArmedAt or 0) then
			antiGuard.HitArms = 0
			return false
		end
		return true
	end

	local function fn42()
		local carrying = antiGuardState.Carrying
		antiGuardState.Carrying = antiGuardState.SignalCarrying or antiGuardState.WeldCarrying
		local enabled = antiGuardState.Carrying and not carrying and flag4 and antiGuard.Enabled
		local flag5

		if enabled then
			flag5 = not (tbl4.SafeCarry.LineDrop and tbl4.Steal.Active)
		else
			flag5 = enabled
		end

		if flag5 and not antiGuardState.Active and not fn41() then
			antiGuardState.Active = true
			antiGuard.Busy = true
			antiGuard.BusySince = os.clock()
			task.spawn(fn40, os.clock())
		end
	end

	local eggState = tbl.EggState
	local carryChanged = type(eggState) == "table" and eggState.CarryChanged or nil

	if type(carryChanged) == "table" and type(carryChanged.Connect) == "function" then
		local ok, result = pcall(carryChanged.Connect, carryChanged, function(arg)
			local signalCarrying = type(arg) == "table" and arg.IsCarrying == true

			if signalCarrying and arg.GuardDisabled == true then
				signalCarrying = false
			end

			if signalCarrying and type(arg.AreaId) == "string" then
				antiGuardState.AreaId = arg.AreaId
			end

			if not signalCarrying then
				antiGuardState.AreaId = nil
			end

			antiGuardState.SignalCarrying = signalCarrying
			fn42()
		end)

		if ok and result then
			antiGuardConnections[#antiGuardConnections + 1] = result
		end
	end

	local n6 = 0

	antiGuardConnections[#antiGuardConnections + 1] = RunService.Heartbeat:Connect(function(deltaTime)
		local busy = antiGuard.Busy or antiGuardState.Active
		local flag5

		if busy then
			local busySince = antiGuard.BusySince
			flag5 = os.clock() - busySince > math.max(tonumber(fn32l().BusyLimit) or chilliAntiGuard.LightDark.BusyLimit, (tonumber(fn32l().ReleaseAt) or 0) + 1)
		else
			flag5 = busy
		end

		if flag5 then
			fn24l()
			local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

			if humanoid and humanoid.PlatformStand then
				pcall(function()
					humanoid.PlatformStand = false
				end)
			end

			fn36l()
		end

		fn41()
		n6 += deltaTime
		if n6 < chilliAntiGuard.LightDark.WeldScanGap then
			return
		end
		n6 = 0
		local weldCarrying = fn23l() ~= nil

		if weldCarrying ~= antiGuardState.WeldCarrying then
			antiGuardState.WeldCarrying = weldCarrying
			fn42()
		end
	end)

	-- Cleanup al final
	local function antiGuardCleanup()
		flag4 = false

		for _, v10 in ipairs(antiGuardConnections) do
			pcall(function()
				v10:Disconnect()
			end)
		end

		table.clear(antiGuardConnections)
		fn24l()
		fn36l()
		antiGuard.Render = nil
		antiGuard.ShowPanel = nil

		pcall(function()
			ScreenGui:Destroy()
		end)
	end

	-- Toggle en el UI
	antiGuard.Handle = espSection:CreateToggle({
		Name = "Anti Guard Enabled",
		Default = false,
		Callback = function(arg)
			antiGuard.Enabled = arg == true

			if antiGuard.Render then
				pcall(antiGuard.Render, false)
			end
		end,
	})

	pcall(function()
		if type(antiGuard.Handle.Get) == "function" then
			antiGuard.Enabled = antiGuard.Handle:Get() == true
		end
	end)

	antiGuard.PanelHandle = espSection:CreateToggle({
		Name = "Anti Guard Panel",
		Default = true,
		Callback = function(panelShown)
			if type(panelShown) ~= "boolean" then
				panelShown = tbl4.Toggle(antiGuard.PanelHandle, true)
			end

			antiGuard.PanelShown = panelShown

			if antiGuard.ShowPanel then
				pcall(antiGuard.ShowPanel, panelShown)
			end
		end,
	})

	-- Registrar cleanup global
	genv.PotentAntiGuardCleanup = antiGuardCleanup
end

-- ============================================================
-- FIN DE LA PARTE 4
-- ============================================================
-- ============================================================
-- PARTE 5: Crear Window + Tab + espSection
-- Va ENTRE Parte 1 y Parte 2
-- ============================================================

potentWindow = nil
espTab = nil
espSection = nil

do
	local WindUI = getWindUILibrary()
	potentWindow = createPotentWindow(WindUI, "POTENTHUB_ESP", "ESP & Anti Guard")
	espTab = potentWindow:Tab({ Title = "👁️ ESP", Icon = "eye" })
	espSection = espTab:CreateSection({ Name = "ESP", Expanded = true })

	genv.PotentESPWindow = potentWindow
	genv.PotentESPWindUI = WindUI

	task.spawn(function()
		task.wait(1.5)
		pcall(function()
			WindUI:Notify({
				Title = "⚡ POTENT HUB",
				Content = "✅ ESP + Anti Guard cargados",
				Duration = 4,
			})
		end)
	end)
end

-- ============================================================
-- FIN DE LA PARTE 5
-- ============================================================
