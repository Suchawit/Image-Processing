clear all
clc

% Minimization Parameters
alpha=0.2;
beta= 0.1;
gamma=0.3;
max_itr      = 100;
GaussWinSize = 5;
GradT        = 0.3;

% Loading the image and converting that to a grey-level image if needed

img = imread("CTImage.png");

% Denoising by Gaussian filter
h = fspecial('gaussian',GaussWinSize,0.5);
I = imfilter(img,h,'replicate');
%I = imgaussfilt(img);

% Edge Detection using Sobel kernels
Sobely = fspecial('sobel');
Sobelx = transpose(Sobely);
Gy = imfilter(I,Sobely,'replicate');
Gx = imfilter(I,Sobelx,'replicate');
Gxy = Gy.^2 + Gx.^2;
%BW1 = edge(I,'sobel');
%Gxyn = Gx + Gy;

% Seed points selection
figure, imshow(I); [x1,y1] = getpts;
hold on
x = int16(x1);
y = int16(y1);


P=[x(:) y(:)];
%P = P1;
[seed_number, ~] = size(x);
points_number = seed_number;
% optimization loop
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
for iter = 1:max_itr
    for numbers_points = 1:seed_number
        for j = -2:2
            for i = -2:2
                x = P(numbers_points,1) + i; % optimizing each value of current pixel
                y = P(numbers_points,2) + j;
                if numbers_points == seed_number
                    next_x = P(1,1);
                    next_y = P(1,2);
                else
                    next_x = P(numbers_points+1,1);
                    next_y = P(numbers_points+1,2);
                end
                if numbers_points == 1
                    Pre_x = P(seed_number,1);
                    Pre_y = P(seed_number,2);
                else
                    Pre_x = P(numbers_points-1,1);
                    Pre_y = P(numbers_points-1,2);
                end

                
               % Econ(i+3,j+3) = uint8(sqrt((double(img(x,y) - img(next_x,next_y)))^2));
                Econx(j+3,i+3) = distance_everypointsx + sqrt(double(x - next_x)^2) + sqrt(double(x - Pre_x)^2) - sqrt(double(P(numbers_points,1) - next_x)^2)- sqrt(double(P(numbers_points,1) - Pre_x)^2);
                Econy(j+3,i+3) = distance_everypointsy + sqrt(double(y - next_y)^2) + sqrt(double(y - Pre_y)^2) - sqrt(double(P(numbers_points,2) - next_y)^2)- sqrt(double(P(numbers_points,2) - Pre_y)^2);
                Ecurvx(j+3,i+3) = sqrt(double(next_x -2*x + Pre_x)^2);
                Ecurvy(j+3,i+3) = sqrt(double(next_y -2*y + Pre_y)^2);
                Egrad(j+3,i+3) = Gxy(x,y);
                %Etotal(i+3,j+3) = Econx(i+3,j+3)*alpha + Ecurvx(i+3,j+3)*beta - Egrad(i+3,j+3)*gamma;
            end   
        end
        %Normalize
        if max(Econx,[],[1 2 3 4 5]) == min(Econx,[],[1 2 3 4 5])
            Econx = 0;
        else
            Econx = Econx/(max(Econx,[],[1 2 3 4 5])- min(Econx,[],[1 2 3 4 5]));
        end
        
        if max(Econy,[],[1 2 3 4 5]) == min(Econy,[],[1 2 3 4 5])
            Econy = 0;
        else 
            Econy = Econy/(max(Econy,[],[1 2 3 4 5])- min(Econy,[],[1 2 3 4 5]));
        end
        Econ = Econx + Econy;
  
        Ecurvx = Ecurvx/(max(Ecurvx,[],[1 2 3 4 5])- min(Ecurvx,[],[1 2 3 4 5]));
        Ecurvy = Ecurvy/(max(Ecurvy,[],[1 2 3 4 5])- min(Ecurvy,[],[1 2 3 4 5]));
        Ecurv = Ecurvx+Ecurvy;
        Egrad = Egrad/max(GradT,(max(Egrad,[],[1 2 3 4 5])- min(Egrad,[],[1 2 3 4 5])));
        Etotal = 0.5*(Econ*alpha + Ecurv*beta) + (double(Egrad)*gamma);
        %update P
        for j = -2:2
            for i = -2:2
                if(min(Etotal(:)) == Etotal(j+3,i+3))
                    P(numbers_points,1) = P(numbers_points,1)+i;
                    P(numbers_points,2) = P(numbers_points,2)+j;
                    break;
                end
            end
        end
       P = double(P)
       [k,~] = convhull(P);
       plot(P(:,1),P(:,2),'-r')
       plot(P(k,1),P(k,2))
       pause(0.01)

    end
end
hold off
hold on
imshow(I)
P = double(P);
[k,~] = convhull(P);
plot(P(:,1),P(:,2),'-r')
plot(P(k,1),P(k,2))
hold off