function regionPointsList = regionQuery(dataset, point, epsilon)
	regionPointsList = [];
	for i=1:size(dataset, 1)
		distance = sqrt(sum(point(:, 1:2) - dataset(i,1:2)).^2);
		if distance <= epsilon
			regionPointsList = [regionPointsList; dataset(i, :)];
		end
	end
endfunction
