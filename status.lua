-- 集群信息
local Api = require("coreApi")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data) return 1 end
function ReceiveEvents(CurrentQQ, data, extData) return 1 end

local api = 'http://127.0.0.1:8888/v1/ClusterInfo'

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end
    if data.Content:find('status') or data.Content:find('状态') then
        local body = http.request('GET', api).body
        print(body)
        local data = json.decode(body)
        local status = string.format(
            'ClusterIP: %s\nPlatform: %s\nArch: %s\nServerRuntime: %s\nVersion: %s',
            data.ClusterIP, data.Platform, data.GoArch, data.ServerRuntime, data.Version
        )
        for _, user in ipairs(data.QQUsers) do
            local userInfo = string.format(
                '\n------\nQQ: %s\nInfo: %s',
                user.QQ, user.UserLevelInfo
            )
            status = status..userInfo
        end
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = status,
                atUser = 0
            }
        )
    end
    return 2
end
