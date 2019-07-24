function sum_public_by_rand()
    read_list={public_data={sum_rand_10=true}}
    chainhelper:read_chain()
	assert(chainhelper:is_owner(),'You`re not the contract`s owner')
    local i=0
    while(i<10)do
        i=i+1
        if(public_data.sum_rand_10==nil)then
            public_data.sum_rand_10=0
            public_data.sum_rand_10=public_data.sum_rand_10+chainhelper:random()%100
        else
            public_data.sum_rand_10=public_data.sum_rand_10+chainhelper:random()%100
        end
    end
    write_list={public_data={sum_rand_10=true}}
    chainhelper:write_chain()
	chainhelper:log('date:'..date('%Y-%m-%dT%H:%M:%S', chainhelper:time())..',sum:'..public_data.sum_rand_10) 
end

