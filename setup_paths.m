function setup_paths()
% SETUP_PATHS  Add shared functions and input data to the MATLAB path.
%
%   Adds code/shared, data and data/contact_networks, so that scripts can
%   load the Haslemere data and contact networks by file name from any
%   figure folder. Every script in code/ calls this automatically.
%
%   The figure folders under code/ are deliberately NOT added: several of
%   them contain their own version of agent_based_simulator.m. Run each
%   figure's scripts with that figure's folder as the current folder.

repo_dir = fileparts(mfilename('fullpath'));
addpath(fullfile(repo_dir, 'code', 'shared'), ...
        fullfile(repo_dir, 'data'), ...
        fullfile(repo_dir, 'data', 'contact_networks'));
end
