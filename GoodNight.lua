-- 晚安发送语音
local Api = require("coreApi")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data) return 1 end
function ReceiveEvents(CurrentQQ, data, extData) return 1 end

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end
    if data.Content == '晚安' then
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "VoiceMsg", 
                groupid = 0,
                content = "",
                atUser = 0,
                voiceUrl = "http://static.missevan.com/128BIT/202004/08/49723badf1aaeebd09d04cc5d875888c215453.mp3",
                voiceBase64Buf = ""
            }
        )
    end
    return 1
end
