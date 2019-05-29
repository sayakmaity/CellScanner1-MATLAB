
CellNum=1;
progLen=301;

areas=zeros(2,1);
centroids=zeros(2,2);
orientations=zeros(2,1);
fullVelocityMatrix=[];
tempAreaMatrix=[];
velMatrix=zeros(1,20);
areaMatrix=[];
RGBmap=[];
RGBclassifyMatrix=[];
tempRGBclassifyMatrix1=[];


color1=0;
Cell1Velocity=[];
Cell1Eccen=[];

Cell1EqDia=[];

Cell1Color=[];

for index=1:progLen
    centroids2=centroids;
    areas2=areas;
%Enter name of video to be analyzed below
I = imread('Video45.tif',index);
ColorMap = zeros(size(I));

for idx=1:(size(I,1))

    for idy=1:(size(I,2))
      
        if I(idx,idy,2)>I(idx,idy,3)&&I(idx,idy,2)>I(idx,idy,1)
            ColorMap(idx,idy,2)=1;
        end
        
        if I(idx,idy,3)>I(idx,idy,2)&&I(idx,idy,3)>I(idx,idy,1)
            ColorMap(idx,idy,3)=1;
        end
        
        if I(idx,idy,1)>I(idx,idy,2)&&I(idx,idy,1)>I(idx,idy,3)
            ColorMap(idx,idy,1)=1;
        end  
    end
end




BinaryMap=imadd(ColorMap(:,:,1),ColorMap(:,:,2));
BinaryMap=imadd(BinaryMap,ColorMap(:,:,3));


BinaryMap=imfill(BinaryMap, 'holes');
BinaryMapE=vertcat(BinaryMap);


ColorMapR=regionfill(ColorMap(:,:,1),BinaryMapE);
ColorMapRm=imfill(ColorMapR);
ColorMapG=regionfill(ColorMap(:,:,2),BinaryMapE);
ColorMapGm=imfill(ColorMapG);
ColorMapB=regionfill(ColorMap(:,:,3),BinaryMapE);
ColorMapBm=imfill(ColorMapB);

RGBmap(:,:,1)=ColorMapRm;
RGBmap(:,:,2)=ColorMapGm;
RGBmap(:,:,3)=ColorMapBm;

centroids2=centroids;

disp(num2str(index))

BinaryMapF=imclearborder(BinaryMapE,4);
BinaryMapE=BinaryMapF;
figure(1);
imshow(BinaryMapE)
Ilabel = bwlabel(BinaryMapE);
s = regionprops(Ilabel,'centroid');
centroids = cat(1, s.Centroid);

s2 = regionprops(Ilabel,'area');
areas=cat(1, s2.Area);



s4 = regionprops(Ilabel, 'eccentricity');
eccentricities=cat(1,s4.Eccentricity);

s5 = regionprops(Ilabel, 'equivdiameter');
eqivdiameter=cat(1,s5.EquivDiameter);

disp(eccentricities)
Cell1Eccen=[Cell1Eccen,eccentricities(1,1)];

centroids3=zeros(1,1);
areas3=zeros(2,1);
centroids3=centroids3+centroids-centroids2;
areas3=areas;

velocity1=sqrt(centroids3(1,1)^2+centroids3(1,2)^2);
disp(strcat("Velocity1 : ",num2str(velocity1)))
disp(strcat("Area1 ",num2str(areas3(1))));
Cell1Velocity=[Cell1Velocity,velocity1];

warning('off');

fullVelocityMatrix=[fullVelocityMatrix,velocity1(1,1)];


tempAreaMatrix=[tempAreaMatrix,areas3(1,1)];
tempRGBclassifyMatrix1=impixel(RGBmap,centroids(1,1),centroids(1,2));
sx=size(centroids);
if sx(1)>1
    disp('two');
end

        if tempRGBclassifyMatrix1(1,1,1)>tempRGBclassifyMatrix1(1,2,1)&&tempRGBclassifyMatrix1(1,1,1)>tempRGBclassifyMatrix1(1,3,1)
            color1=1;
        end
        
        
        
        if tempRGBclassifyMatrix1(1,2,1)>tempRGBclassifyMatrix1(1,1,1)&&tempRGBclassifyMatrix1(1,2,1)>tempRGBclassifyMatrix1(1,3,1)
            color1=2;
        end
        
        
      
        
        if tempRGBclassifyMatrix1(1,3,1)>tempRGBclassifyMatrix1(1,2,1)&&tempRGBclassifyMatrix1(1,3,1)>tempRGBclassifyMatrix1(1,1,1)
            color1=3;
        end
        
end

Cell1Color=[Cell1Color,color1];

RGBclassifyMatrix=[RGBclassifyMatrix,color1];

sizeAM=size(tempAreaMatrix);

var=1;
for idx=1:sizeAM(1)*sizeAM(2)
   
  
areaMatrix=[areaMatrix,tempAreaMatrix(uint8(var),uint8(mod(idx,sizeAM(2))+1))];
end


var2=1;
for idx=1:sizeAM(1)*sizeAM(2)
    if(mod(idx,2)==0)
        var2=1;
    else 
        var2=2;
    end
    
end

x=size(RGBclassifyMatrix);
natural=1:540;
close all;



Cell1Area=tempAreaMatrix(1:progLen);


