function [ HR, windim, xplotline, yplotline ] = entrogram_comp( field, xdim, ydim, xscale, yscale, xflag, yflag )
% Entrogram 2D Computation
%   Feed in a 2D binary matrix and calculate entrogram
%   Minimum window size is 2x2 cells

% default scaling factors if not specified
if nargin < 4
    xscale = 1;
    yscale = 1;
end

% default flags if not specified
if nargin < 6
    xflag = 0;
    yflag = 0;
end

[a b] = size(field);

xscale = 1/xscale;   % scaling factor for x dimension
zscale = 1/yscale;   % scaling factor for vertical direction

%% Compute global entropy
[L1 L2] = size(field);
ncells = L1*L2;
facies_one = sum(sum(field))/ncells;
facies_two = 1-facies_one;
if facies_one == 0 || facies_two == 0
    HG = 0;
else
    HG = - (facies_one*log(facies_one) + facies_two*log(facies_two));
end

%% Compute Local Entropies over different window sizes then get HR for each

for winsize = 1:(min(a,b)-1)
    
    if yflag == 0
        zlen = floor(winsize*zscale);
    else
        zlen = 1;
    end
    
    if xflag == 0
        xlen = floor(winsize*xscale);
    else
        xlen = 1;
    end
    
    % loops for a given window size defined as zdim-by-xdim
    for i = 1:(a-zlen)
        for j = 1:(b-xlen)
            if i == 1 && j == 1
                window = field(1:zlen,1:xlen);
            elseif i == 1
                window = field(1:zlen,j:(j+xlen));
            elseif j == 1
                window = field(i:(i+zlen),1:xlen);
            else
                window = field(i:(i+zlen),j:(j+xlen));
            end

            % compute the proportion of each facies within window
            [L1 L2] = size(window);
            ncells = L1*L2;
            facies_one = sum(sum(window))/ncells;
            facies_two = 1-facies_one;

            % compute and store local entropy value for the local window
            if facies_one == 0 || facies_two == 0
                HLtemp(i,j) = 0;
            else
                HLtemp(i,j) = - (facies_one*log(facies_one) + facies_two*log(facies_two));
            end
            HRtemp(i,j) = HLtemp(i,j)/HG;
        end
    end
    
    % get average HL for window size and store value
    HL(winsize) = mean(mean(HLtemp));
    HR(winsize) = mean(mean(HRtemp));
    clear HLtemp
    clear HRtemp
    
end

% define first HR value as 0 to set origin
HR(1) = 0;

% define values for x-axis of future plot (window x-dimension)
if xflag == 0
    windim = 0:xdim:((length(HR)-1)*xdim);
else
    windim = 0:ydim:((length(HR)-1)*ydim);
end

%% Plot the 2-D Entrogram
if xflag == 0
    xplotline = linspace(0,floor(((length(HR)-1)*xdim)),10000);
else
    xplotline = linspace(0,floor(((length(HR)-1)*ydim)),10000);
end

yplotline = xplotline./xplotline;

end

