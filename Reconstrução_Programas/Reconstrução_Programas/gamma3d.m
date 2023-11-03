function [resul,pp,aprovados] = gamma3d(A,B,R,D,RE1,RE2,RE3)

% A= matriz 3D 
% B= matriz 3D
%%%% se for usado algum threshold, os pontos eliminados tem q ter valores -1
% R= critério dose máxima aceitável
% D= critério distância de aceitação(DTA)
% RE1= resolução dos pixels horizontalmente
% RE2= resolução dos pixels verticalmente
% RE3= espassamento entre as imagens

%disp('Entre com o parâmetro multiplicador de distância para modificar o tamanho da área varrida.');
%H= input('Sabendo que quanto maior este número maior será a área percorrida: ');

%disp('Qual tipo de normalização deve-se ser feita?');
%disp('Digite 1 para normalizar pelo valor máximo.');
%disp('Digite 2 para normalizar pelo valor correspondente na posição central.');
%disp('Digite 3 para normalizar por qualquer ponto a sua escolha!!');
%disp('Digite 4 para não normalizar!!');
%Norm= input('Digite sua opção: ');

H=30; %mas já usei até 3 e deu a mesma coisa

A=double(A);
B=double(B);

[N1,N2,N3]=size(A);

G=[];
resul=ones(size(A)).*-1; 
resulh=[];
aprovados=[];

jj=1;
kk=0;

for z=1 :1 :N3
for m=1 :1 :N1
    for n=1 :1 :N2
        
        validador=A(m,n,z);
         
        if validador ~= -1
       
        maux=[]; 
        ii=1;
        
        for r=z-(round(H*D)) :1 :z+(round(H*D))
        for p=m-(round(H*D)) :1 :m+(round(H*D))
        for q=n-(round(H*D)) :1 :n+(round(H*D))
        
         
          %for r=1 :1 :N3      
          %for p=1 :1 :N1
          %for q=1 :1 :N2
                                 
                if 0<p && p<(N1+1) && 0<q && q<(N2+1) && 0<r && r<(N3+1)
                                                         
                if m==p 
                    %df= RE1 *(n-q);
                    df= sqrt(((RE1 *(n-q))^2)+((RE3*(z-r))^2));
                end 
                    
                if n==q
                    %df= RE2 *(m-p);
                    df= sqrt(((RE2 *(m-p))^2)+((RE3*(z-r))^2));
                end 
                    
                if (m ~= p) && (n ~= q);
                    %df= sqrt(((RE1 *(n-q))^2)+((RE2*(m-p))^2));
                    df= sqrt(((sqrt(((RE1*(n-q))^2)+((RE2*(m-p))^2)))^2)+((RE3*(z-r))^2));
                end
                                  
                rc= A(m,n,z);
                rm= B(p,q,r);
                rf=rc-rm;
                G= sqrt( ((df^2)/(D^2)) + ((rf^2)/(R^2)) );
                                              
                maux(ii)=G;  
             
                ii=ii+1;
               
                end
                   
            % end
         % end
         %end
        end % for r
        end % for p
        end % for q
        
        
       % isempty(maux)
%        maux
%        min(maux)
%        pause
       
        resul(m,n,z) = min(maux);
        
%         resulh(jj,z) = resul(m,n);
%         jj=jj+1;
%         
%         if resul(m,n,z)<=1
%              kk=kk+1;
%         end
        end % if
    end % for n
end % for m

qq=find(resul(:,:,z)==-1);
ww=find(resul(:,:,z)<=1 & resul(:,:,z)>=0);
total=N1*N2-length(qq);
porc_aprovada=length(ww)/total*100;
aprovados=[aprovados porc_aprovada];


figure; 
subplot(1,3,1); imagesc(A(:,:,z)),title('TPS'),colorbar; 
subplot(1,3,2); imagesc(B(:,:,z)),title('GEL'),colorbar
subplot(1,3,3); imagesc(resul(:,:,z)); title('Gamma'),colorbar, title(num2str(porc_aprovada)); 



end % for z


xx=find(resul<=1 & resul>=0);
yy=find(resul==-1);
%pt1=length(find(A(:,:,:)~=-1))
pt=N1*N2*N3-(length(yy));
pp=((length(xx))*100)/pt;
    
%figure;
%hist(resulh);

%figure;
%imagesc(resul);

msgbox(['O percentual de pontos aprovados é de ' num2str(pp) '%']);

