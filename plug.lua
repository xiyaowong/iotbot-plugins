--TODO
--[[

| enabledPlugins  | 已启用插件 |
| disabledPlugins | 已停用插件 |
| enable + name   | 启用插件   |
| disable + name  | 停用插件   |
| install + url   | 安装插件   |
| remove + name   | 移除插件   |

]]

enabledPlugins_cmd = 'ls ./Plugins/*.lua'
disabledPlugins_cmd = 'ls ./Plugins/*.lua.bak'

function enabledPlugins() -- table
    data = io.popen(enabledPlugins_cmd)
    result = {}
    repeat
        fileName = data:read()
        if fileName == nil then
            break
        end
        fileName = fileName:match("^[%s]*(.-)[%s]*$")
        table.insert(result, fileName)
    until fileName == nil
    return result
end

function disabledPlugins() -- table
    data = io.popen(disabledPlugins_cmd)
    result = {}
    repeat
        fileName = data:read()
        if fileName == nil then
            break
        end
        fileName = fileName:match("^[%s]*(.-)[%s]*$")
        table.insert(result, fileName)
    until fileName == nil
    return result
end

function enable(plugName) -- string
    plugs = {}
    for _, val in ipairs(disabledPlugins()) do
        if val:find(plugName) then
            table.insert(plugs, val)
        end
    end
    if #plugs == 1 then
        plug = plugs[1]
        if os.rename(plug, plug:sub(1, #plugs-6)) then
            return string.format('[%s]启用成功', plug)
        else
            return string.format('[%s]启用失败', plug)
        end
    elseif #plugs > 1 then
        return '匹配到多个插件'
    elseif #plugs == 0 then
        return '插件不存在或未被停用'
    end
end

function disable(plugName) -- string
    plugs = {}
    for _, val in ipairs(enabledPlugins()) do
        if val:find(plugName) then
            table.insert(plugs, val)
        end
    end
    if #plugs == 1 then
        plug = plugs[1]
        if os.rename(plug, plug..'.bak') then
            return string.format('[%s]停用成功', plug)
        else
            return string.format('[%s]停用失败', plug)
        end
    elseif #plugs > 1 then
        return '匹配到多个插件'
    elseif #plugs == 0 then
        return '插件不存在或未被启用'
    end
end

function ReceiveFriendMsg(CurrentQQ, data) return 1 end
function ReceiveEvents(CurrentQQ, data, extData) return 1 end
function ReceiveGroupMsg(CurrentQQ, data) return 1 end
