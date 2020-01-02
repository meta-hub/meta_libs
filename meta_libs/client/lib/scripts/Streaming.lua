LoadModel = function(model)
  local hash = (type(model) == "number" and model or GetHashKey(model))
  while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(0)
  end
end

ReleaseModel = function(model)
  local hash = (type(model) == "number" and model or GetHashKey(model))
  if HasModelLoaded(hash) then
    SetModelAsNoLongerNeeded(hash)
  end
end

LoadAnimDict = function(dict)
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    Wait(0)
  end
end

ReleaseAnimDict = function(dict)
  if HasAnimDictLoaded(dict) then
    SetAnimDictAsNoLongerNeeded(dict)
  end
end

exports('LoadModel', LoadModel)
exports('ReleaseModel', ReleaseModel)
exports('LoadAnimDict', LoadAnimDict)
exports('ReleaseAnimDict', ReleaseAnimDict)