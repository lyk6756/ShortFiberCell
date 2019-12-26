angle = zeros(fiber_Num,2);
Cnew = zeros(fiber_Num,3);
for i=1:1:fiber_Num
    cos1 = acos(W(i,3) / sqrt(W(i,1) * W(i,1) + W(i,3) * W(i,3) )) * 180 / pi;
    sin1 = asin(W(i,1) / sqrt(W(i,1) * W(i,1) + W(i,3) * W(i,3) )) * 180 / pi;
    cos2 = acos(sqrt(W(i,1) * W(i,1) + W(i,3) * W(i,3) )) * 180 / pi;
    sin2 = asin(W(i,2)) * 180 / pi;
    C_new = C(i,:) - 4*W(i,:);
    if cos1 < 0
        cos1 = cos1 + 90;
    end
    if sin1 < 0
        cos1 = cos1 * -1;
    end
    if sin2 > 0
        cos2 = cos2 * -1;
    end
    angle(i,1) = cos1;
    angle(i,2) = cos2;
    Cnew(i,:) = C_new;
end
fid=fopen('D:\ansysdocument\ZWO-SIC-Al\location5.txt','wt');
for i=1:1:fiber_Num
    fprintf(fid,'WPCSYS,-1,0\nwpoff,%7.4f,%7.4f,%7.4f\nwpro,,,%7.4f\nwpro,,%7.4f\nCYL4,0,0,0.5, , , ,8\n',Cnew(i,1),Cnew(i,2),Cnew(i,3),angle(i,1),angle(i,2));
end
fprintf(fid,'\n');
%for i=1:1:fiber_Num
 %   fprintf(fid,'%4.3f\t',Y(i));
%end
fclose(fid);
