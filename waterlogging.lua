-- 渍涝风险气象预警
local Api = require("coreApi")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data) return 1 end
function ReceiveEvents(CurrentQQ, data, extData) return 1 end

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end

    if data.Content:find('渍涝风险气象预警') then
        local resp = http.request('GET', 'http://m.nmc.cn/publish/waterlogging.html')
        if resp ~= nil then
            local body = resp.body
            local url = body:match([[<div style="text%-align:center;"><img src=%"(.-)%"></div>]])
            print(url)
            if url ~= nil then
                Api.Api_SendMsg(
                    CurrentQQ,
                    {
                        toUser = data.FromGroupId,
                        sendToType = 2,
                        sendMsgType = "PicMsg",
                        content = '',
                        groupid = 0,
                        atUser = 0,
                        picUrl = url,
                        picBase64Buf = "",
                        fileMd5 = ""
                    }
                )
                return 2
            end
        end
    end
    return 1
end

