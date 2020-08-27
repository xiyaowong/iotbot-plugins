-- 复读机
local Api = require("coreApi")

function ReceiveGroupMsg(CurrentQQ, data)
    if data.Content:find('复读机') then
        word = data.Content:gsub("复读机", "")
        repeat
            word = word:gsub('复读机', '')
        until not word:find('复读机') 
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = word,
                atUser = 0
            }
        )
    end
    return 1
end

function ReceiveEvents(CurrentQQ, data, extData) return 1 end
function ReceiveFriendMsg(CurrentQQ, data) return 1 end
