distance_everypointsx = 0;
distance_everypointsy = 0;
for ind = 1 : seed_number
    cx = P(ind,1);
    cy = P(ind,2);
    
    if ind == seed_number
        nx = P(1,1);
        ny = P(1,2);
    else
        nx = P(ind+1,1);
        ny = P(ind+1,2);
    end
    distance_onepointx = sqrt(double((cx - nx))^2);
    distance_onepointy = sqrt(double((cy - ny))^2);
    
    distance_everypointsx = distance_everypointsx+distance_onepointx;
    distance_everypointsy = distance_everypointsy+distance_onepointy;
end