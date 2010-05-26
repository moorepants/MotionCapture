%     d2n2(i,1) = -((2*x(i,26)-x(i,22)-x(i,28))*(2*z(i,26)-z(i,25)-z(i,31))...
%         -(2*x(i,26)-x(i,25)-x(i,31))*(2*z(i,26)-z(i,22)-z(i,28)))/(((2*x...
%         (i,26)-x(i,22)-x(i,28))*(2*y(i,26)-y(i,25)-y(i,31))-(2*x(i,26)-x...
%         (i,25)-x(i,31))*(2*y(i,26)-y(i,22)-y(i,28)))^2+((2*x(i,26)-x(i,...
%         22)-x(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*x(i,26)-x(i,25)-...
%         x(i,31))*(2*z(i,26)-z(i,22)-z(i,28)))^2+((2*y(i,26)-y(i,22)-...
%         y(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*y(i,26)-y(i,25)-y(i,31))...
%         *(2*z(i,26)-z(i,22)-z(i,28)))^2)^0.5;
%     e2n2(i,1) = -(y(i,21)-y(i,27))/((x(i,21)-x(i,27))^2+(y(i,21)-y(i,27))^2+(z(i,21)-z(i,27))^2)^0.5;
%     d2e2(i,1) = ((y(i,21)-y(i,27))*((2*x(i,26)-x(i,22)-x(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*...
%         (2*z(i,26)-z(i,22)-z(i,28)))-(x(i,21)-x(i,27))*((2*y(i,26)-y(i,22)-y(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-...
%         (2*y(i,26)-y(i,25)-y(i,31))*(2*z(i,26)-z(i,22)-z(i,28)))-(z(i,21)-z(i,27))*((2*x(i,26)-x(i,22)-x(i,28))*...
%         (2*y(i,26)-y(i,25)-y(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*y(i,26)-y(i,22)-y(i,28))))/(((x(i,21)-x(i,27))^2+...
%         (y(i,21)-y(i,27))^2+(z(i,21)-z(i,27))^2)^0.5*(((2*x(i,26)-x(i,22)-x(i,28))*(2*y(i,26)-y(i,25)-y(i,31))-...
%         (2*x(i,26)-x(i,25)-x(i,31))*(2*y(i,26)-y(i,22)-y(i,28)))^2+((2*x(i,26)-x(i,22)-x(i,28))*(2*z(i,26)-z(i,25)-z(i,31))...
%         -(2*x(i,26)-x(i,25)-x(i,31))*(2*z(i,26)-z(i,22)-z(i,28)))^2+((2*y(i,26)-y(i,22)-y(i,28))*(2*z(i,26)-z(i,25)-z(i,31))...
%         -(2*y(i,26)-y(i,25)-y(i,31))*(2*z(i,26)-z(i,22)-z(i,28)))^2)^0.5);
%  d2e1(i,1) = (((2*x(i,26)-x(i,22-x(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*z(i,26)-z(i,22-z(i,28)))*...
%      ((x(i,21-x(i,27))*((x(i,21-x(i,27))*((2*x(i,26)-x(i,22-x(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*z(i,26)-z(i,22-...
%      z(i,28)))+(y(i,21-y(i,27))*((2*y(i,26)-y(i,22-y(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*y(i,26)-y(i,25)-y(i,31))*(2*z(i,26)-z(i,22-z(i,28))))...
%      +(z(i,21-z(i,27))*((y(i,21-y(i,27))*((2*x(i,26)-x(i,22-x(i,28))*(2*y(i,26)-y(i,25)-y(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*y(i,26)-...
%      y(i,22-y(i,28)))+(z(i,21-z(i,27))*((2*x(i,26)-x(i,22-x(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*z(i,26)-z(i,22-...
%      z(i,28)))))+((2*x(i,26)-x(i,22-x(i,28))*(2*y(i,26)-y(i,25)-y(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*y(i,26)-y(i,22-y(i,28)))*((y(i,21-...
%      y(i,27))*((y(i,21-y(i,27))*((2*x(i,26)-x(i,22-x(i,28))*(2*y(i,26)-y(i,25)-y(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*y(i,26)-y(i,22-y(i,28)))...
%      +(z(i,21-z(i,27))*((2*x(i,26)-x(i,22-x(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*z(i,26)-z(i,22-z(i,28))))+...
%      (x(i,21-x(i,27))*((x(i,21-x(i,27))*((2*x(i,26)-x(i,22-x(i,28))*(2*y(i,26)-y(i,25)-y(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*y(i,26)-y(i,22-...
%      y(i,28)))-(z(i,21-z(i,27))*((2*y(i,26)-y(i,22-y(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*y(i,26)-y(i,25)-y(i,31))*(2*z(i,26)-z(i,22-z(i,28)))))...
%      +((2*y(i,26)-y(i,22-y(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*y(i,26)-y(i,25)-y(i,31))*(2*z(i,26)-z(i,22-z(i,28)))*((y(i,21-y(i,27))*...
%      ((x(i,21-x(i,27))*((2*x(i,26)-x(i,22-x(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*z(i,26)-z(i,22-z(i,28)))+...
%      (y(i,21-y(i,27))*((2*y(i,26)-y(i,22-y(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*y(i,26)-y(i,25)-y(i,31))*(2*z(i,26)-z(i,22-z(i,28))))-(z(i,21-...
%      z(i,27))*((x(i,21-x(i,27))*((2*x(i,26)-x(i,22-x(i,28))*(2*y(i,26)-y(i,25)-y(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*y(i,26)-y(i,22-y(i,28)))...
%      -(z(i,21-z(i,27))*((2*y(i,26)-y(i,22-y(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*y(i,26)-y(i,25)-y(i,31))*(2*z(i,26)-z(i,22-z(i,28))))))/...
%      (((x(i,21-x(i,27))^2+(y(i,21-y(i,27))^2+(z(i,21-z(i,27))^2)*(((2*x(i,26)-x(i,22-x(i,28))*(2*y(i,26)-y(i,25)-y(i,31))-(2*x(i,26)-...
%      x(i,25)-x(i,31))*(2*y(i,26)-y(i,22-y(i,28)))^2+((2*x(i,26)-x(i,22-x(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*...
%      z(i,26)-z(i,22-z(i,28)))^2+((2*y(i,26)-y(i,22-y(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*y(i,26)-y(i,25)-y(i,31))*(2*z(i,26)-z(i,22-z(i,28)))^2)...
%      *((((x(i,21-x(i,27))*((2*x(i,26)-x(i,22-x(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*z(i,26)-z(i,22-z(i,28)))...
%      +(y(i,21-y(i,27))*((2*y(i,26)-y(i,22-y(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*y(i,26)-y(i,25)-y(i,31))*(2*z(i,26)-z(i,22-z(i,28))))^2+...
%      ((y(i,21-y(i,27))*((2*x(i,26)-x(i,22-x(i,28))*(2*y(i,26)-y(i,25)-y(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*y(i,26)-y(i,22-y(i,28)))+...
%      (z(i,21-z(i,27))*((2*x(i,26)-x(i,22-x(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*z(i,26)-z(i,22-z(i,28))))^2+...
%      ((x(i,21-x(i,27))*((2*x(i,26)-x(i,22-x(i,28))*(2*y(i,26)-y(i,25)-y(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*y(i,26)-y(i,22-y(i,28)))-(z(i,21...
%      -z(i,27))*((2*y(i,26)-y(i,22-y(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*y(i,26)-y(i,25)-y(i,31))*(2*z(i,26)-z(i,22-z(i,28))))^2)/(((...
%      x(i,21-x(i,27))^2+(y(i,21-y(i,27))^2+(z(i,21-z(i,27))^2)*(((2*x(i,26)-x(i,22-x(i,28))*(2*y(i,26)-y(i,25)-y(i,31))-(2*x(i,26)-x(i,25)-...
%      x(i,31))*(2*y(i,26)-y(i,22-y(i,28)))^2+((2*x(i,26)-x(i,22-x(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*x(i,26)-x(i,25)-x(i,31))*(2*z(i,26)-...
%      z(i,22-z(i,28)))^2+((2*y(i,26)-y(i,22-y(i,28))*(2*z(i,26)-z(i,25)-z(i,31))-(2*y(i,26)-y(i,25)-y(i,31))*(2*z(i,26)-z(i,22-z(i,28)))^2)))^0.5);
P_MO_M22=[x(i,22);y(i,22);z(i,22)];
P_MO_M28=[x(i,28);y(i,28);z(i,28)];
P_MO_M25=[x(i,25);y(i,25);z(i,25)];
P_MO_M31=[x(i,31);y(i,31);z(i,31)];

P_MO_M33=(P_MO_M22+P_MO_M28)/2; % HEADTUBE CENTER
P_MO_M36=(P_MO_M25+P_MO_M31)/2; % REAR WHEEL CENTER

x(i,33)=P_MO_M33(1);
y(i,33)=P_MO_M33(2);
z(i,33)=P_MO_M33(3);
x(i,36)=P_MO_M36(1);
y(i,36)=P_MO_M36(2);
z(i,36)=P_MO_M36(3);
%xd2(i,1:3) = ([x(i,25);-y(i,25);-z(i,25)]-[x(i,31);-y(i,31);-z(i,31)])';
xd2(i,1:3) = (cross([x(i,36);-y(i,36);-z(i,36)]-[x(i,26);-y(i,26);-z(i,26)],[x(i,33);-y(i,33);-z(i,33)]-[x(i,26);-y(i,26);-z(i,26)]))';
xd2(i,1:3) = xd2(i,1:3)/norm(xd2(i,1:3));

xe2(i,1:3) = ([x(i,21);-y(i,21);-z(i,21)]-[x(i,27);-y(i,27);-z(i,27)])';
xe2(i,1:3) = xe2(i,1:3)/norm(xe2(i,1:3));

xb1(i,1:3) = (cross(xd2(i,1:3)',[0;0;1]))';

signq7=-sign(dot(xe2(i,1:3)',xb1(i,1:3)'));

xe3(i,1:3) = signq7.*(cross(xd2(i,1:3)',xe2(i,1:3)'))';
xe3(i,1:3) = xe3(i,1:3)/norm(xe3(i,1:3));
xe1(i,1:3) = (cross(xe2(i,1:3)',xe3(i,1:3)'))';
d2e1(i,1) = dot(xd2(i,1:3)',xe1(i,1:3));