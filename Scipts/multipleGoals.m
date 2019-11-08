clear

% Goals
goals=[90, 50; 90, 110; 110, 80; 40, 110; 40, 135];

%%% Generating a MAP
%1 represent an object that the path cannot penetrate, zero is a free path
MAP=int8(zeros(128,140));
MAP(1:64,1)=1;
MAP(120,3:100)=1;
MAP(125:128,40:60)=1;
MAP(120:128,100:120)=1;
MAP(126,100:118)=0;
MAP(120:126,118)=0;
MAP(100:120,100)=1;
MAP(114:124,112:118)=0;
MAP(1,1:128)=1;
MAP(128,1:128)=1;
MAP(100,1:130)=1;
MAP(50,28:128)=1;
MAP(20:30,50)=1;
MAP(1:128,1)=1;
MAP(1:65,128)=1;
MAP(1,1:128)=1;
MAP(128,1:128)=1;
MAP(10,1:50)=1;
MAP(25,1:50)=1;
MAP(40,40:50)=1;
MAP(40,40:45)=1;
MAP(80,20:40)=1;
MAP(80:100,40)=1;
MAP(80:100,120)=1;
MAP(120:122,120:122)=1;
MAP(120:122,20:25)=1;
MAP(120:122,10:11)=1;
MAP(125:128,10:11)=1;
MAP(100:110,30:40)=1;
MAP(1:20,100:128)=1;
MAP(10:20,80:128)=1;
MAP(20:40,80:90)=1;
MAP(1:40,90:90)=1;
MAP(100:105,70:80)=1;

%Start Positions
StartX=15;
StartY=15;

Connecting_Distance=8; %Avoid to high values Connecting_Distances for reasonable runtimes. 

fullPath = [];

% Loop through goals
done = false;
while ~done
    % Add goals
    GoalRegister = int8(zeros(128, 140));
    for i = 1:size(goals, 1)
        GoalRegister(goals(i, 1), goals(i, 2)) = 1;
    end
    
    % Run PathFinder
    OptimalPath = ASTARPATH(StartX,StartY,MAP,GoalRegister,Connecting_Distance);

    % Concatenate new path to full path
    fullPath = [OptimalPath; fullPath];
    
    % Update start position with ending position
    StartX = OptimalPath(1, 2);
    StartY = OptimalPath(1, 1);
    
    % Remove end position from goals
    goals = setdiff(goals, OptimalPath(1, :), 'rows');
    
    % Done is true if goals is empty
    if isempty(goals)
        done = true;
    end
    
end

if size(fullPath,2)>1
figure(10)
imagesc((MAP))
    colormap(flipud(gray));

hold on
plot(fullPath(1,2),fullPath(1,1),'o','color','k')
plot(fullPath(end,2),fullPath(end,1),'o','color','b')
plot(fullPath(:,2),fullPath(:,1),'r')
legend('Goal','Start','Path')

else 
     pause(1);
 h=msgbox('Sorry, No path exists to the Target!','warn');
 uiwait(h,5);
 end









showNeighboors=0; %Set to 1 if you want to visualize how the possible directions of path. The code
%below are purley for illustrating purposes. 
if showNeighboors==1
%



%2
NeigboorCheck=[0 1 0 1 0;1 1 1 1 1;0 1 0 1 0;1 1 1 1 1;0 1 0 1 0]; %Heading has 16 possible allignments
[row col]=find(NeigboorCheck==1);
Neighboors=[row col]-(2+1);
figure(2)

for p=1:size(Neighboors,1)
  i=Neighboors(p,1);
       j=Neighboors(p,2);
      
     plot([0 i],[0 j],'k')
 hold on
 axis equal
 
grid on
title('Connecting distance=2')
end

%3
NeigboorCheck=[0 1 1 0 1 1 0;1 0 1 0 1 0 1;1 1 1 1 1 1 1;0 0 1 0 1 0 0;1 1 1 1 1 1 1;1 0 1 0 1 0 1;0 1 1 0 1 1 0]; %Heading has 32 possible allignments
figure(3)
[row col]=find(NeigboorCheck==1);
Neighboors=[row col]-(3+1);

for p=1:size(Neighboors,1)
  i=Neighboors(p,1);
       j=Neighboors(p,2);
      
     plot([0 i],[0 j],'k')
 hold on
 axis equal
 grid on
title('Connecting distance=3')

end
 
%4
NeigboorCheck=[0 1 1 1 0 1 1 1 0;1 0 1 1 0 1 1 0 1;1 1 0 1 0 1 0 1 1;1 1 1 1 1 1 1 1 1;0 0 0 1 0 1 0 0 0;1 1 1 1 1 1 1 1 1;1 1 0 1 0 1 0 1 1 ;1 0 1 1 0 1 1 0 1 ;0 1 1 1 0 1 1 1 0];  %Heading has 56 possible allignments
figure(4)
[row col]=find(NeigboorCheck==1);
Neighboors=[row col]-(4+1);

for p=1:size(Neighboors,1)
  i=Neighboors(p,1);
       j=Neighboors(p,2);
      
     plot([0 i],[0 j],'k')
 hold on
 axis equal
grid on
title('Connecting distance=4')

end
%1
NeigboorCheck=[1 1 1;1 0 1;1 1 1];
figure(1)
[row col]=find(NeigboorCheck==1);
Neighboors=[row col]-(1+1);

for p=1:size(Neighboors,1)
  i=Neighboors(p,1);
       j=Neighboors(p,2);
      
     plot([0 i],[0 j],'k')
 hold on
 axis equal
grid on
title('Connecting distance=1')

end
end
