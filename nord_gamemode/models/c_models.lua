local models = {
    {
        id=2680,
        dff="mugsht.dff",
        txd="mugsht.txd",
        col="mugsht.col",
    }
}


addEventHandler("onClientResourceStart", resourceRoot, function()
    for i,v in pairs(models) do
        if(v.dff) then
            local txdData = engineLoadTXD("models/"..v.txd)
            if txdData then
                engineImportTXD(txdData, v.id)
            end
            local dffData = engineLoadDFF("models/"..v.dff)
			if dffData then
				engineReplaceModel(dffData, v.id)
			end
            local colData = engineLoadCOL("models/"..v.col)
            if colData then
                engineReplaceCOL( colData, v.id )
            end
        end
    end
end)