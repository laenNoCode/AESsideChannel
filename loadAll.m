file = fopen("plaintext.txt");
plaintext = fscanf(file,"%2X", [16,300]);
fclose(file);

file = fopen("sbox.txt");
sbox = fscanf(file,"%d",[256]);
fclose(file);


for i = 1:300
   data(i) = load("data/" + i + ".mat"); 
end
    