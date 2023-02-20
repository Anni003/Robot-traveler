local Stack = {}

function Stack.push(item)
    table.insert(Stack, item)
end

function Stack.pop()
    return table.remove(Stack)
end

return Stack
