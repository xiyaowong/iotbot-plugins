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
    return 1
end
--收到所有相关事件的集合 如群成员进群退群管理升降消息撤回、好友撤回删除等事件
function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end

