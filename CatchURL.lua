local Api = require("coreApi")
local http = require("http")
local json = require("json")

function ReceiveFriendMsg(CurrentQQ, data) return 1 end
function ReceiveEvents(CurrentQQ, data, extData) return 1 end

function ReceiveGroupMsg(CurrentQQ, data)
	if data.FromUserId == tonumber(CurrentQQ) then
		return 1
	end

	if data.MsgType == 'XmlMsg' then
		local xml = json.decode(data.Content).Content
		local url = xml:match([[url=%"(.-)%"]])
		if url ~= nil then
			Api.Api_SendMsg(
                CurrentQQ,
                {
                    toUser = data.FromGroupId,
                    sendToType = 2,
                    sendMsgType = "TextMsg",
                    groupid = 0,
                    content = url,
                    atUser = data.FromUserId
                }
			)
		end
	elseif data.MsgType == 'JsonMsg' then
		-- local data = json.decode(data.Content)
	end
end
