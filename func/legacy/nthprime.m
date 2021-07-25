function pN = nthprime(N,opmode)
% nthprime: The sequence of primes, generates the n'th prime P(N), or tells how many primes are <= a given number P
% usage: pN = nthprime(N)
% usage: pN = nthprime(N,opmode)
%
% Generates the N'th prime for a given N, or if requested,
% for a given prime P, it tells you the number (count) of
% all primes that are no larger than N.
%
% Uses an augmented prime sieve scheme, which along
% with a moderately sized database, generates the N'th
% prime efficiently for primes no larger than 2^32.
% (Actually, the data base allows you to go just
% slightly beyond that point. In fact, the largest
% prime less than 2^32 is 4294967291. That is prime
% #203280221 on the complete list of all primes.)
%
% arguments: (input)
%  N  - Positive integer. May be a vector or array,
%       in which case the N'th prime will be generated
%       for each element of N.
%
%       Depending upon the value of opmode, the maximum
%       value allowed for N is:
%
%       opmode = 0: N <= 203542528
%       opmode = 1: N <= 4300784963
%
%       Thus we can find the index of no prime larger
%       than 4300784963 (roughly 2^32), and nor can
%       we return a prime larger than 4300784963.
%
%  opmode - (OPTIONAL) Boolean flag - Specifies the way
%       nthprime works.
%
%       opmode == 0 --> (The default) - for a given N
%           return the N'th prime P(N)
%
%       opmode == 1 --> for a given number P, return
%           the index of that prime in the sequence
%           of all prime numbers P(N). If P is not prime,
%           then it returns numel(primes(P)) as the result,
%           but for large P, that computation might be
%           very expensive.
%
%       DEFAULT: 0
%
% arguments: (output)
%  pN - array of primes, of the same size as N, that
%       contains the N'th prime for each element of N.
%
% Example:
% % Find the primes #[1 10 100 1000 10000 100000 1000000 10000000 100000000]
%
% p = nthprime([1 10 100 1000 10000 100000 1000000 10000000 100000000])
% % p =
% %    2  29  541  7919  104729  1299709  15485863  179424673  2038074743
%
% Example:
% % Note that while nthprime is not as fast as the primes
% % function for small numbers, it is efficient for large N.
% % For example, there are 7603553 primes less than 2^27,
% % but computing the entire list of those primes can be
% % a large task. If for some reason, you only wanted to
% % know the last prime on that list, the cost of calling
% % nthprime is far less than the time to compute the entire
% % list.
%
% tic,p = primes(2^27);toc
% % Elapsed time is 4.517565 seconds.
%
% tic,plast = nthprime(numel(p));toc
% % Elapsed time is 0.003868 seconds.
%
% % plast =
% %    134217689
%
% Example:
% % How many primes are less than 1e9?
%
% nthprime(1e9,1)
% % ans =
% %     50847534
%
%
% See also: primes, nextprime, factor
%
% 
% Author: John D'Errico
% e-mail: woodchips@rochester.rr.com
% Release: 1.0
% Release date: 3/23/2010

% simple error checks
if (nargin < 1)
  help nthprime
  return
elseif isempty(N)
  % empty input begets empty output
  pN = [];
  return
elseif nargin > 2
  error('NTHPRIME:improperarguments', ...
    'Exactly one or two arguments are required')
end

if (nargin < 2) || isempty(opmode)
  % default is 0, to compute the N'th prime for a given N
  opmode = 0;
elseif ~ismember(opmode,[0 1])
  error('NTHPRIME:improperopmode', ...
    'opmode must be either 0 or 1 if supplied.')
end

% the upper limit for N will depend on the value of opmode
switch opmode
  case 0
    % forward mode - given N, find P
    
    % verify that N is positive integer, no larger than 203542528
    pN = zeros(size(N));
    N = N(:);
    if any(N <= 0) || any(round(N) ~= N) || any(N > 203542528)
      error('NTHPRIME:improperN','N must be integer, 1 <= N <= 203542528')
    end
  case 1
    % inverse mode - given P, find N
    
    % verify that N is positive integer, no larger than 4300784963
    pN = nan(size(N));
    N = N(:);
    if any(N <= 0) || any(N > 4300784963)
      error('NTHPRIME:improperN','N must be 1 <= N <= 4300784963')
    end
    
end

% bring in the primes database, as a persistent variable
persistent PrimesDataBase %#ok
if isempty(PrimesDataBase)
  load('PrimesDataBase.mat')
end

% whichmode do we operate in?
switch opmode
  case 0
    % compute the N'th prime for a given N
    
    % Is N <= 65536?
    k = (N <= PrimesDataBase.nlookup);
    if any(k)
      pN(k) = PrimesDataBase.lookup1(N(k));
    end
    k = find(~k);
    
    % For the other values of N > 65536, we need to search.
    nbinbounds = numel(PrimesDataBase.lookup2);
    bins = PrimesDataBase.nlookup + (0:nbinbounds)*PrimesDataBase.blocksize;
    
    % loop over the elements of N that are greater than 65536
    for i = 1:numel(k)
      ki = k(i);
      
      % is this prime actually in the list?
      if mod(N(ki) - bins(1),PrimesDataBase.blocksize) == 0
        pN(ki) = PrimesDataBase.lookup2(1 + (N(ki) - bins(1))/PrimesDataBase.blocksize);
      else
        % not in the list, so get lower and upper bounds on
        % the requested prime.
        pind = 1 + floor((N(ki) - bins(1))/PrimesDataBase.blocksize);
        plb = PrimesDataBase.lookup2(pind) + 2;
        pub = PrimesDataBase.lookup2(pind + 1) - 2;
        
        % get the potential prime factors that we need
        % to use for the sieve. We need only go as high as
        % floor(sqrt(pub))
        maxfac= floor(sqrt(pub));
        sievefacs = PrimesDataBase.lookup1(PrimesDataBase.lookup1 <= maxfac);
        
        % execute the sieve
        sieve = true(1,pub - plb + 1);
        startindex = 1 + mod(-plb,sievefacs);
        for j = 1:numel(sievefacs)
          sieve(startindex(j):sievefacs(j):end) = false;
        end
        % all the primes in that interval found by the sieve
        plist = plb + find(sieve) - 1;
        
        pN(ki) = plist(N(ki) - bins(pind));
      end % if mod(N(ki) - bins(1),PrimesDataBase.blocksize) == 0
      
    end % for i = 1:numel(k)
    
  case 1
    % for a given number P, how many primes are there
    % that are no larger than P? Essentially an inverse
    % problem.
    P = N;
    
    % Is P <= 821641? This is the largest prime that has
    % been stored in the list of the first 65536 primes.
    k = (P <= PrimesDataBase.lookup1(end));
    if any(k)
      % note that while I could use ~ notation here, this
      % will fail on older releases.
      [junk,pN(k)] = histc(N(k),PrimesDataBase.lookup1); %#ok
    end
    k = find(~k);
    
    % For the other values of P > 821641, we need to search.
    % (I could have used ~ notation here, but that would
    % fail on older MATLAB releases.)
    [junk,binindex] = histc(P(k),PrimesDataBase.lookup2); %#ok
    Nlb = PrimesDataBase.nlookup + (binindex - 1)*PrimesDataBase.blocksize;
    plb = PrimesDataBase.lookup2(binindex)+2;
    pub = PrimesDataBase.lookup2(min(binindex + 1,numel(PrimesDataBase.lookup2))) - 2;
    
    % loop over the elements of N that are greater than 821641
    for i = 1:numel(k)
      ki = k(i);
      Pk = P(ki);
      
      % is this number actually in the list of primes?
      if (Pk == Nlb(i))
        pN(ki) = Nlb(i);
      else
        % not in the list
        
        % get the potential prime factors that we need
        % to use for the sieve. We need only go as high as
        % floor(sqrt(pub(i)))
        maxfac = floor(sqrt(pub(i)));
        
        % we already have the small primes generated
        sievefacs = PrimesDataBase.lookup1(PrimesDataBase.lookup1 <= maxfac);
        
        % execute the sieve
        sieve = true(1,pub(i) - plb(i) + 1);
        startindex = 1 + mod(-plb(i),sievefacs);
        for j = 1:numel(sievefacs)
          sieve(startindex(j):sievefacs(j):end) = false;
        end
        % all the primes in that interval found by the sieve
        plist = plb + find(sieve) - 1;
        
        pN(ki) = Nlb(i) + sum(plist <= Pk);
      end % (Pk == Nlb(i))
      
    end % for i = 1:numel(k)
    
end % switch opmode
    
end % end mainline

%{

% ================================================
% The following code was that which built the
% n'th prime database, essentially recording every
% k'th prime (for k = 4096.)
% ================================================

%% build nth prime database
% First, get the first 65536 primes
clear
clc
pmill = primes(1000000);
PrimesDataBase.nlookup = 2^16;
PrimesDataBase.lookup1 = pmill(1:PrimesDataBase.nlookup);

%% After that point, get blocks of 2^12 = 4096 primes
PrimesDataBase.blocksize = 4096;
Nblocksize = 1e7;
N0 = PrimesDataBase.lookup1(end) + 2;
Nfin = N0 + Nblocksize;
Nmax = 2^32;
plist = [];

% growdata2 is used here to grow the list of
% primes found. growdata2 is found on the FEX.
growingprimetable = growdata2;
growingprimetable(PrimesDataBase.lookup1(end))
while N0 < Nmax
  % When done, true where the corresponding index is prime
  % A simple prime seive.
  isp = true(1,Nfin - N0 + 1);
  
  % Now find the primes between N0 and Nfin
  % We will need the potential prime factors.
  % None larger than sqrt(p) need be checked.
  % Note that N0 must always be larger than
  % pfacs(end), from the way they are
  % constructed.
  pfacs = primes(ceil(sqrt(Nfin)));
  
  startindex = 1 + mod(-N0,pfacs);
  for i = 1:numel(pfacs)
    isp(startindex(i):pfacs(i):end) = false;
  end
  
  plist = [plist,N0 + find(isp) - 1];
  if numel(plist >= PrimesDataBase.blocksize)
    pindex = plist(PrimesDataBase.blocksize:PrimesDataBase.blocksize:end);
    plist(1:(floor(numel(plist)/PrimesDataBase.blocksize)*PrimesDataBase.blocksize)) = [];
    
    % accumulate the primes that we have found
    growingprimetable(pindex(:))
  end
  
  N0 = Nfin + 2;
  Nfin = N0 + Nblocksize;
  
end
PrimesDataBase.lookup2 = growingprimetable();

save PrimesDataBase PrimesDataBase

end

%}


