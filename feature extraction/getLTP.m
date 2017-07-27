function [high,low,ternary]=getLTP(img,threshold)

   [rows,cols]=size(img);

   % case 'P8R2' % 8 pixels in a circle of radius 2

   % embed input matrix in a larger one, extending with zeros (trim a
   % 2 pixel border off of the output matrices if you don't like this)
   r=rows+4; 
   c=cols+4;
   A = zeros(r,c);
   r0=3:r-2;
   c0=3:c-2;
   A(r0,c0) = img;
   
   img = double(img);

   % radius 2 interpolation coefficients for +-45 degree lines
   alpha = 2-sqrt(2);
   beta = 1-alpha;

   % 8 directional derivative images
   d0 = A(r0,c0-2) - img;
   d2 = A(r0+2,c0) - img;
   d4 = A(r0,c0+2) - img;
   d6 = A(r0-2,c0) - img;
   d1 = alpha*A(r0+1,c0-1) + beta*A(r0+2,c0-2) - img;
   d3 = alpha*A(r0+1,c0+1) + beta*A(r0+2,c0+2) - img;
   d5 = alpha*A(r0-1,c0+1) + beta*A(r0-2,c0+2) - img;
   d7 = alpha*A(r0-1,c0-1) + beta*A(r0-2,c0-2) - img;

   % pack derivative images into a single matrix, one per column,
   % threshold and code to get output matrices
   d = [d0(:),d1(:),d2(:),d3(:),d4(:),d5(:),d6(:),d7(:)];
   code = 2.^(7:-1:0)';
   high = reshape((d>=threshold)*code,rows,cols);
   low = reshape((d<=-threshold)*code,rows,cols);
   if nargout>2
      code = 3.^(7:-1:0)';
      ternary = reshape((d>=threshold)*code+(d<=-threshold)*2*code,rows,cols);
   end 
%end;

