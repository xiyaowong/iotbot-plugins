-- menu 菜单
local Api = require("coreApi")
local json = require("json")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
    local menu = [[{
  "app": "com.tencent.miniapp",
  "desc": "",
  "view": "notification",
  "ver": "0.0.0.1",
  "prompt": "卑微助手菜单菜单",
  "meta": {
    "notification": {
      "appInfo": {
        "appName": "卑微助手菜单",
        "appType": 4,
        "ext": "",
        "img": "https://pic4.zhimg.com/80/v2-1df5a025d1a212d75be7c53d5d14b37b_720w.jpg",
        "img_s": "",
        "appid": 1108249016,
        "iconUrl": "https://pic4.zhimg.com/80/v2-1df5a025d1a212d75be7c53d5d14b37b_720w.jpg"
      },
      "button": [
        { "action": "", "name": "[menu]  菜单" },
        { "action": "", "name": "[搜题+?]  搜题,题目至少六个字" },
        { "action": "", "name": "[百科+?]  百度百科" },
        { "action": "", "name": "[pic+?]   百度图片" },
        { "action": "", "name": "[pix]   随机动漫图片" },
        { "action": "", "name": "[微博]    微博热搜" },
        { "action": "", "name": "[历史上的今天]  历史上的今天" },
        { "action": "", "name": "[点歌+?]  点歌" }
      ],
      "emphasis_keyword": ""
    }
  }
}]]
    if data.Content == "menu" then
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "JsonMsg",
                groupid = 0,
                content = menu,
                atUser = data.FromUserId
            }
        )
        return 2
    end
    return 1
end
function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end

