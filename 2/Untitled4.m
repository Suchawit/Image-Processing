[M,N]=size(I);
new=I-I;
disp('***************Note:zero-padding method is used!***********');
disp('                                                           ');
kernel_size=input('enter the size of the kernel for the Median-ranking? 3 or 5 or 7 or 9=  ');
k=zeros(kernel_size);  %k is the kernel used. 
start=kernel_size-floor(kernel_size*0.5);
for x=start:1:M-floor(kernel_size*0.5)
for y=start:1:N-floor(kernel_size*0.5)

%defining x1 & y1 as the 1st coordinates in the kernel
x1=x-(floor(kernel_size*0.5));
y1=y-(floor(kernel_size*0.5));

%specifying image pixels to the kernel
for p=1:1:kernel_size
for q=1:1:kernel_size
 k(p,q)=I(x1+p-1,y1+q-1);
end    
end
d=reshape(k,1,[]);  %k values into an array d 
[r,c]=size(d);
%*****Ordering kernel members***************
for j=1:1:c-1
for i=1:1:c-1
    a=d(1,i);
    b=d(1,i+1);
    if(a>b)
     d(1,i)=b;
     d(1,i+1)=a;
    end
end  
end
Median=d(1,floor(kernel_size*kernel_size*0.5)+1);
  %*****************end of ordering***********
  %*******************************************

   new(x,y)=Median;    
end
end
subplot(1,2,1);
imshow(J);
subplot(1,2,2);
imshow(new);