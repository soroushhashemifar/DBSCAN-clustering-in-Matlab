function [flag, dataset] = expandCluster(dataset, point, clusterID, epsilon, minPoints)
	clusteredPoints = [];
	seeds = regionQuery(dataset, point, epsilon);
	
	% if seeds members number is lower than minPoints, all of them are clustered as noise
	if size(seeds, 1) < minPoints
		flag = false;
		return
	end

	seeds(:, 3) = clusterID;
	dataset(ismember(dataset(:, 1:2), seeds(:, 1:2))(:, 1), 3) = clusterID; % enter clusterIDs to dataset	

	% remove Point itself from seeds
	x = (seeds(:, 1:2)==point(1:2))(:, 1);
	seeds(x, :) = nan;
	seeds = seeds(~isnan(seeds)(:, 1), :);

	while size(seeds, 1) != 0
		currentP = seeds(1, :);
		result = regionQuery(dataset, currentP, epsilon);
		if size(result, 1) >= minPoints
			for i=1:size(result, 1)
				resultP = result(i, :);
				if resultP(3) == 0
					seeds = [seeds; resultP];
				end
				resultP(:, 3) = clusterID;
				dataset(ismember(dataset(:, 1:2), resultP(:, 1:2))(:, 1), 3) = clusterID;
			end
		end
		
		% remove currentP from seeds
		x = (seeds(:, 1:2)==currentP(1:2))(:, 1);
		seeds(x, :) = nan;
		seeds = seeds(~isnan(seeds)(:, 1), :);
	end
	flag = true;
endfunction
