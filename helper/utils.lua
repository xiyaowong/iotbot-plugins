utils = {}

function utils.stringStarts(str, Start) --字符串是否以指定字符开头
   return string.sub(str, 1, string.len(Start)) == Start
end

function utils.stringEnds(str, End) --字符串是否以指定字符结尾
   return End == '' or string.sub(str, -string.len(End)) == End
end

return utils


