function real = feature_AK_real_handLeftToFrontRelTorso(mot, varargin)

input_params = { 'threshold_vel1' , 'win_length_ms1' };

if( ~(nargin == 1 || nargin == 3) ) error('Wrong number of arguments.'); end


threshold_vel1 = 2;
win_length_ms1 = 100;
for i = 1:length(varargin);
    if(~isempty(varargin{i})) 
        eval([input_params{i} ' = varargin{i};']) ;
    end 
end 
lhumerus_length = sqrt(sum((mot.jointTrajectories{trajectoryID(mot,'lshoulder')}(:,1) - mot.jointTrajectories{trajectoryID(mot,'lelbow')}(:,1)).^2));

femur_length = 1/2*(sqrt(sum((mot.jointTrajectories{trajectoryID(mot,'lhip')}(:,1) - mot.jointTrajectories{trajectoryID(mot,'lknee')}(:,1)).^2))...
	                       + sqrt(sum((mot.jointTrajectories{trajectoryID(mot,'rhip')}(:,1) - mot.jointTrajectories{trajectoryID(mot,'rknee')}(:,1)).^2)));

real = feature_velRelPointPlane( mot, 'neck', 'rhip', 'lhip', 'lwrist', win_length_ms1 ) ./ femur_length;
