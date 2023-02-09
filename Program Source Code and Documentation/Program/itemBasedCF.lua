local file = io.open('predicted_itembased.txt','w')
avg_item,sum,sum_sqrv,train,wij = {},{},{},{},{}					--declaration of arrays
for i = 1, 11 do												--initialize value for avg_item[]
	avg_item[i] = 0
end

min,max = {},{}
-------------determines the min and max per feature for normalization of data set values----------------
for i = 1,10 do
	min[i],max[i] = 0,0
end

for line in io.lines 'Input/trainCF.txt' do
	col = 0
	for n in line:gmatch'%S+' do
		col = col + 1
		if col < 11 then
			if tonumber(n) > max[col] then max[col] = tonumber(n)
			elseif tonumber(n) < min[col] then min[col] = tonumber(n) end
		end
	end
end
for line in io.lines 'Input/testCF.txt' do
	col = 0
	for n in line:gmatch'%S+' do
		col = col + 1
		if col < 11 then
			if tonumber(n) > max[col] then max[col] = tonumber(n)
			elseif tonumber(n) < min[col] then min[col] = tonumber(n) end
		end
	end
end
--------------------------------------------------------------------------------
-------------------------Collaborative Filtering computation--------------------
row = 1
for line in io.lines 'Input/trainCF.txt' do										--reads each line in 'train.txt' 
	col = 1
	train[row] = {}
	for n in line:gmatch'%S+' do
		if col < 11 then
			train[row][col] = (tonumber(n)-min[col])/(max[col]-min[col])	--puts to array train[][] the values per line 
		else 
			train[row][col] = tonumber(n)
		end
		avg_item[col] = avg_item[col] + train[row][col]
		col = col + 1
	end
	row = row + 1
end

for i = 1, 11 do														--computes for the average per column
	avg_item[i] = avg_item[i]/(row-1)
	sum[i],sum_sqrv[i] = 0,0
end

sum_sqru = 0															
for i= 1, row-1 do
	for j = 1, 10 do
		sum[j] = (train[i][11]-avg_item[11])*(train[i][j]-avg_item[j]) + sum[j]	--will be used in computation of similarity
		sum_sqrv[j] = math.pow((train[i][j]-avg_item[j]),2) + sum_sqrv[j]
	end
	sum_sqru = math.pow((train[i][11]-avg_item[11]),2) + sum_sqru
end

for i = 1, 10 do														--computes for similarity using Pearson correlation
	wij[i] = sum[i]/(math.sqrt(sum_sqru)*math.sqrt(sum_sqrv[i]))
end

TP,TN,FP,FN = 0,0,0,0
for line in io.lines 'Input/testCF.txt' do										--reads each line in 'test.txt'
	avg, col, num,denom = 0,1,0,0
	for n in line:gmatch'%S+' do
		if col < 11 then
			num =  (((tonumber(n)-min[col])/(max[col]-min[col])) * wij[col])+ num		--numerator of general CF equation
			denom = math.abs(wij[col]) + denom											--denominator of genral CF equation
		else
			value = tonumber(n)
		end
		col = col + 1
	end
	pai = num/denom														--computes for the output of CF technique
	print(pai)
	file:write(pai.."\n")

	if pai < 0.5 and value == 0 then									--classify output if TN, FN, TP, FP
		TN = TN + 1
	elseif pai < 0.5 and value == 1 then 
		FN = FN + 1
	elseif pai >= 0.5 and value == 1 then 
		TP = TP + 1
	else 
		FP = FP + 1 
	end
	
end

-----------------------ROC Measures--------------------------------------------
print("TP = "..TP,"FP = "..FP,"TN = "..TN,"FN = "..FN,"\n")
file:write("TP = ",TP,"\tFP = ",FP,"\tTN = ",TN,"\tFN = ",FN,"\n")
TPR = TP/(TP+FN)
FPR = FP/(FP+TN)
ACC = (TP + TN)/(TP + FN + FP + TN)
SPC = 1 - FPR
print("TPR "..TPR,"FPR "..FPR,"ACC "..ACC,"SPC "..SPC)
file:write("\nTPR = ",TPR," FPR = ",FPR," ACC = ", ACC,"SPC = ",SPC,"\n")