function [ distance, gamma ] = variogram_comp( field, xdim, ydim, xpts, ypts, vflag, hflag )
% function to compute variogram
%   input a 2D field
%   output is distance and gamma vectors

% default values if not specified
if nargin < 2
    xdim = 1;
    ydim = 1;
    [xpts, ypts] = size(field);
    if xpts > 20
        xpts = 20;
    end
    if ypts > 20
        ypts = 20;
    end
end

% flags if not specified
if nargin < 6
    vflag = 0;
    hflag = 0;
end

[a, b] = size(field);

% values for indicies of real matrix
zind = 1:round(a/xpts):a;
xind = 1:round(b/ypts):b;

if vflag == 0 && hflag == 0
    
    % initialize 3D matricies to hold all values
    hbig = zeros(xpts,ypts,xpts,ypts);
    gammabig = hbig;
    
    for i = 1:xpts
        for j = 1:ypts
            pt_one = field(zind(i),xind(j));    % identify first point

            for ii = 1:xpts
                for jj = 1:ypts
                    pt_two = field(zind(ii),xind(jj));  % second point

                    dist = sqrt( ((zind(ii)-zind(i))*xdim)^2 + ((xind(jj)-xind(j))*ydim)^2 );
                    hbig(i,j,ii,jj) = dist;

                    gam = (pt_two-pt_one)^2;
                    gammabig(i,j,ii,jj) = gam;
                end
            end
        end
    end

    % blank matricies to populate with distances and gamma vals
    newh = [];
    newgamma = [];

    % check term to ensure distances only used one
    gate = 0;

    for i = 1:xpts
        for j = 1:ypts
            for ii = 1:xpts
                for jj = 1:ypts
                    for b = 1:length(newh)
                        if hbig(i,j,ii,jj) == newh(b)
                            % to determine if distance already accounted for
                            gate = 1;
                        end
                    end
                    if gate == 0
                        htemp = hbig(i,j,ii,jj) == hbig;
                        n = sum(sum(sum(sum(htemp))));
                        gammatemp = htemp.*gammabig;
                        gammatemp = sum(sum(sum(sum(gammatemp)))) / n;
                        hval = hbig(i,j,ii,jj);

                        newh = [newh hval];
                        newgamma = [newgamma gammatemp];
                    end
                    % reset gate term
                    gate = 0;                
                end
            end
        end
    end

    [distance, index] = sort(newh); % sort distances in ascending order and get indicies

    for i = 1:length(index)
        gamma(i) = newgamma(index(i)); % match gamma values by index to sorted distance values
    end
end

if vflag == 1 && hflag == 0
    
    % initialize 3D matricies to hold all values
    hbig = zeros(xpts,ypts,xpts);
    gammabig = hbig;
    
    for i = 1:xpts
        for j = 1:ypts
            pt_one = field(zind(i),xind(j));    % identify first point

            for ii = 1:xpts
                pt_two = field(zind(ii),xind(j));  % second point

                dist = sqrt( ((zind(ii)-zind(i))*ydim)^2 );
                hbig(i,j,ii) = dist;

                gam = (pt_two-pt_one)^2;
                gammabig(i,j,ii) = gam;
            end

        end
    end

    % blank matricies to populate with distances and gamma vals
    newh = [];
    newgamma = [];

    % check term to ensure distances only used one
    gate = 0;

    for i = 1:xpts
        for j = 1:ypts
            for ii = 1:xpts
                for b = 1:length(newh)
                    if hbig(i,j,ii) == newh(b)
                        % to determine if distance already accounted for
                        gate = 1;
                    end
                end
                if gate == 0
                    htemp = hbig(i,j,ii) == hbig;
                    n = sum(sum(sum(htemp)));
                    gammatemp = htemp.*gammabig;
                    gammatemp = sum(sum(sum(gammatemp))) / n;
                    hval = hbig(i,j,ii);

                    newh = [newh hval];
                    newgamma = [newgamma gammatemp];
                end
                % reset gate term
                gate = 0;                          
            end
        end
    end
                
    [distance, index] = sort(newh); % sort distances in ascending order and get indicies

    for i = 1:length(index)
        gamma(i) = newgamma(index(i)); % match gamma values by index to sorted distance values
    end
end

if hflag == 1 && vflag == 0
    
    % initialize 3D matricies to hold all values
    hbig = zeros(xpts,ypts,ypts);
    gammabig = hbig;
    
    for i = 1:xpts
        for j = 1:ypts
            pt_one = field(zind(i),xind(j));    % identify first point

            for jj = 1:ypts
                pt_two = field(zind(i),xind(jj));  % second point

                dist = sqrt( ((xind(jj)-xind(j))*xdim)^2 );
                hbig(i,j,jj) = dist;

                gam = (pt_two-pt_one)^2;
                gammabig(i,j,jj) = gam;
            end
        end
    end

    % blank matricies to populate with distances and gamma vals
    newh = [];
    newgamma = [];

    % check term to ensure distances only used one
    gate = 0;

    for i = 1:xpts
        for j = 1:ypts
            for jj = 1:ypts
                for b = 1:length(newh)
                    if hbig(i,j,jj) == newh(b)
                        % to determine if distance already accounted for
                        gate = 1;
                    end
                end
                if gate == 0
                    htemp = hbig(i,j,jj) == hbig;
                    n = sum(sum(sum((htemp))));
                    gammatemp = htemp.*gammabig;
                    gammatemp = sum(sum(sum((gammatemp)))) / n;
                    hval = hbig(i,j,jj);

                    newh = [newh hval];
                    newgamma = [newgamma gammatemp];
                end
                % reset gate term
                gate = 0;                
            end

        end
    end
                
    [distance, index] = sort(newh); % sort distances in ascending order and get indicies

    for i = 1:length(index)
        gamma(i) = newgamma(index(i)); % match gamma values by index to sorted distance values
    end     
end


end

