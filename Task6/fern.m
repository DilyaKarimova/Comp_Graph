function fern

maxI = 1E7;
x = zeros(maxI,1);
y = zeros(maxI,1);

for i = 2:maxI
    r = rand;

    if (0 <= r) && (r < 0.01)
        x(i) = 0;
        y(i) = 0.16*y(i-1);
    elseif (0.01 <= r) && (r < 0.86)
        x(i) = 0.85 * x(i-1) + 0.04 * y(i-1);
        y(i) = -0.04 * x(i-1) + 0.85 * y(i-1) + 1.6;
    elseif (0.86 <= r) && (r < 0.93)
        x(i) = 0.2  * x(i-1) - 0.26 * y(i-1);
        y(i) = 0.23 * x(i-1) + 0.22 * y(i-1) + 1.6;
    else
        x(i) = -0.15 * x(i-1) + 0.28 * y(i-1);
        y(i) =  0.26 * x(i-1) + 0.24 * y(i-1) + 0.44;
    end
end

plot(x,y,'.', 'Color', [79, 121, 66]/256)

end
