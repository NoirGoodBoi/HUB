-- [[ NHẬT HUB - ANIMATIONS & EMOTES TEST ]]
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/NoirGoodBoi/Awesome-UI-Libraries/refs/heads/main/VenyxUI/source.lua"))()
local Venyx = Library.new("NHẬT HUB - TEST", "Gothic Edition")

local CoreGui = game:GetService("CoreGui")
local sg = Instance.new("ScreenGui", CoreGui); sg.Name = "NhatHub_Test"
local tBtn = Instance.new("ImageButton", sg); tBtn.Size = UDim2.new(0, 55, 0, 55); tBtn.Position = UDim2.new(0, 15, 0, 15)
tBtn.BackgroundColor3 = Color3.new(0,0,0); tBtn.Image = "rbxassetid://14260707709"; Instance.new("UICorner", tBtn)

tBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v:FindFirstChild("Main") then v.Enabled = not v.Enabled end
    end
end)

-- TABS
local animTab = Venyx:addPage("Animations", 10734975486)
local emoteTab = Venyx:addPage("Emotes", 10734905958)

-- ===================================================================
-- [[ ANIMATIONS - BỘ ĐIỆU BỘ ]]
-- ===================================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local PACKS = {
	["Adidas Sports"] = {
		WalkAnim = 18537392113, RunAnim = 18537384940, JumpAnim = 18537380791,
		FallAnim = 18537367238, SwimIdle = 18537387180, Swim = 18537389531,
		Animation1 = 18537376492, Animation2 = 18537371272, ClimbAnim = 18537363391,
	},
	["Adidas Community"] = {
		WalkAnim = 122150855457006, RunAnim = 82598234841035, JumpAnim = 75290611992385,
		FallAnim = 98600215928904, SwimIdle = 109346520324160, Swim = 133308483266208,
		Animation1 = 122257458498464, Animation2 = 102357151005774, ClimbAnim = 88763136693023,
	},
	["Adidas Aura"] = {
		WalkAnim = 83842218823011, RunAnim = 118320322718866, JumpAnim = 109996626521204,
		FallAnim = 95603166884636, SwimIdle = 94922130551805, Swim = 134530128383903,
		Animation1 = 110211186840347, Animation2 = 114191137265065, ClimbAnim = 97824616490448,
	},
	["Wicked Popular"] = {
		WalkAnim = 92072849924640, RunAnim = 72301599441680, JumpAnim = 104325245285198,
		FallAnim = 121152442762481, Animation1 = 118832222982049, ClimbAnim = 131326830509784,
		SwimIdle = 113199415118199, Swim = 99384245425157, Animation2 = 76049494037641,
	},
	Elder = {
		WalkAnim = 10921111375, RunAnim = 10921104374, JumpAnim = 10921107367,
		FallAnim = 10921105765, SwimIdle = 10921110146, Swim = 10921108971,
		ClimbAnim = 10921100400, Animation1 = 10921101664, Animation2 = 10921102574,
	},
	Zombie = {
		WalkAnim = 10921355261, RunAnim = 616163682, JumpAnim = 10921351278,
		FallAnim = 10921350320, SwimIdle = 10921353442, Swim = 10921352344,
		Animation1 = 10921344533, Animation2 = 10921345304, ClimbAnim = 10921343576,
	},
	Mage = {
		WalkAnim = 10921152678, RunAnim = 10921148209, JumpAnim = 10921149743,
		FallAnim = 10921148939, SwimIdle = 10921151661, Swim = 10921150788,
		ClimbAnim = 10921143404, Animation1 = 10921144709, Animation2 = 10921145797,
	},
	["Catwalk Glam"] = {
		WalkAnim = 109168724482748, RunAnim = 81024476153754, JumpAnim = 116936326516985,
		FallAnim = 92294537340807, SwimIdle = 98854111361360, Swim = 134591743181628,
		ClimbAnim = 119377220967554, Animation1 = 133806214992291, Animation2 = 94970088341563,
	},
	Astronaut = {
		WalkAnim = 10921046031, RunAnim = 10921039308, JumpAnim = 10921042494,
		FallAnim = 10921040576, SwimIdle = 10921045006, Swim = 10921044000,
		ClimbAnim = 10921032124, Animation1 = 10921034824, Animation2 = 10921036806,
	},
	['Wicked "Dancing Through Life"'] = {
		WalkAnim = 73718308412641, RunAnim = 135515454877967, JumpAnim = 78508480717326,
		FallAnim = 78147885297412, SwimIdle = 129183123083281, Swim = 110657013921774,
		ClimbAnim = 129447497744818, Animation1 = 92849173543269, Animation2 = 132238900951109,
	},
	Werewolf = {
		WalkAnim = 10921342074, RunAnim = 10921336997, JumpAnim = nil,
		FallAnim = 10921337907, SwimIdle = 10921341319, Swim = 10921340419,
		ClimbAnim = 10921329322, Animation1 = 10921330408, Animation2 = 10921333667,
	},
	Superhero = {
		WalkAnim = 10921298616, RunAnim = 10921291831, JumpAnim = 10921294559,
		FallAnim = 10921293373, SwimIdle = 10921297391, Swim = 10921295495,
		ClimbAnim = 10921286911, Animation1 = 10921288909, Animation2 = 10921290167,
	},
	Toy = {
		WalkAnim = 10921312010, RunAnim = 10921306285, JumpAnim = 10921308158,
		FallAnim = 10921307241, SwimIdle = 10921310341, Swim = 10921309319,
		ClimbAnim = 10921300839, Animation1 = 10921301576, Animation2 = nil,
	},
	["No Boundaries"] = {
		WalkAnim = 18747074203, RunAnim = 18747070484, JumpAnim = 18747069148,
		FallAnim = 18747062535, SwimIdle = 18747071682, Swim = 18747073181,
		ClimbAnim = 18747060903, Animation1 = 18747067405, Animation2 = 18747063918,
	},
	NFL = {
		WalkAnim = 110358958299415, RunAnim = 117333533048078, JumpAnim = 119846112151352,
		FallAnim = 129773241321032, SwimIdle = 79090109939093, Swim = 132697394189921,
		ClimbAnim = 134630013742019, Animation1 = 92080889861410, Animation2 = 74451233229259,
	},
	["Amazon Unboxed"] = {
		WalkAnim = 90478085024465, RunAnim = 134824450619865, JumpAnim = 121454505477205,
		FallAnim = 94788218468396, SwimIdle = 129126268464847, Swim = 105962919001086,
		ClimbAnim = 121145883950231, Animation1 = 98281136301627, Animation2 = nil,
	},
	Vampire = {
		WalkAnim = 10921326949, RunAnim = 10921320299, JumpAnim = 10921322186,
		FallAnim = 10921321317, SwimIdle = 10921325443, Swim = 10921324408,
		ClimbAnim = 10921314188, Animation1 = 10921315373, Animation2 = nil,
	},
	Ninja = { Run = 656118852, Walk = 656121766, Jump = 656117878, Fall = 656115606,
		Swim = 656119721, SwimIdle = 656121397, Climb = 656114359,
		Idle = {656117400, 656118341, 886742569} },
	Robot = { Run = 616091570, Walk = 616095330, Jump = 616090535, Fall = 616087089,
		Swim = 616092998, SwimIdle = 616094091, Climb = 616086039,
		Idle = {616088211, 616089559, 885531463} },
	Levitation = { Run = 616010382, Walk = 616013216, Jump = 616008936, Fall = 616005863,
		Swim = 616011509, SwimIdle = 616012453, Climb = 616003713,
		Idle = {616006778, 616008087, 886862142} },
	Stylish = { Run = 616140816, Walk = 616146177, Jump = 616139451, Fall = 616134815,
		Swim = 616143378, SwimIdle = 616144772, Climb = 616133594,
		Idle = {616136790, 616138447, 886888594} },
	Bubbly = { Run = 910025107, Walk = 910034870, Jump = 910016857, Fall = 910001910,
		Swim = 910028158, SwimIdle = 910030921, Climb = 909997997,
		Idle = {910004836, 910009958, 1018536639} },
	Cartoon = { Run = 742638842, Walk = 742640026, Jump = 742637942, Fall = 742637151,
		Swim = 742639220, SwimIdle = 742639812, Climb = 742636889,
		Idle = {742637544, 742638445, 885477856} },
}

