function test_import() 
	local temp=import_contract('contract.logtest') 
	temp.chainhelper=chainhelper 
	temp.date=date  
	temp.logtest() 
end