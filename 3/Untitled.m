for j = -2:2
    for i = -2:2
        if(Etotal(j+3,i+3)) == min(Etotal(:))
            P(numbers_points,1) = P(numbers_points,1)+i;
            P(numbers_points,2) = P(numbers_points,2)+j;
            break
        end
    end
end