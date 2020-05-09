local log = require("log") --导入日志输出模块
local Api = require("coreApi")--导入API模块
local json = require("json")--导入JSON解析模块
local http = require("http")

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
    local menu = "\n.menu 查看菜单".."\n.short <长链接> 生成短链接".."\n.st <题目> 搜题".."\n.bk <关键词> 百度百科搜索".."\n.weibo 微博热搜榜".."\n.lssdjt 历史上今天".."\n.pic <关键字> 百度图片搜索"
    if data.Content == ".menu" then
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = menu,
                atUser = data.FromUserId
            }
        )
        return 2
    end
    return 1
end
--收到所有相关事件的集合 如群成员进群退群管理升降消息撤回、好友撤回删除等事件
function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end

