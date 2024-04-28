%%水平并GCP
m=3;
q=4;
[F,G]=GDJ_GCP(m,q);
F=double(F);
G=double(G);
a=convert_to_complex(F(1,:),q);
b=convert_to_complex(G(1,:),q);
c=convert_to_complex(F(2,:),q);
d=convert_to_complex(G(2,:),q);

e=double([a,c,b,d]);
f=double([a,-c,b,-d]);

rxy=xcorr(e,f);
ryx=xcorr(f,e);
rxx=xcorr(e,e);
ryy=xcorr(f,f);
C1=abs(rxx+ryy);
C2=abs(rxy+ryx);
figure;
stem(C1)
figure;
stem(C2)