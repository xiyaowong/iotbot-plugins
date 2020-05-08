local log = require("log") --导入日志输出模块
local Api = require("coreApi")--导入API模块
local http = require("http")--导入HTTP模块
local json = require("json")

function sleep(n)
       os.execute("sleep " .. n)
end
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

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end
    if not stringStarts(data.Content, ".pic") or data.Content == ".pic" then
        return 1
    end
    kw = data.Content:gsub(".pic", "")
    response, _ = http.request(
        "GET",
        "http://116.62.167.164:8080/baidu_image/?&kw="..urlEncode(kw)
    )
    html = response.body
    imgs = json.decode(html)
    if #imgs == 0 then
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = "小生不才，不知为何，啥也没有...",
                atUser = data.FromUserId
            }
        )
        return 2
    end
    for _, url in pairs(imgs) do
        print("========="..url)
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "PicMsg",
                groupid = 0,
                picUrl = url,
                picBase64Buf = "",
                content = "",
                fileMd5 = "",
                atUser = 0
            }
        )
        sleep(0.6)
    end
    return 2
end

function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end

