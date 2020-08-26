-- nmsl
local Api = require("coreApi")
local http = require("http")


function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end

function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end
    if data.Content == 'nmsl' then
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = '\n'..http.request('GET', 'https://nmsl.shadiao.app/api.php?level=min&lang=zh_cn').body,
                atUser = data.FromUserId
            }
        )
    end
    return 1
end

