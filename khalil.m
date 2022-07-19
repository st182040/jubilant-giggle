function [T, X, dotX] = khalil(len, x0, tmax)

    if nargin < 4, tmax = 20; end

    assert(numel(x0) == 2);
    x0 = reshape(x0, 1, 2);

    fun = @(t, x)f(t, x);
    [T, X] = ode45(fun, linspace(0, tmax, len), x0, []);

    dotX = zeros(size(X));

    for i = 1:size(X, 1)
        dotX(i, :) = f(T(i), X(i, :).').';
    end

end

function dxdt = f(t, x)
    dxdt = [-x(1) * (1 - x(2)); -x(2) * (1 - x(1))];
end
