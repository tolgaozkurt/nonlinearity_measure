function [Rmean, Pmean, frq, Pmean2] = NormedSingleCurveLengthWindowed(x,winlen,shiftlen,lag,fs,nrmdegree)

% shiftlen is winlen - overlaplen

M = floor((length(x) - winlen) /  shiftlen ) + 1;

Psum = zeros(1,2*lag+1); 
Rsum = zeros(1,lag+1);


for ii=1:M 
    
    xseg = x((ii-1)*shiftlen+1:(ii-1)*shiftlen+winlen);
    

    [rx,px] = NormedSingleCurveLength(xseg,lag,fs,0, nrmdegree);
    
    Psum = Psum + px;
    
    Rsum = Rsum + rx;
    
    ii
end

Pmean = Psum ./ M;
Rmean = Rsum ./ M; 

Pmean2 = abs(fft([fliplr(Rmean) Rmean(2:end)]));


frq = linspace(0,0.5*fs,lag+1);