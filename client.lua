addEventHandler(
	'onClientResourceStart',
	resourceRoot,
	function()
		sx, sy = guiGetScreenSize()
		loadstring(exports.es_dgs:dgsImportFunction())()
		chopsic = dgsCreateFont('assets/chopsic.ttf', 18)
		speedphreak = dgsCreateFont('assets/speedphreak.ttf', 9, true)
		excluded = dgsCreateFont('assets/excluded.ttf', 9, true)
		corona = dgsCreateFont('assets/corona.ttf', 9, true)
		if not getElementData(localPlayer, 'loggedIn') then
			showPanel()
			showCursor(true)
		end
	end
)

function showPanel()
	if config.music then
		music = playSound('assets/music.mp3', true)
	end
	if config.background == 'dynamic' then
		gif = dgsCreateMediaBrowser(sx, sy)
		dgsMediaLoadMedia(gif, 'assets/background.gif', 'IMAGE')
		background = dgsCreateImage(0, 0, sx, sy, gif, false)
	elseif config.background == 'static' then
		background = dgsCreateImage(0, 0, sx, sy, 'assets/background.png', false)
	end
	dgsSetLayer(background, 'bottom')
	dgsSetAlpha(background, 0)
	dgsSetPostGUI(background, false)
	dgsAlphaTo(background, 1, false, 'InBounce', 3000)
	setTimer(showLogin, 2000, 1)
end

function showLogin()
	if register then
		destroyRegister()
	end
	local roundRect = dgsCreateRoundRect(20, false, tocolor(90, 0, 0, 160))
	local lsx, lsy = 0.26, 0.36
	local lpx, lpy = 0.5 - (lsx / 2), 0.5 - (lsy / 2)
	lsy = lsy + 0.1
	login = dgsCreateImage(lpx, lpy, lsx, lsy, roundRect, true)
	dgsSetAlpha(login, 0)
	addEventHandler('onDgsMouseClickDown', login, onClick)

	local lsx, lsy = 0, 0
	local lpx, lpy = 0.5, 0.35
	lsy = lsy + 0.1
	title = dgsCreateLabel(lpx, lpy, lsx, lsy, config.title, true, background)
	dgsSetFont(title, chopsic)
	dgsLabelSetHorizontalAlign(title, 'center')
	dgsLabelSetVerticalAlign(title, 'center')
	dgsSetLayer(title, 'top', true)
	dgsSetAlpha(title, 0)

	local lsx, lsy = 0.8, 0.1
	local lpx, lpy = 0.5 - (lsx / 2), 0.28 - (lsy / 2)
	lpy = lpy + 0.1
	usernameEdit = dgsCreateEdit(lpx, lpy, lsx, lsy, '', true, login)
	dgsSetProperty(usernameEdit, 'placeHolderFont', speedphreak)
	dgsSetProperty(usernameEdit, 'placeHolderColor', tocolor(65, 0, 0, 185))
	dgsSetFont(usernameEdit, speedphreak)
	dgsEditSetPlaceHolder(usernameEdit, 'Username')

	local lsx, lsy = 0.8, 0.1
	local lpx, lpy = 0.5 - (lsx / 2), 0.28 - (lsy / 2)
	lpy = lpy + 0.28
	passwordEdit = dgsCreateEdit(lpx, lpy, lsx, lsy, '', true, login)
	dgsSetProperty(passwordEdit, 'placeHolderFont', speedphreak)
	dgsSetProperty(passwordEdit, 'placeHolderColor', tocolor(65, 0, 0, 185))
	dgsEditSetMasked(passwordEdit, true)
	dgsEditSetPlaceHolder(passwordEdit, 'Password')

	local lsx, lsy = 0.8, 0.1
	local lpx, lpy = 0.52 - (lsx / 2), 0.68 - (lsy / 2)
	rememberBox = dgsCreateCheckBox(lpx, lpy, lsx, lsy, 'Remember', false, true, login)
	dgsSetFont(rememberBox, corona)

	local lsx, lsy = 0.38, 0.16
	local lpx, lpy = 0.5 - (lsx / 2), 0.82 - (lsy / 2)
	lpx = lpx - 0.2
	loginButton = dgsCreateButton(lpx, lpy, lsx, lsy, 'Login', true, login)
	dgsSetFont(loginButton, excluded)

	local lsx, lsy = 0.38, 0.16
	local lpx, lpy = 0.5 - (lsx / 2), 0.82 - (lsy / 2)
	lpx = lpx + 0.2
	registerButton = dgsCreateButton(lpx, lpy, lsx, lsy, 'Register', true, login)
	dgsSetFont(registerButton, excluded)

	dgsAlphaTo(login, 1, false, 'InQuad', 1000)
	dgsAlphaTo(title, 1, false, 'InBounce', 1500)

	if fileExists('@credentials') then
		local fileHandle = fileOpen('@credentials')
		if fileHandle then
			-- local username, password =
			local data = fromJSON(base64Decode(fileRead(fileHandle, fileGetSize(fileHandle))))
			fileClose(fileHandle)
			dgsSetText(usernameEdit, data[1])
			dgsSetText(passwordEdit, data[2])
			dgsCheckBoxSetSelected(rememberBox, true)
		end
	end
