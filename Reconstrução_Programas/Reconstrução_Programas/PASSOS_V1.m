sl
lambda = 0.02;
y=radon(Fk,theta);
K = @(x)grad(x);
KS = @(x)-div(x);

Amplitude = @(u)sqrt(sum(u.^2,3));
F = @(u)lambda*sum(sum(Amplitude(u)));
G = @(x)1/2*norm(y-x,'fro')^2;

Normalize = @(u)u./repmat( max(Amplitude(u),1e-10), [1 1 2] );
ProxF = @(u,tau)repmat( perform_soft_thresholding(Amplitude(u),lambda*tau), [1 1 2]).*Normalize(u);
ProxFS = compute_dual_prox(ProxF);

ProxG = @(x,tau)(x+tau*y)/(1+tau);

options.report = @(x)G(x) + F(K(x));

options.niter = 300;
[xAdmm,EAdmm] = perform_admm(y, K,  KS, ProxFS, ProxG, options);
 P=iradon(gather(xAdmm),theta,'nearest','Hann',1);
 P(P<0)=0;
 SIRT_TV(:,:,sl)= P;

%% teste 
% 
% sl
% lambda = 0.02;
% y=radon(Fk,theta);
% K = @(x)grad(x);
% KS = @(x)-div(x);
% 
% Amplitude = @(u)sqrt(sum(u.^2,3));
% F = @(u)lambda*sum(sum(Amplitude(u)));
% G = @(x)1/2*norm(y-x,'fro')^2;
% 
% Normalize = @(u)u./repmat( max(Amplitude(u),1e-10), [1 1 2] );
% ProxF = @(u,tau)repmat( perform_soft_thresholding(Amplitude(u),lambda*tau), [1 1 2]).*Normalize(u);
% ProxFS = compute_dual_prox(ProxF);
% 
% ProxG = @(x,tau)(x+tau*y)/(1+tau);
% 
% options.report = @(x)G(x) + F(K(x));
% 
% options.niter = 300;
% [xAdmm,EAdmm] = perform_admm(y, K,  KS, ProxFS, ProxG, options);
%  s = size(imgPreProcess);
%  P=iradon(xAdmm,theta,'nearest','Hann',1,s(1));
%  % P = gather(P);
%  P(P<0)=0;
%  SIRT_TV(:,:,sl)= P;
% 