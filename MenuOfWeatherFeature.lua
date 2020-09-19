-- 天气菜单
local Api = require("coreApi")
local http = require("http")

function menu()
    local items = {
        'nmc/天气 + 城市(简短，准确)',
        '近10天全国最高气温实况图 => 最高气温实况',
        '近10天全国最低气温实况图 => 最低气温实况',
        '24小时最高气温预报 => 最高气温预报',
        '24小时降水量预报 => 降水量预报',
        '1小时降水量实况 => 降水量',
        '全国逐时风 => 逐时风',
        '全国雷达拼图 => 雷达',
        '能见度 => 能见度',
        'FY4A真彩色 => 真彩色',
        'FY4A红外 => 4A红外',
        'FY4A可见光 => 4A可见光',
        'FY2G可见光 => 2G可见光',
        'FY4A水汽 => 4A水汽',
        'FY2G水汽增强图 => 2G水汽增强图',
        'FY2G红外一增强图 => 2G红外一增强图',
        'FY2G红外二增强图 => 2G红外二增强图',
        'FY2G圆盘图 彩色圆盘图 => 彩色圆盘图',
        '海区红外云图 => 海区红外云图',
        '台风报文 => 台风报文',
        '台风路径预报 => 台风路径预报',
        '森林火险气象预报 => 森林火险气象预报',
        '草原火险气象预报 => 草原火险气象预报',
        '公路气象预报 => 公路气象预报',
        '山洪灾害气象预警 => 山洪灾害气象预警',
        '渍涝风险气象预警 => 渍涝风险气象预警',
        'GRAPES_TYM台风路径 => GT台风路径'
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
    if data.Content == '天气菜单' or data.Content == 'wmenu' then
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
        return 2
    end
    return 1
end

function ReceiveFriendMsg(CurrentQQ, data) return 1 end
function ReceiveEvents(CurrentQQ, data, extData) return 1 end
