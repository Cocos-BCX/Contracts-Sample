--获取当前最高区块时间(精确至秒)
function timetest() 
	public_data.time=date('%Y-%m-%dT%H:%M:%S', chainhelper:time()) 
	write_list={public_data={time=true}} 
	chainhelper:write_chain() 
end
--获取当前real_time函数执行的真实时间(精确至微秒)
function real_time_test()
    read_list={public_data={time10=true}}
    chainhelper:read_chain()
	assert(chainhelper:is_owner(),'You`re not the contract`s owner')
    local i=0
    while(i<10)do
        i=i+1
        if(public_data.time10==nil)then
            public_data.time10={}
			table.insert(public_data.time10,chainhelper:real_time())
        else
            table.insert(public_data.time10,chainhelper:real_time())
        end
    end
    write_list={public_data={time10=true}}
    chainhelper:write_chain()
	chainhelper:log('date:'..date('%Y-%m-%dT%H:%M:%S', chainhelper:time())) 
end