local ATTR_LAST = "AnimPack_Last"
local applying = false

local function waitForAnimate(char)
	for _ = 1, 40 do
		local a = char:FindFirstChild("Animate")
		if a and a:FindFirstChild("idle") and a:FindFirstChild("run") and a:FindFirstChild("walk") then
			return a
		end
		task.wait(0.1)
	end
	return nil
end

local function setAnim(animObj, id)
	if animObj and id then
		animObj.AnimationId = "rbxassetid://" .. tostring(id)
	end
end

local function stopAllTracks(hum)
	if not hum then return end
	for _, t in ipairs(hum:GetPlayingAnimationTracks()) do
		pcall(function() t:Stop(0) end)
	end
end

local function ensureAnim(folder, name)
	if not folder then return nil end
	local a = folder:FindFirstChild(name)
	if not a then
		a = Instance.new("Animation")
		a.Name = name
		a.Parent = folder
	end
	return a
end

local function ensureIdleSlots(idleFolder, n)
	if not idleFolder then return end
	n = n or 2
	for i = 1, n do
		ensureAnim(idleFolder, "Animation" .. i)
	end
end

local function pick(pack, ...)
	for i = 1, select("#", ...) do
		local k = select(i, ...)
		local v = pack[k]
		if v ~= nil then return v end
	end
	return nil