end

function destroyLogin()
	removeEventHandler('onDgsMouseClickDown', login, onClick)
	destroyElement(login)
	login = nil
	dgsAlphaTo(title, 0, false, 'InQuad', 200)
	setTimer(
		function()
			destroyElement(title)
		end,
		201,
		1
	)
end

function showRegister()
	if login then
		destroyLogin()
	end
	local roundRect = dgsCreateRoundRect(20, false, tocolor(0, 90, 0, 160))
	local lsx, lsy = 0.26, 0.42
	local lpx, lpy = 0.5 - (lsx / 2), 0.5 - (lsy / 2)
	lsy = lsy + 0.1
	register = dgsCreateImage(lpx, lpy, lsx, lsy, roundRect, true)
	dgsSetAlpha(register, 0)
	addEventHandler('onDgsMouseClickDown', register, onClick)

	local lsx, lsy = 0, 0
	local lpx, lpy = 0.5, 0.30
	lsy = lsy + 0.1
	rTitle = dgsCreateLabel(lpx, lpy, lsx, lsy, 'Registration', true, background)
	dgsSetFont(rTitle, chopsic)
	dgsLabelSetHorizontalAlign(rTitle, 'center')
	dgsLabelSetVerticalAlign(rTitle, 'center')
	dgsSetLayer(rTitle, 'top', true)
	dgsSetAlpha(rTitle, 0)

	local lsx, lsy = 0.8, 0.1
	local lpx, lpy = 0.5 - (lsx / 2), 0.26 - (lsy / 2)
	usernameEdit = dgsCreateEdit(lpx, lpy, lsx, lsy, '', true, register)
	dgsSetFont(usernameEdit, speedphreak)
	dgsSetProperty(usernameEdit, 'placeHolderFont', speedphreak)
	dgsSetProperty(usernameEdit, 'placeHolderColor', tocolor(0, 65, 65, 185))
	dgsEditSetPlaceHolder(usernameEdit, 'Username')

	local lsx, lsy = 0.8, 0.1
	local lpx, lpy = 0.5 - (lsx / 2), 0.26 - (lsy / 2)
	lpy = lpy + 0.13
	emailEdit = dgsCreateEdit(lpx, lpy, lsx, lsy, '', true, register)
	dgsSetFont(emailEdit, speedphreak)
	dgsSetProperty(emailEdit, 'placeHolderFont', speedphreak)
	dgsSetProperty(emailEdit, 'placeHolderColor', tocolor(0, 65, 65, 185))
	dgsEditSetPlaceHolder(emailEdit, 'Email')

	local lsx, lsy = 0.8, 0.1
	local lpx, lpy = 0.5 - (lsx / 2), 0.26 - (lsy / 2)
	lpy = lpy + 0.13 * 2
	passwordEdit = dgsCreateEdit(lpx, lpy, lsx, lsy, '', true, register)
	dgsEditSetMasked(passwordEdit, true)
	dgsSetProperty(passwordEdit, 'placeHolderFont', speedphreak)
	dgsSetProperty(passwordEdit, 'placeHolderColor', tocolor(0, 65, 65, 185))
	dgsEditSetPlaceHolder(passwordEdit, 'Password')

	local lsx, lsy = 0.8, 0.1
	local lpx, lpy = 0.5 - (lsx / 2), 0.26 - (lsy / 2)
	lpy = lpy + 0.13 * 3
	vPasswordEdit = dgsCreateEdit(lpx, lpy, lsx, lsy, '', true, register)
	dgsEditSetMasked(vPasswordEdit, true)
	dgsSetProperty(vPasswordEdit, 'placeHolderFont', speedphreak)
	dgsSetProperty(vPasswordEdit, 'placeHolderColor', tocolor(0, 65, 65, 185))
	dgsEditSetPlaceHolder(vPasswordEdit, 'Verify Password')

	local lsx, lsy = 0.38, 0.16
	local lpx, lpy = 0.5 - (lsx / 2), 0.82 - (lsy / 2)
	lpx = lpx - 0.2
	submitButton = dgsCreateButton(lpx, lpy, lsx, lsy, 'Submit', true, register)
	dgsSetFont(submitButton, excluded)

	local lsx, lsy = 0.38, 0.16
	local lpx, lpy = 0.5 - (lsx / 2), 0.82 - (lsy / 2)
	lpx = lpx + 0.2
	backButton = dgsCreateButton(lpx, lpy, lsx, lsy, 'Back', true, register)
	dgsSetFont(backButton, excluded)

	dgsAlphaTo(register, 1, false, 'InQuad', 1000)
	dgsAlphaTo(rTitle, 1, false, 'InBounce', 1500)
