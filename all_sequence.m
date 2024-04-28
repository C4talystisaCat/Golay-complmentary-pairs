function [ S ] = all_sequence( m,q )
% 所有长度为m的q元序列
% 2020年7月3日18:25:36
n = q^m-1;
S = int8(dec2base([0:n],q,m)-48);
S(S>9) = S(S>9)-7;
S = S(:,end:-1:1);
end