
local box = CompactUnitFrameProfilesGeneralOptionsFrameKeepGroupsTogether
local mode = CompactRaidFrameContainer_SetGroupMode

local function checkBox()
	-- in separate party groups, doesn't allow raid frames to glom together or sort
	box:SetChecked(true)
	mode(CompactRaidFrameContainer, "discrete")
end

local function uncheckBox()
	-- not in separate party groups, allows raid frames to glom together and sort
	box:SetChecked(false)
	mode(CompactRaidFrameContainer, "flush")
end

local function toggleBox()
	-- same as clicking the checkbox in the foreground UI, toggles to opposing state
	box:Click()
end

local function slashHandler(msg)
	local cmd, opt = strsplit(" ", msg)

	if cmd == "fix" then -- toggle twice to fix tainted raid frames
		toggleBox()
		toggleBox()
		if opt == "verbose" then print("ftrf: toggled raid frames twice to fix tainted frames") end
	elseif cmd == "toggle" then -- toggle once to opposing state of groupmode
		toggleBox()
		local checked = box:GetChecked()
		if opt == "verbose" then
			if checked then
				print("ftrf: toggled, now showing party groups")
			else
				print("ftrf: toggled, now without party groups")
			end
		end
	elseif cmd == "check" then -- force to checked state regardless of starting state
		checkBox()
		if opt == "verbose" then print("ftrf: showing raid frames in party groups") end
	elseif cmd == "uncheck" then -- force to unchecked state regardless of starting state
		uncheckBox()
		if opt == "verbose" then print("ftrf: showing raid frames without party groups") end
	else -- just show usage text
		print("FixTaintedRaidFrames usage")
		print("Works on Interface>Raid Profiles>Keep Groups Together")
		print("------------------------------------------------------")
		print("/ftrf fix - toggles K.G.T. twice to fix tainted frames")
		print("/ftrf toggle - toggles K.G.T. once to opposing state")
		print("/ftrf check - K.G.T. checked")
		print("/ftrf uncheck - K.G.T. unchecked")
		print("------------------------------------------------------")
		print("Include second argument \"verbose\" to get confirmation")
		print("/ftrf fix verbose - example with confirmation message")
		
	end
end

SLASH_FTRF1 = "/FixTaintedRaidFrames"
SLASH_FTRF2 = "/ftrf"
SlashCmdList["FTRF"] = slashHandler