end

function destroyRegister()
	removeEventHandler('onDgsMouseClickDown', register, onClick)
	destroyElement(register)
	register = nil
	dgsAlphaTo(rTitle, 0, false, 'InQuad', 200)
	setTimer(
		function()
			destroyElement(rTitle)
		end,
		201,
		1
	)
end

function empty(obj)
	local type = type(obj)
	if type == 'nil' then
		return true
	elseif type == 'string' then
		if obj == '' then
			return true
		else
			return false
		end
	elseif type == 'number' then
		return false
	elseif type == 'table' then
		for i, v in pairs(obj) do
			return false
		end
		return true
	elseif type == 'boolean' then
		if obj then
			return false
		else
			return true
		end
	elseif type == 'function' then
		return false
	end
end

function onClick()
	if source == loginButton then
		local username, password = dgsGetText(usernameEdit), dgsGetText(passwordEdit)
		local errors = {}
		if empty(username) then
			errors[#errors + 1] = 'Empty username'
		end
		if empty(password) then
			errors[#errors + 1] = 'Empty password'
		end
		if not empty(errors) then
			iprint(errors)
			return
		end
		dgsSetEnabled(loginButton, false)
		triggerServerEvent('onAuthRequest', resourceRoot, username, password)
	elseif source == registerButton then
		showRegister()
	elseif source == backButton then
		showLogin()
	elseif source == submitButton then
		local username, password, vPassword, email = dgsGetText(usernameEdit), dgsGetText(passwordEdit), dgsGetText(vPasswordEdit), dgsGetText(emailEdit)
		local errors = {}
		if empty(username) then
			errors[#errors + 1] = 'Empty username'
		end
		if empty(password) then
			errors[#errors + 1] = 'Empty password'
		end
		if empty(vPassword) then
			errors[#errors + 1] = 'Empty vPassword'
		end
		if empty(email) then
			errors[#errors + 1] = 'Empty email'
		end
		if password ~= vPassword then
			errors[#errors + 1] = 'password ~= vPassword'
		end
		if not empty(errors) then
			iprint(errors)
			return
		end
		dgsSetEnabled(submitButton, false)
		triggerServerEvent('onRegisterRequest', resourceRoot, username, password, email)
	end
end

addEventHandler(
	'onClientPlayerSpawn',
	root,
	function()
		if source == localPlayer and login or register then
			if login then
				destroyLogin()
			end
			if register then
				destroyRegister()
			end
			if music then
				local timer = nil
				local function fadeMusic()
					local _, i, _ = getTimerDetails(timer)
					setSoundVolume(music, i / 100)
					if i == 1 then
						destroyElement(music)
					end
				end
				timer = setTimer(fadeMusic, 10, 100)
			end
			showCursor(false)
			dgsAlphaTo(background, 0, false, 'OutBounce', 2000)
			setTimer(
				function()
					destroyElement(background)
					background = nil
				end,
				3001,
				1
			)
		end
	end
)

addEvent('onAuthSuccess', true)
addEventHandler(
	'onAuthSuccess',
	root,
	function()
		local fileHandle = fileCreate('@credentials')
		if fileHandle then
			local username, password = dgsGetText(usernameEdit), dgsGetText(passwordEdit)
			fileWrite(fileHandle, base64Encode(toJSON({username, password})))
			fileClose(fileHandle)
		end
		print('Auth Success!')
		triggerServerEvent('onUserSpawn', resourceRoot)
	end
)

addEvent('onAuthFailure', true)
addEventHandler(
	'onAuthFailure',
	root,
	function()
		dgsSetEnabled(loginButton, true)
		print('Auth Failure!')
	end
)

addEvent('onRegisterTaken', true)
addEventHandler(
	'onRegisterTaken',
	root,
	function()
		print('Taken!')
	end
)

addEvent('onRegisterSuccess', true)
addEventHandler(
	'onRegisterSuccess',
	root,
	function()
		print('Register Success!')
	end
)

addEvent('onRegisterFailure', true)
addEventHandler(
	'onRegisterFailure',
	root,
	function()
		print('Register Failure!')
	end
)

function authUser()
end

function registerUser()
end

function doesUserExist()
end

function doesEmailExist()
end