end

local function applyPack(packName)
	if applying then return false end
	applying = true
	
	pcall(function()
		local pack = PACKS[packName]
		if not pack then return end
		
		local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local animate = waitForAnimate(char)
		if not animate then return end
		
		local hum = char:FindFirstChildOfClass("Humanoid")
		stopAllTracks(hum)
		
		local runObj = ensureAnim(animate:FindFirstChild("run"), "RunAnim")
		local walkObj = ensureAnim(animate:FindFirstChild("walk"), "WalkAnim")
		local jumpObj = ensureAnim(animate:FindFirstChild("jump"), "JumpAnim")
		local fallObj = ensureAnim(animate:FindFirstChild("fall"), "FallAnim")
		local climbObj = ensureAnim(animate:FindFirstChild("climb"), "ClimbAnim")
		local swimObj = ensureAnim(animate:FindFirstChild("swim"), "Swim")
		local swimIdleObj = ensureAnim(animate:FindFirstChild("swimidle"), "SwimIdle")
		local idleFolder = animate:FindFirstChild("idle")
		
		setAnim(walkObj, pick(pack, "WalkAnim", "Walk"))
		setAnim(runObj, pick(pack, "RunAnim", "Run"))
		setAnim(jumpObj, pick(pack, "JumpAnim", "Jump"))
		setAnim(fallObj, pick(pack, "FallAnim", "Fall"))
		setAnim(climbObj, pick(pack, "ClimbAnim", "Climb"))
		setAnim(swimObj, pick(pack, "Swim"))
		setAnim(swimIdleObj, pick(pack, "SwimIdle") or pick(pack, "Swim"))
		
		if idleFolder then
			local a1 = pick(pack, "Animation1")
			local a2 = pick(pack, "Animation2")
			if a1 or a2 then
				ensureIdleSlots(idleFolder, 2)
				local id1 = a1 or a2
				local id2 = a2 or a1 or id1
				setAnim(idleFolder:FindFirstChild("Animation1"), id1)
				setAnim(idleFolder:FindFirstChild("Animation2"), id2)
			elseif pack.Idle and #pack.Idle > 0 then
				ensureIdleSlots(idleFolder, math.max(2, #pack.Idle))
				setAnim(idleFolder:FindFirstChild("Animation1"), pack.Idle[1])
				setAnim(idleFolder:FindFirstChild("Animation2"), pack.Idle[2] or pack.Idle[1])
				for i = 3, #pack.Idle do
					local a = idleFolder:FindFirstChild("Animation" .. i)
					if a then setAnim(a, pack.Idle[i]) end
				end
			end
		end
		
		animate.Disabled = true
		task.wait(0.06)
		animate.Disabled = false
		
		if hum then
			pcall(function()
				hum:ChangeState(Enum.HumanoidStateType.Landed)
				task.wait(0.03)
				hum:ChangeState(Enum.HumanoidStateType.Running)
			end)
		end
		
		pcall(function() LocalPlayer:SetAttribute(ATTR_LAST, packName) end)
	end)
	
	applying = false
	return true
end

LocalPlayer.CharacterAdded:Connect(function()
	task.wait(0.6)
	local saved = LocalPlayer:GetAttribute(ATTR_LAST)
	if type(saved) == "string" and saved ~= "" and PACKS[saved] then
		applyPack(saved)
	end
end)

local animSec = animTab:addSection("Animation Packs")

local allPackNames = {}
for name in pairs(PACKS) do table.insert(allPackNames, name) end
table.sort(allPackNames)

for _, packName in ipairs(allPackNames) do
	animSec:addButton(packName, function() 
		applyPack(packName)
	end)
end

-- ===================================================================
-- [[ EMOTES - CỬ CHỈ ]]
-- ===================================================================
local Emotes = {}

local emoteList = {
	"Around Town|3576747102",
	"TWICE TAKEDOWN DANCE 2|85623000473425",
	"Fashionable|3576745472",
	"Swish|3821527813",
	"Top Rock|3570535774",
	"Fancy Feet|3934988903",
	"Idol|4102317848",
	"Sneaky|3576754235",
	"Elton John - Piano Jump|11453096488",
	"Cartwheel - George Ezra|10370929905",
	"Super Charge|10478368365",
	"Rise Above - The Chainsmokers|13071993910",
	"Elton John - Elevate|11394056822",
	"Sturdy Dance - Ice Spice|17746270218",
	"YUNGBLUD � HIGH KICK|14022978026",
	"Robot|3576721660",
	"Louder|3576751796",
	"Twirl|3716633898",
	"Bodybuilder|3994130516",
	"NBA Monster Dunk|117511481049460",
	"Jacks|3570649048",
	"Shuffle|4391208058",
	"Elton John - Still Standing|11435177473",
	"Elton John - Cat Man|11435175895",
	"Shrek Roar|18524331128",
	"Dorky Dance|4212499637",
	"HOLIDAY Dance - Lil Nas X|5938396308",
	"Old Town Road Dance - Lil Nas X|5938394742",
	"Panini Dance - Lil Nas X|5915781665",
	"Rodeo Dance - Lil Nas X|5938397555",
	"Drum Master - Royal Blood|6531538868",
	"It Ain't My Fault - Zara Larsson|6797948622",
	"Flex Walk|15506506103",
	"Dizzy|3934986896",
	"Uprise - Tommy Hilfiger|10275057230",
	"Tommy - Archer|13823339506",
	"Mean Mug - Tommy Hilfiger|10214415687",
	"Rock Star - Royal Blood|6533100850",
	"Floor Rock Freeze - Tommy Hilfiger|10214411646",
	"Saturday Dance - Twenty One Pilots|7422833723",
	"V Pose - Tommy Hilfiger|10214418283",
	"Boxing Punch - KSI|7202896732",
	"Drum Solo - Royal Blood|6532844183",
	"Frosty Flair - Tommy Hilfiger|10214406616",
	"Hips Poppin' - Zara Larsson|6797919579",
	"Drummer Moves - Twenty One Pilots|7422838770",
	"On The Outside - Twenty One Pilots|7422841700",
	"Thanos Happy Jump - Squid Game|82217023310738",
	"Block Partier|6865011755",
	"Up and Down - Twenty One Pilots|7422843994",
	"Ay-Yo Dance Move - NCT 127|12804173616",
	"Young-hee Head Spin - Squid Game|134615135651900",
	"T|3576719440",
	"Air Dance|4646302011",
	"TMNT Dance|18665886405",
	"Take Me Under - Zara Larsson|6797938823",
	"Sticker Dance Move - NCT 127|12259885838",
	"Line Dance|4049646104",
	"NBA WNBA Fadeaway|18526373545",
	"SpongeBob Imaginaaation|18443268949",
	"Chill Vibes - George Ezra|10370918044",
	"Wake Up Call - KSI|7202900159",
	"Kick It Dance Move - NCT 127|12259888240",
	"The Weeknd Starboy Strut|130245358716273",
	"2 Baddies Dance Move - NCT 127|12259890638",
	"Rock Guitar - Royal Blood|6532155086",
	"Show Dem Wrists - KSI|7202898984",
	"Dancin' Shoes - Twenty One Pilots|7405123844",
	"Arm Twist|9710992846",
	"AOK - Tai Verdes|7942960760",
	"M3GAN's Dance|127271798262177",
	"High Hands|9710994651",
	"Cobra Arms - Tai Verdes|7942964447",
	"Lasso Turn - Tai Verdes|7942972744",
	"Beauty Touchdown|16303091119",
	"Sidekicks - George Ezra|10370922566",
	"Boom Boom Clap - George Ezra|10370934040",
	"DearALICE - Ariana|133765015173412",
	"Chappell Roan HOT TO GO!|79312439851071",
	"Bone Chillin' Bop|15123050663",
	"Power Blast|4849497510",
	"Flowing Breeze|7466047578",
	"Swan Dance|7466048475",
	"Quiet Waves|7466046574",
	"Rolling Stones Guitar Strum|18148839527",
	"Break Dance|5915773992",
	"KATSEYE - Touch|139021427684680",
	"Zombie|4212496830",
	"Olivia Rodrigo Head Bop|15554010118",
	"Rasputin � Boney M.|133477296392756",
	"Tommy K-Pop Mic Drop|14024722653",
	"TWICE Feel Special|14900153406",
	"Olivia Rodrigo good 4 u|15554013003",
	"Olivia Rodrigo Fall Back to Float|15554016057",
	"Air Guitar|15506499986",
	"Fashion Klossette - Runway my way|126683684984862",
	"Elton John - Heart Skip|11309263077",
	"Baby Dance|4272484885",
	"Cha Cha|6865013133",
	"Dolphin Dance|5938365243",
	"Elton John - Rock Out|11753545334",
	"ALT�GO - Couldn�t Care Less|92859581691366",
	"Fashion Roadkill|73683655527605",
	"Paris Hilton Sanasa|16126526506",
	"TWICE I GOT YOU part 1|16215060261",
	"The Zabb|71389516735424",
	"Y|4391211308",
	"Wanna play?|16646438742",
	"TWICE I GOT YOU part 2|16256253954",
	"Nicki Minaj Starships|15571540519",
	"Mean Girls Dance Break|15963348695",
	"TWICE Takedown|94796833553521",
	"Samba|6869813008",
	"Rock Out - Bebe Rexha|18225077553",
	"TWICE LIKEY|14900151704",
	"Sol de Janeiro - Samba|16276506814",
	"The Weeknd Opening Night|105098895743105",
	"Paris Hilton - Sliving For The Groove|15392927897",
	"Paris Hilton - Checking My Angles|15392937495",
	"Nicki Minaj Boom Boom Boom|15571538346",
	"Stray Kids Walkin On Water|100773414188482",
	"Team USA Breaking Emote|18526338976",
	"Side to Side|3762641826",
	"Skibidi Toilet - Titan Speakerman Laser Spin|103102322875221",
	"Paris Hilton - Iconic IT-Grrrl|15392932768",
	"Dave's Spin Move - Glass Animals|16276501655",
	"HUGO Let's Drive!|17360720445",
	"Fast Hands|4272351660",
	"Tree|4049634387",
	"Godlike|3823158750",
	"Keeping Time|4646306072",
	"Elton John - Heart Shuffle|17748346932",
	"Tantrum|5104374556",
	"Rock On|5915782672",
	"Hero Landing|5104377791",
	"Fishing|3994129128",
	"Floss Dance|5917570207",
	"Get Out|3934984583",
	"Victory Dance|15506503658",
	"d4vd - Backflip|15694504637",
	"GloRilla - Tomorrow Dance|15689315657",
	"Monkey|3716636630",
	"Imagine Dragons - Bones Dance|15689314578",
	"Greatest|3762654854",
	"Jawny - Stomp|16392120020",
	"Jumping Wave|4940602656",
	"HIPMOTION - Amaarae|16572756230",
	"Haha|4102315500",
	"Agree|4849487550",
	"Mae Stephens - Piano Hands|16553249658",
	"Mini Kong|17000058939",
	"Mae Stephens � Arm Wave|16584496781",
	"Festive Dance|15679955281",
	"Jumping Cheer|5895009708",
	"Sleep|4689362868",
	"ericdoa - dance|15698510244",
	"Disagree|4849495710",
	"Happy|4849499887",
	"Bored|5230661597",
	"High Wave|5915776835",
	"Alo Yoga Pose - Warrior II|12507106431",
	"Cower|4940597758",
	"Wisp - air guitar|17370797454",
	"Alo Yoga Pose - Triangle|12507120275",
	"Cuco - Levitate|15698511500",
	"Rock n Roll|15506496093",
	"Shy|3576717965",
	"Alo Yoga Pose - Lotus Position|12507097350",
	"Curtsy|4646306583",
	"Celebrate|3994127840",
	"Yungblud Happier Jump|15610015346",
	"Baby Queen - Face Frame|14353421343",
	"Confused|4940592718",
	"Beckon|5230615437",
	"Secret Handshake Dance|120642514156293",
	"Baby Queen - Air Guitar & Knee Slide|14353417553",
	"Baby Queen - Bouncy Twirl|14353423348",
	"Baby Queen - Strut|14353425085",
	"Baby Queen - Dramatic Bow|14353419229",
	"Sad|4849502101",
	"Robot M3GAN|90569436057900",
	"Nicki Minaj Anaconda|15571539403",
	"Cha-Cha|3696764866",
	"BURBERRY LOLA ATTITUDE - BLOOM|10147919199",
	"Skadoosh Emote - Kung Fu Panda 4|16371235025",
	"Chicken Dance|4849493309",
	"BLACKPINK Don't know what to do|18855609889",
	"Man City Scorpion Kick|13694139364",
	"Gashina - SUNMI|9528294735",
	"Fashion Spin|130046968468383",
	"Country Line Dance - Lil Nas X|5915780563",
	"Sandwich Dance|4390121879",
	"BLACKPINK LISA Money|15679957363",
	"Nicki Minaj That's That Super Bass|15571536896",
	"Salute|3360689775",
	"Olympic Dismount|18666650035",
	"MANIAC - Stray Kids|11309309359",
	"BLACKPINK JISOO Flower|15439454888",
	"Man City Bicycle Kick|13422286833",
	"Man City Backflip|13694140956",
	"BLACKPINK Pink Venom - Straight to Ya Dome|14548711723",
	"BLACKPINK Pink Venom - I Bring the Pain|14548710952",
	"Stadium|3360686498",
	"BLACKPINK ROS� On The Ground|15679958535",
	"Bunny Hop|4646296016",
	"BLACKPINK Shut Down - Part 1|14901369589",
	"BLACKPINK Kill This Love|16181843366",
	"SpongeBob Dance|18443271885",
	"Borock's Rage|3236848555",
	"The Conductor - George Ezra|10370926562",
	"Swag Walk|10478377385",
	"BLACKPINK Shut Down - Part 2|14901371589",
	"BLACKPINK Ice Cream|16181840356",
	"Superhero Reveal|3696759798",
	"BLACKPINK Pink Venom - Get em Get em|14548709888",
	"NBA Monster Dunk|82163305721376",
	"TWICE ABCD by Nayeon|18933761755",
	"BURBERRY LOLA ATTITUDE - NIMBUS|10147924028",
	"Ud'zal's Summoning|3307604888",
	"TWICE Pop by Nayeon|13768975574",
	"TWICE Set Me Free - Dance 1|12715395038",
	"TWICE Set Me Free - Dance 2|12715397488",
	"Hyperfast 5G Dance Move|9408642191",
	"You can't sit with us - Sunmi|9983549160",
	"Hype Dance|3696757129",
	"BLACKPINK - How You Like That|16874596971",
	"BLACKPINK - Lovesick Girls|16874600526",
	"TWICE Like Ooh-Ahh|14124050904",
	"Heisman Pose|3696763549",
	"BLACKPINK As If It's Your Last|18855603653",
	"TWICE Moonlight Sunrise|12715393154",
	"TWICE Fancy|13520623514",
	"Point2|3576823880",
	"BURBERRY LOLA ATTITUDE - GEM|10147916560",
	"Vroom Vroom|18526410572",
	"Hwaiting|9528291779",
	"BLACKPINK JENNIE You and Me|15439457146",
	"Tilt|3360692915",
	"Applaud|5915779043",
	"BLACKPINK DDU-DU DDU-DU|16553262614",
	"BURBERRY LOLA ATTITUDE - HYDRO|10147926081",
	"BURBERRY LOLA ATTITUDE - REFLEX|10147921916",
	"Air Guitar|3696761354",
	"Annyeong|9528286240",
	"BLACKPINK Boombayah|16553259683",
	"Victory - 24kGoldn|9178397781",
	"Hello|3576686446",
	"Vans Ollie|18305539673",
	"TWICE Strategy|106862678450011",
	"TWICE The Feels|12874468267",
	"TWICE What Is Love|13344121112",
	"Shrug|3576968026",
	"PARROT PARTY DANCE|121067808279598",
	"Dance n' Prance|99031916674986",
	"R15 Death (Accurate)|114899970878842",
	"Wally West|133948663586698",
	"Take The L|123159156696507",
	"Xaviersobased|131763631172236",
	"Belly Dancing|131939729732240",
	"RAT DANCE|133461102795137",
	"CaramellDansen|93105950995997",
	"Biblically Accurate|133596366979822",
	"Rambunctious|134311528115559",
	"Ballin|96293409369770",
	"Die Lit|121001502815813",
	"Nyan Nyan!|73796726960568",
	"Teto Territory|114428584463004",
	"Skibidi|124828909173982",
	"Chronoshift|92600655160976",
	"Floating on Clouds|111426928948833",
	"Jersey Joe|134149640725489",
	"Virtual Insanity|83261816934732",
	"Doodle Dance|107091254142209",
	"Subject 3|83732367439808",
	"Club Penguin|98099211500155",
	"Kazotsky|97629500912487",
	"Miku Dance|117734400993750",
	"Deltarune - Tenna Swing|103139492736941",
	"Hakari Dance|80270168146449",
	"Addendum Dance [R6]|134442882516163",
	"Gangnam Style|77205409178702",
	"Push-Up|117922227854118",
	"Split|98522218962476",
	"PROXIMA|81390693780805",
	"HeadBanging|87447252507832",
	"Assumptions|127507691649322",
	"Jumpstyle|99563839802389",
	"Flopping Fish|133142324349281",
	"Kicking Feet Sit|78758922757947",
	"Fancy Feets|124512151372711",
	"Cute Sit|90244178386698",
	"Absolute Cinema|97258018304125",
	"Bubbly Sit|112758073578333",
	"Become A Car|131544122623505",
	"Hiding Human Box|124935873390035",
	"Magical Pose|135489824748823",
	"Griddy|116065653184749",
	"Gon Rage|139639173024927",
	"Become Couch|93335594132613",
	"Spare Change|126749574427431",
	"Paranoid|123407922818447",
	"Kawaii Groove|77152953688098",
	"Ai Cat dance|136593170936320",
	"Smeeze|131683926643291",
	"Onion|113890289455724",
	"Thinking|124584711308900",
	"Little Obbyist|134584040095037",
	"Aura Fly|78755795767408",
	"Invisible|109899950448992",
	"Slenderman|81926508907412",
	"Chill pose|77058107325712",
	"house|93552301087938",
	"baby|82824758023484",
	"zenitsu|92750276568993",
	"gun|73562814360939",
	"Spy Laugh tf2|137720205462499",
	"Head Juggling|82224981519682",
	"Omniman Think|70560694892323",
	"Ishowspeed Shake Dancing|138386881919239",
	"Wait|106569806588657",
	"Shinji Pose|97629500912487",
	"Come At Me [R6]|107758370940834",
	"Oscillating Fan|71493999860590",
	"Locked In|110145155419199",
	"BirdBrain|105730788757021",
	"Hakari (FULL)|71056659089869",
	"How A Creeper Walk|108714986908463",
	"Hakari (R6)|127103118569243",
	"Strongest Stance|80146495484274",
	"Cat Things|131193808160056",
	"Doggy Things|105206768873249",
	"Wally West Edit|72247161810866",
	"24 Hour Cinderella|122972776209997",
	"Mesmerizer|92707348383277",
	"Stylish Float|97497383284399",
	"SpongeBob Shuffle|107899954696611",
	"Electro Shuffle|96426537876059",
	"Foreign Shuffle|101507732056031",
	"Caipirinha|100165303717371",
	"Squidward Yell|109244554368414",
	"Hakari (Forsaken)|73271793399763",
	"Teto Dance|93031502567721",
	"Michael Myers|88229016850146",
	"Gun Shoot|105055412595333",
	"Torture Dance|116099356619436",
	"Yapping Yap Yap Gesture|119870339321091",
	"Luxurious / Springtrap|132151459316300",
	"Hand Drill|103882178542598",
	"exclamation|82714556886471",
	"Mewing / Mogging|135493514352956",
	"lemon melon cookie - Miku|79874689836683",
	"Cute Jump|80556794144838",
	"Billy Bounce|126516908191316",
	"What U Want / Prince Egypt|133751526608969",
	"Rabbit Hole - Miku|133481721436918",
	"Garou|86200585395371",
	"Dio Pose|76736978166708",
	"Golden Freddy|122463450997235",
	"Noclip, Speed|137006085779408",
	"Static [Hatsune Miku]|84534006084837",
	"GOALL|78830825254717",
	"Lethal Dance|77108921633993",
	"Plug Walk|100359724990859",
	"At Ease|76993139936388",
	"Conga|97547955535086",
	"Barrel|84511772437190",
	"Helicopter|84555218084038",
	"Aura Farm Boat|88042995626011",
	"Prince Of Egypt|134063402217274",
	"Jersey Joe2|115782117564871",
	"Deltarune - Tenna Dance|73715378215546",
	"California Girl|132074413582912",
	"Default Dance|80877772569772",
	"Shocked meme|129501229484294",
	"Family Guy|78459263478161",
	"Car Transformation|96887377943085",
	"Insanity|129843344424281",
	"Honored One|121643381580730",
	"Sukuna|91839607010745",
	"Dropper|130358790702800",
	"Be Not Afraid|70635223083942",
	"Macarena|91274761264433",
	"Helicopter2|119431985170060",
	"RONALDO|97547486465713",
	"Nya Anime Dance|126647057611522",
	"Do that thang|113772829398170",
	"Squat?|95441477641149",
	"Slickback|103789826265487",
}

for _, v in ipairs(emoteList) do
	local parts = {}
	for part in string.gmatch(v, "([^|]+)") do
		table.insert(parts, part)
	end
	if #parts == 2 then
		table.insert(Emotes, {name = parts[1], id = tonumber(parts[2])})
	end
end

local function PlayEmote(id)
	local char = LocalPlayer.Character
	if not char then return end
	local Humanoid = char:FindFirstChildOfClass("Humanoid")
	if not Humanoid then return end
	
	if char.Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
		pcall(function()
			Humanoid:PlayEmoteAndGetAnimTrackById(id)
		end)
	end
end

local emoteSec = emoteTab:addSection("Emotes")

for _, emote in ipairs(Emotes) do
	emoteSec:addButton(emote.name, function()
		PlayEmote(emote.id)
	end)
end

-- Select default tab
Venyx:SelectPage(animTab, true)
