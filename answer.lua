local log = require("log") --导入日志输出模块
local Api = require("coreApi")--导入API模块
local json = require("json")--导入JSON解析模块
local http = require("http")--导入HTTP模块
--处理好友消息会调用此函数
--CurrentQQ 当前登录的QQ号
--[[data数据结构为
        data.FromUin  发送消息对象 int
        data.ToUin,   接收消息对象 int
        data.MsgType, 消息类型    string
        data.Content, 内容       string
        data.MsgSeq   消息SEQ序号 int
]]
function stringStarts(str, Start) --字符串是否以指定字符开头
   return string.sub(str, 1, string.len(Start)) == Start
end

local function urlEncode(s)
  s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
  return string.gsub(s, " ", "%%20")
end

function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
--处理群消息会调用此函数
--CurrentQQ 当前登录的QQ号
--[[
        data.FromGroupId,   消息来源群ID               int
        data.FromGroupName, 消息来源的群名              string
        data.FromUserId,    触发该消息的用户UserID(QQ)  int
        data.FromNickName,  触发该消息用户的昵称         string
        data.MsgType,       消息类型                   string
        data.Content,       消息内容                   string
        data.MsgSeq,        消息SEQ序号                int
        data.MsgTime,       消息时间                   int
        data.MsgRandom      消息RANDOM                int
]]
function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end
    if not stringStarts(data.Content, ".st") or data.Content == ".st" then
        return 1
    end
    q = data.Content:gsub(".st", "")
    response, _ = http.request(
        "GET",
        "http://116.62.167.164:8080/course/?q="..urlEncode(q)
    )
    html = response.body
    if not html then
        html = "小生不才，不知为何，啥也没有..."
    end
    html = string.sub(html, 1, 2450)
    Api.Api_SendMsg(
        CurrentQQ,
        {
            toUser = data.FromGroupId,
            sendToType = 2,
            sendMsgType = "TextMsg",
            groupid = 0,
            content = "\n"..html,
            atUser = data.FromUserId
        }
    )
    return 1
end
--收到所有相关事件的集合 如群成员进群退群管理升降消息撤回、好友撤回删除等事件
function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end

