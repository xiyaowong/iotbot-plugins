-- 快速发送特效消息
local Api = require("coreApi")

function ReceiveGroupMsg(CurrentQQ, data)
    if data.Content:find('特效') and data.MsgType == 'TextMsg' then
        word = data.Content:gsub("特效", "")
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TeXiaoTextMsg",
                content = word,
            }
        )
    end
    return 1
end

function ReceiveEvents(CurrentQQ, data, extData) return 1 end
function ReceiveFriendMsg(CurrentQQ, data) return 1 end
