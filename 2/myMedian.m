function denoised = myMedian(img,wsize)
[M,N]=size(img);
denoised=img-img;
k=zeros(wsize);  %K = wsize*wsize size 
start=wsize-floor(wsize*0.5);
for x=start:1:M-floor(wsize*0.5)
for y=start:1:N-floor(wsize*0.5)
x1=x-(floor(wsize*0.5));
y1=y-(floor(wsize*0.5));

%specifying image pixels to the kernel
for p=1:1:wsize
for q=1:1:wsize
 k(p,q)=img(x1+p-1,y1+q-1);
end    
end
d=reshape(k,1,[]);  %turns into an array d 
[r,c]=size(d);
%Ordering kernel members
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
Median=d(1,floor(wsize*wsize*0.5)+1);
   denoised(x,y)=Median; 
end
end

end

