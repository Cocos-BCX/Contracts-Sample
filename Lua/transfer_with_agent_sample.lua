function init(agent,agency_fee) 	
	assert(chainhelper:is_owner(),'chainhelper:is_owner()')
	read_list={public_data={is_init=true}}
	chainhelper:read_chain()
	assert(public_data.is_init==nil,'public_data.is_init==nil')
	public_data.is_init=true
	assert(agency_fee>0,'agency_fee>0')
	public_data.agent=agent
	public_data.agency_fee=agency_fee
	chainhelper:write_chain()
end


function transfer(to,amount,symbol,islog)
	read_list={public_data={agent=true,agency_fee=true}}
	chainhelper:read_chain()
	assert(public_data.agent~=nil and public_data.agency_fee~=nil,'public_data.agent~=nil and public_data.agency_fee')
	assert(amount>public_data.agency_fee,'amount>public_data.agency_fee')
	local real_amount=amount-public_data.agency_fee
	chainhelper:transfer_from_caller(to,real_amount,symbol,islog)
	chainhelper:transfer_from_caller(public_data.agent,public_data.agency_fee,symbol,islog)	
end

function set_agent_and_fee(agent,agency_fee)
	assert(chainhelper:is_owner(),'chainhelper:is_owner()')
	read_list={public_data={is_init=true,agent=true,agency_fee=true}}
	chainhelper:read_chain()
	assert(public_data.is_init~=nil,'public_data.is_init==nil')
	assert(public_data.agent~=nil and public_data.agency_fee~=nil,'public_data.agent~=nil and public_data.agency_fee')
	public_data.agent=agent
	assert(agency_fee>0,'agency_fee>0')
	public_data.agency_fee=agency_fee
	write_list={public_data={agent=true,agency_fee=true}}
	chainhelper:write_chain()
end