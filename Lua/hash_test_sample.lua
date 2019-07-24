function set_hash(source) 
	public_data.hash256=chainhelper:hash256(source) 
	public_data.hash512=chainhelper:hash512(source) 
	chainhelper:write_chain() --[[默认：write_list={public_data={},private_data={}} ,更新全部数据 ，本合约仅有hash256，跟hash512两个数据 ]]
end 
function check_hash(source)
	read_list={public_data={start=1,stop=2}}
	chainhelper:read_chain() --[[默认：read_list={public_data={},private_data={}} ,载入全部数据，本合约仅有hash256，跟hash512两个数据]] 
	assert(public_data.hash256==chainhelper:hash256(source),'hash256 check error') 
	assert(public_data.hash512==chainhelper:hash512(source),'hash512 check error') 
end