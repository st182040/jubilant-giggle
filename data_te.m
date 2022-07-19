function data_te()
    seed = 123456789;
    rng(seed);

    name = 'data';

    inits = [rand(20, 1) * 1 - 0.5, rand(20, 1) * 1 - 0.5];

    len_epi = 400; tmax = 20.0;

    num_epi = size(inits, 1);
    T = zeros(num_epi, len_epi);
    Y = zeros(num_epi, len_epi, 2);
    dotY = zeros(num_epi, len_epi, 2);

    for i = 1:num_epi
        [T_, Y_, dotY_] = khalil(len_epi, inits(i, :), tmax);
        T(i, :) = T_;
        Y(i, :, :) = Y_;
        dotY(i, :, :) = dotY_;
    end

    noisestd = 0;

    Y = Y + randn(size(Y)) * noisestd;
    dotY = dotY + randn(size(dotY)) * noisestd;

    % save
    if true
        save(sprintf('./%s_te.mat', name), 'T', 'Y', 'dotY');

        fprintf('data saved\n');
    end

    % plot
    if true
        figure;
        hold on;

        for i = 1:size(Y, 1)
            plot(Y(i, :, 1), Y(i, :, 2), 'y');
        end

        load('data_tr.mat');

        for i = 1:size(Y, 1)
            plot(Y(i, :, 1), Y(i, :, 2), 'b');
        end

        load('data_va.mat');

        for i = 1:size(Y, 1)
            plot(Y(i, :, 1), Y(i, :, 2), 'r');
        end

        hold off;
    end

end
