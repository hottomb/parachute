clear all;
load dc2_pp.mat;

r=1.           %promien polczaszy spadochronu
g=9.81;         %przyciaganie ziemskie
Cd=0.45;        %wsp. oporu czaszy polsferycznej
Ro=1.168;       %gestosc powietrza
gram=0.035;
Sc=@(r)pi*r.^2;  %powierzchnia podstawy czaszy polsferycznej
Sf=@(r)2*pi*r.^2;
m_spad=@(r,gram)gram*Sf(r); %gramatura * polpowierzchnia sfery = masa czaszy
t_vel=@(m,r)sqrt(2*g*m'./(Cd*Ro*Sc(r))); %predkosc opadania

r1=1;
r2=6;
a=-2;
    R=linspace(-r2^(1/-a),-r1^(1/-a),10).^a;
    R=[0.7,0.8,R*r2];
    m_pay=0.0:0.05:10;
%     figure(1);
    Mx=NaN(2,1);My=Mx;
pos=[119,82,1009,707];
f1=figure(1);
set(f1,'Position',pos)
for i=1:length(R)
    r=R(i);
    vels=t_vel(m_pay+m_spad(r,gram),r);
%     plot(m_pay,vels,'DisplayName',['R[m]= ', num2str(r,'%10.1f') '      fabr.m[g]= ' num2str(round(m_spad(r,gram)*1000)) '  fab.surf.[m^2]= ' num2str(Sf(r),'%10.1f') ]);hold on;

    plot(m_pay,vels);
    hold on;
    leg{i}=sprintf('%s %4.2f %s %4.0f %s %4.1f','R[m]',r,'   fabr.m[g]',m_spad(r,gram)*1000,'   fabr.surf.[m^{2}]',Sf(r)) ;
    
    My(1:2)=[min([My(1);vels]);max([My(2);vels])];
    Mx(1:2)=[min([Mx(1);m_pay']),max([Mx(2);m_pay'])];
end

title({'Terminal velocity vs payload mass vs sph. parachute cross section surface', 'C_{0}=0.45; \rho_{0}=1.168kg/m^3; fabric grammage=35g/m^2   '});
xlabel('Payload + fabr.mass [kg]'); ylabel('Velocity [m/s]');
ylim([My(1) My(2)]); xlim([Mx(1) Mx(2)]);
% set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'XMinorGrid','on','YMinorGrid','on')
legend(leg,'Location','northwest');