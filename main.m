%main
%通过广义布尔函数产生2^m长度的PZCP
m=3;
q=2;
[F,G]=GDJ_GCP(m,q);



[F2,G2]=storage_in_matrix_pzcp(6,2,2);

connected_pzcp=connection_pzcp(F2,G2);