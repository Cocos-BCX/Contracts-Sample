function init()
	assert(chainhelper:is_owner(),'chainhelper:is_owner()')
	read_list={public_data={is_init=true}}
	chainhelper:read_chain()
	assert(public_data.is_init==nil,'public_data.is_init==nil')
	public_data.locked=0
	public_data.is_init=true
	chainhelper:write_chain()
end

function pay_with_lock(amount,symbol)
	assert(amount>0,'amount > 0')
	read_list={public_data={}}
	chainhelper:read_chain()
	assert(public_data.locked+amount>public_data.locked,'public_data.locked+amount>public_data.locked')
	public_data.locked=public_data.locked+amount;								 --[[调整锁定记录]] 
	assert(public_data.locked<=chainhelper:number_max(),'public_data.locked<=chainhelper:number_max()')
	chainhelper:transfer_from_caller(contract_base_info.owner,amount,symbol,true)--[[转入代币]]
	chainhelper:adjust_lock_asset(symbol,amount)								 --[[锁定代币]]
	--[[do something]]
	write_list=read_list
	chainhelper:write_chain()
end	

function adjustment_lock_and_transfer(to,amount,symbol)
	assert(chainhelper:is_owner(),'chainhelper:is_owner()')
	read_list={public_data={}}
	chainhelper:read_chain()
	assert(amount>0 and public_data.locked-amount>=0,'amount>0 and public_data.locked-amount>=0')
	public_data.locked=public_data.locked-amount					--[[调整锁定记录]]
	chainhelper:adjust_lock_asset(symbol,-amount)					--[[解锁代币]]
	if(to~=contract_base_info.owner)then
		chainhelper:transfer_from_owner(to,amount,symbol,true)		--[[转出代币]]
	end
	write_list=read_list
	chainhelper:write_chain()
end