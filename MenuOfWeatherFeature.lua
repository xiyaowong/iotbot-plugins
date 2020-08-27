-- 天气菜单
local Api = require("coreApi")
local http = require("http")

function menu()
    local items = {
        '近10天全国最高气温实况图 => 最高气温实况',
        '近10天全国最低气温实况图 => 最低气温实况',
        '24小时最高气温预报 => 最高气温预报',
        '24小时降水量预报 => 降水量预报',
        '1小时降水量实况 => 降水量',
        '全国逐时风 => 逐时风',
        '全国雷达拼图 => 雷达',
        '能见度 => 能见度',
        'FY4A真彩色 => 真彩色',
        '台风报文 => 台风报文'
    }
    local msg = ''
    for _,val in pairs(items) do
        msg = msg..val..'\n'
    end
    return '天气菜单:\n'..msg
end

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end
    if data.Content == '天气菜单' then
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = menu(),
                atUser = 0
            }
        )
    end
    return 1
end

function ReceiveFriendMsg(CurrentQQ, data) return 1 end
function ReceiveEvents(CurrentQQ, data, extData) return 1 end
