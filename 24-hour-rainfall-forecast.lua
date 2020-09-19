-- 24小时降水量预报
local Api = require("coreApi")
local http = require("http")
local json = require("json")

function ReceiveFriendMsg(CurrentQQ, data) return 1 end
function ReceiveEvents(CurrentQQ, data, extData) return 1 end

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end

    if data.Content:find('降水量预报') then
        local body = http.request('GET', 'http://www.nmc.cn/rest/relevant/380').body
        local info = json.decode(body)
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "PicMsg",
                content = '',
                groupid = 0,
                atUser = 0,
                picUrl = "http://image.nmc.cn"..info[1].image,
                picBase64Buf = "",
                fileMd5 = ""
            }
        )
        return 2
    end
    return 1
end
