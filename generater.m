function w = generater()
    u = rand; v = rand;
    s = 2*u - 1; t = 2*v - 1;
    r2 = s^2 + t^2;
    while r2 >= 1
        u = rand; v = rand;
        s = 2*u - 1; t = (2*v - 1);
        r2 = s^2 + t^2;
    end
    w = [2*s*sqrt(1-r2), 2*t*sqrt(1-r2), 1-2*r2];
    w = w / norm(w);