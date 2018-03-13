function [flag, dataset] = expandCluster(dataset, point, clusterID, epsilon, minPoints)
	
	seeds = regionQuery(dataset, point, epsilon);

	% if seeds members number is lower than minPoints, all of them are clustered as noise
	if size(seeds, 1) < minPoints
		flag = false;
		return
	end

	seeds(:, 3) = clusterID;

	% enter clusterIDs to dataset
	for i=1:size(seeds, 1)
		for j=1:size(dataset, 1)
			if seeds(i, 1:2) == dataset(j, 1:2)
				dataset(j, 3) = clusterID;
				break
			end
		end
	end	

	% remove Point itself from seeds
	x = (seeds(:, 1:2)==point(1:2))(:, 1);
	seeds(x, :) = nan;
	seeds = seeds(~isnan(seeds)(:, 1), :);

	while size(seeds, 1) != 0
		currentP = seeds(1, :);
		result = regionQuery(dataset, currentP, epsilon);

		if size(result, 1) >= minPoints
			all_zeros_idx = result(:, 3)==0;
			
			result(all_zeros_idx, 3) = clusterID;
			for i=1:size(result, 1)
				for j=1:size(dataset, 1)
					if result(i, 1:2) == dataset(j, 1:2)
						dataset(j, 3) = clusterID;
						break
					end
				end
			end

			seeds = [seeds; result(all_zeros_idx, :)];
		end
		
		% remove currentP from seeds
		% we don't search for currentP because we know it's the first row of seeds matrix
		seeds(1, :) = nan;
		seeds = seeds(~isnan(seeds)(:, 1), :);
	end

	flag = true;
endfunction
