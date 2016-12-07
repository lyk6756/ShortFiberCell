function flag = isSeparatedCylinders(C0, W0, r0, h0, C1, W1, r1, h1)
% flag = isSeparatedCylinders(C0, W0, r0, h0, C1, W1, r1, h1)
% judge two cylinders with centroid C, central axis W, radius r, length h 
% are separated cylinders. 'flag = True' for separate.
% User m functions called:
%     constrD.m

Delta = C1 - C0;
P0 = eye(3) - W0'*W0;
P1 = eye(3) - W1'*W1;

f = @(D) r0*norm(P0*D') + r1*norm(P1*D') + h0/2*norm(dot(D, W0)) + h1/2*norm(dot(D, W1)) - norm(dot(D, Delta));
D0 = [1 0 0];
A = [];
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
nonlcon = @constrD;
[~, fmin] = fmincon(f,D0,A,b,Aeq,beq,lb,ub,nonlcon);

if fmin > 0
    flag = false;
else
    flag = true;
end