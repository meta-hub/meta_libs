--  local myData = {
--    test = true,
--    num = 1,
--    str = "testing",
--    tab = {
--      tabTest = false,
--      tabNum = 2,
--      tabStr = "test",
--      tabPos = vector3(155.5,200.0,200.0),
--      tabSub = {
--        subTest = true,
--        subStr = "testing",
--        subPos = vector3(155.5,200.0,200.0),
--      },
--    },
--    myPos = vector3(155.5,200.0,200.0),
--  }
--  
--  print(json.stringify("myData",myData))
--  > myData={"num":1,"myPos":{"x":155.5,"y":200.0,"z":200.0},"test":true,"tab":{"tabcfx> Str":"test","tabSub":{"subPos":{"x":155.5,"y":200.0,"z":200.0},"subTest":true,"subStr":"testing"},"tabTest":false,"tabNum":2,"tabPos":{"x":155.5,"y":200.0,"z":200.0}},"str":"testing"}

json = (json or {})
json.encode_old = (json.encode or function(tab)
  local isIpair = table.isIpair(tab)
  local buffer = {[1]=(isIpair and "[" or "{")}
  for k,v in pairs(tab) do
    local sBuffer = (isIpair and {} or (type(k) == "string" and {[1]="\"",[2]=tostring(k),[3]="\":"} or {[1]=tostring(k),[2]=":"}))
    local t = type(v)
    if t == "table" then
      sBuffer[#sBuffer+1] = json.encode_old(v)
    elseif t == "number" or t == "boolean" then
      sBuffer[#sBuffer+1] = tostring(v)
    else
      sBuffer[#sBuffer+1] = "\""..tostring(v).."\""
    end
    buffer[#buffer+1] = table.concat(sBuffer)..","
  end
  buffer[#buffer+1] = (isIpair and "]" or "}")
  return table.concat(buffer)
end)

json.encode = function(tab,itering)
  for k,v in pairs(tab) do
    local t = type(v)
    if t == "vector2" or t == "vector3" or t == "vector3" then
      if t == "vector2" then
        tab[k] = {["x"] = v.x,["y"] = v.y}
      elseif t == "vector3" then
        tab[k] = {["x"] = v.x,["y"] = v.y,["z"] = v.z}
      elseif t == "vector4"then
        tab[k] = {["x"] = v.x,["y"] = v.y,["z"] = v.z,["w"] = v.w}
      end
    elseif t == "table" then
      tab[k] = json.encode(v,true)
    else
      tab[k] = v
    end
  end

  if itering then 
    return tab
  else 
    return json.encode_old(tab)
  end
end

json.stringify = function(k,t)
  local b = {[1]=k.."=",[2]=json.encode(t)}
  return table.concat(b)
end

exports('Json',function(...) return json; end)