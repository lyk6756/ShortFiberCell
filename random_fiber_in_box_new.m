% PROGRAM: Generate numbers of uniform distributed cylinders with arbitrary
% orientation in a cubic volume.
% AUTHOR: Li Yukun @HIT
% DATE: 2016/12/7
%
% C           - Coord. of cylinders' centroid.
% W           - Direction vector of cylinders' central axis
% rotaxis_C   - Rotation axis of cylinder, changing the central
%               axis from the original [0 0 1] to desired W
% rotangle_C  - Rotation angle marked in degree.
%
% User m functions called:
%     isSeparatedCylinders, constrD.m

%% Input
% Input cell and cylinder geometric parameters
cell_L = 14;
cell_W = 14;
cell_H = 14;

fiber_L = 8;
fiber_R = 0.5;
fiber_Num = 30;

C = zeros(fiber_Num,3);
W = zeros(fiber_Num,3);
Maxmin = zeros(fiber_Num*2,4);
%% Genarate
rng('shuffle');
n = 1;
c = [0.5*cell_L, 0.5*cell_W, 0.5*cell_H]; 
w = [0,0.7,0.4]; 
W(n,:) = w;
C(n,:) = c;
n = n + 1;
while n <= fiber_Num
    c = [rand*cell_L, rand*cell_W, rand*cell_H];% random position of centroid
    %u = rand; v = rand;
    %s = 2*u - 1; t = pi * (2*v - 1);
    %w = [s*cos(t), s*sin(t), sqrt(1-s^2)];
    %w = w / norm(w);% random orientation of central axis
    w = generater();
    cmax = c + 0.5 * fiber_L * w; 
    cmin = c - 0.5 * fiber_L * w;
    maxmin = [max(cmax),min(cmin),min(cmax),max(cmin)];
    Maxmin(n,:) = [max(cmax),min(cmin),min(cmax),max(cmin)];
    
    for i = 1:n-1
        if max(maxmin) > cell_L - 0.5 || min(maxmin) < 0.5 || SeparatedCylinders(c, w, fiber_R, fiber_L, C(i,:), W(i,:), fiber_R, fiber_L) == 0
            break
        elseif i == n-1
            W(n,:) = w;
            C(n,:) = c;
            n = n + 1;
        end
    end
    n
end

%% Calculate rotation axis and angle
rotaxis_C = zeros(fiber_Num,3);
rotangle_C = zeros(fiber_Num,1);
for i = 1:fiber_Num
    rotaxis_C(i,:) = cross( W(i,:), [0, 0, 1] );
    rotangle_C(i) = acos( dot(W(i,:),[0, 0, 1]) ) * 180/pi;
end

%% plot all cylinders in the cell
for i = 1:fiber_Num
    [x,y,z] = cylinder(fiber_R, 100);
    x = x + C(i,1);
    y = y + C(i,2);
    z = (z-0.5) * fiber_L + C(i,3);
    handle = surf(x,y,z,'LineStyle','none'); axis square
    rotate(handle,rotaxis_C(i,:), rotangle_C(i), C(i,:));  %以C(i,:)为旋转中心
    hold on
end
axis([0 cell_L 0 cell_W 0 cell_H])