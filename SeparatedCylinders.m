function flag = SeparatedCylinders(C0, W0, r0, h0, C1, W1, r1, h1)
centerdistance = C0 - C1;
direction = cross(W0,W1);
direction = direction / norm(direction);
distance = norm(dot(centerdistance,direction));
%point0 = dot(centerdistance,W0);
%point1 = dot(centerdistance,W1);
t0 = dot(cross((C1-C0),W0),cross(W0,W1))/norm(cross(W0,W1));
t1 = dot(cross((C1-C0),W1),cross(W0,W1))/norm(cross(W0,W1));
%cen_to_point0 = norm(C0 - point0);
%cen_to_point1 = norm(C1 - point1);
if distance < (r0 + r1 +0.5) && (abs(t0) < 0.5 * h0 + 0.5 || abs(t1) < 0.5 * h1 + 0.5) 
    flag = false;
else
    flag = true;
end