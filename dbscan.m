function dataset = dbscan(dataset, epsilon, minPoints)
	dataset = [dataset zeros(size(dataset, 1), 1)];
	clusterID = 1;
	for i=1:size(dataset, 1)
		point = dataset(i, :);
		if point(3) == 0
			[flag, dataset] = expandCluster(dataset, point, clusterID, epsilon, minPoints);
			if flag
				clusterID += 1;
			end
		end
	end

	colors_list = ['r', 'b', 'm', 'y', 'c', 'g']';
	shapes_list = ['*', '+', 'o', 'x']';

	% plot dataset and the result of clustering
	clf;
	plot(dataset(:, 1), dataset(:, 2), 'ro', 'MarkerSize', 5)
	pause(5);
	clf;
	hold on;
	plot(dataset(dataset(:, 3)==0, 1), dataset(dataset(:, 3)==0, 2), 'k*', 'MarkerSize', 5)
	idx = 1;
	flag = false;
	for s=1:size(shapes_list, 1)
		for c=1:size(colors_list, 1)
			plot(dataset(dataset(:, 3)==idx, 1), dataset(dataset(:, 3)==idx, 2),sprintf('%s',colors_list(c, :),shapes_list(s, :)),'MarkerSize',5)
			if idx == clusterID
				flag = true;
				break
			end
			idx += 1;
		end
		if flag
			break
		end
	end
endfunction
