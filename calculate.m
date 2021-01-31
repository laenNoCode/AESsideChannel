loadAll
maxi = zeros(16,3);
for keyToFind = 1:16
firstround = zeros(256,300);
for i = 0:255% hypothèse de clef
    for j = 1:300%pour chaque texte chiffré
        %calcul du chiffré
        tmp = plaintext(keyToFind,j);
        tmp = bitxor(tmp,i);
        tmp = sbox(tmp + 1);
        %calcul du poid de hamming du chiffre
        hamming = 0;
        for k = 1:8
            if (mod(tmp,2) == 1)
               hamming = hamming + 1;
               tmp = tmp - 1;
            end
            tmp = tmp / 2;
        end
        firstround(i+1,j) = hamming;
    end
end
realFirstRound = zeros(300,1);
max = 0
correlationmax = zeros(256,1);
icorr = zeros(256,1);
figure
hold on

for l=1:5000%pour chaque position de point acquis
    foundmax = false;% on cherche la meilleure corellation
    for i = 1:300%pour chaque chiffré
        realFirstRound(i) = data(i).A(l);%valeur mesurée pour ce point
    end

    correlation = zeros(256,1);
    for i=1:256
        %point ou la corellation a été effectuée
        coefs = corrcoef(realFirstRound, firstround(i,:));%calcul de la corellation
        if (coefs(3) > max)%on a trouvé une meilleur corellation
            max = coefs(3)%on récupère la valeur de la corellation
            maxi(keyToFind,1) = i-1;
            maxi(keyToFind,2) = coefs(3);
            maxi(keyToFind,3) = l;
            foundmax = true
        end
        correlation(i) = coefs(3);
    end
   if (foundmax)
       correlationmax = correlation;
       l
   end
end
plot ( correlationmax)
end
