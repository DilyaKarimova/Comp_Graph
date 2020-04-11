function [f,noise] = wienerAlgoritm(varargin)
[g, nhood, noise] = ParseInputs(varargin{:});

classin = class(g);
classChanged = false;
if ~isa(g, 'double')
  classChanged = true;
  g = im2double(g);
end

localMean = filter2(ones(nhood), g) / prod(nhood);
localVar = filter2(ones(nhood), g.^2) / prod(nhood) - localMean.^2;

if (isempty(noise))
  noise = mean2(localVar);
end

f = g - localMean;
g = localVar - noise; 
g = max(g, 0);
localVar = max(localVar, noise);
f = f ./ localVar;
f = f .* g;
f = f + localMean;

if classChanged
  f = images.internal.changeClass(classin, f);
end


function [g, nhood, noise] = ParseInputs(varargin)

nhood = [3 3];
noise = [];

switch nargin
case 0
    error(message('error'));
    
case 1
    g = varargin{1};
case 2
    g = varargin{1};
    switch numel(varargin{2})
    case 1
        noise = varargin{2};
    case 2
        nhood = varargin{2};
    otherwise
        error(message('error'))
    end
    
case 3
    g = varargin{1};        
    if (numel(varargin{3}) == 2)
        error(message('error'))
    else
        nhood = varargin{2};
        noise = varargin{3};
    end
    
case 4
    error(message('error'))
    g = varargin{1};
    nhood = varargin{2};
    noise = varargin{4};
    
otherwise
    error(message('error'));

end

if (ndims(g) == 3)
    error(message('error')); 
end
