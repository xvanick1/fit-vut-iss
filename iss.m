% 1.------
[Y,Fs] = audioread('xvanic09.wav'); 
Ybackup=Y;
Y=Y';
len=length(Y);
t=(len/Fs);
% 2.------
X = fft(Y);
X = abs(X(1:8001));
plot(X); xlabel('frequency [Hz]');
% 3.------
MaxMod=find(max(X)==X);
% 4.------
O=[0.2324 -0.4112 0.2324];
X=[1 0.2289 0.4662];
zplane(roots(O),roots(X));
% 5.------
H = freqz(O,X,256);
fnew=(0:255) / 256 * Fs / 2;
plot (fnew,abs(H)); xlabel('frequency [Hz]'); grid; ylabel('|H(f)|');
% 6.------
Xfilt = filter(O,X,Y);
Xfilt = fft(Xfilt);
Xfilt = abs(Xfilt(1:8001));
plot(Xfilt); xlabel('frequency [Hz]');
% 7.------
MaxModFilt=find(max(Xfilt)==Xfilt);
% 8.------
a = [1 1 -1 -1];
a = repmat(a, 1, 80);
[rcoef, lags] = xcorr(Y,a);
[~,I] = find(max(rcoef)==(rcoef));
lagDiff = lags(I);
timeDiff = lagDiff/Fs;
% 9.------
Rv=xcorr(Y,'biased');
k=[-Fs+1:Fs-1];
plot(k,Rv); xlabel('k'); ylabel('R[k]');
xlim([-50 50]);
% 10.------
R10 = find(k==10);
R10 = Rv(R10);
% 11.------
N=50;
minX=min(Ybackup);
maxX=max(Ybackup);
minX=min(minX);
maxX=max(maxX);
mtx=zeros(10,1);
x = linspace(minX,maxX,N);
y1 = cat(1,Ybackup,mtx);
y2 = cat(1,mtx,Ybackup);

[h,p,r] = hist2(y1,y2,x);
imagesc(X,X,p);
% 12.------
%Checked by calling hist2 in task 11.
%check -- 2d integral should be 1 and is 1
% 13.------
% TBD


