function samples = randomIC(a,b,N)
samples = a + (b-a) * rand(1,N);
end