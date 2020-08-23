-- 发送闪照原图
local api = require("coreApi")
local http = require("http")
local json = require("json")

function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end
    if data.MsgType == 'PicMsg' and data.Content:find('群消息-QQ闪照') then
        api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "PicMsg",
                content = "你竟然发闪照[表情176]",
                groupid = 0,
                atUser = 0,
                picUrl = json.decode(data.Content).Url,
                picBase64Buf = "",
                fileMd5 = ""
            }
       )
    end
    return 1
end

function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end
