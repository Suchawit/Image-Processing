clear all
clc

% Minimization Parameters
alpha=0.2;
beta= 0.2;
gamma=0.1;
max_itr      = 100;
GaussWinSize = 5;
GradT        = 0.3;

% Loading the image and converting that to a grey-level image if needed
img = imread("CTImage.png");

% Denoising by Gaussian filter
I = imgaussfilt(img);

% Edge Detection using Sobel kernels
BW1 = edge(I,'sobel');
% Seed points selection
figure, imshow(img); [y,x] = getpts;
x = int16(x);
y = int16(y);
P=[x(:) y(:)];
[seed_number, ~] = size(x);
% optimization loop
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
                if isequal(numbers_points,1)
                    Pre_x = P(seed_number,1);
                    Pre_y = P(seed_number,2);
                else
                    Pre_x = P(numbers_points-1,1);
                    Pre_y = P(numbers_points-1,2);
                end
               % Econ(i+3,j+3) = uint8(sqrt((double(img(x,y) - img(next_x,next_y)))^2));
                Econx(i+3,j+3) = sqrt(double(x - next_x)^2);
                Econy(i+3,j+3) = sqrt(double(y - next_y)^2);
                Ecurvx(i+3,j+3) = sqrt(double(Pre_x +2*x - next_x)^2);
                Ecurvy(i+3,j+3) = sqrt(double(Pre_y +2*y - next_y)^2);
                Egrad(i+3,j+3) = BW1(x,y);
                %Etotal(i+3,j+3) = Econx(i+3,j+3)*alpha + Ecurvx(i+3,j+3)*beta - Egrad(i+3,j+3)*gamma;
            end   
        end
        %Normalize
        Econx = Econx/(max(Econx,[],[1 2 3 4 5])- min(Econx,[],[1 2 3 4 5]));
        Econy = Econy/(max(Econy,[],[1 2 3 4 5])- min(Econy,[],[1 2 3 4 5]));
        Ecurvx = Ecurvx/(max(Ecurvx,[],[1 2 3 4 5])- min(Ecurvx,[],[1 2 3 4 5]));
        Ecurvy = Ecurvy/(max(Ecurvy,[],[1 2 3 4 5])- min(Ecurvy,[],[1 2 3 4 5]));
        Egrad = Egrad/max(GradT,(max(Egrad,[],[1 2 3 4 5])- min(Egrad,[],[1 2 3 4 5])));
        Etotal = Econx*alpha + Ecurvx*beta - Egrad*gamma;
        
        NewP = double(P);
        [k,~] = convhull(NewP);
        plot(NewP(:,1),NewP(:,2),'*r')
        hold on
        plot(NewP(k,1),NewP(k,2))
    end
end