% ---- Environment ----
irr.G_ref   = 1000;     % Reference irradiance [W/m^2] (STC)
irr.albedo = 0.2;       % Ground reflectance [-]
irr.Tamb   = 25;        % Ambient temperature [degC]

% ---- Panel orientation ----
panel.tilt_deg    = 30;     % Panel tilt from horizontal [deg]
panel.azimuth_deg = 180;    % Panel azimuth (south-facing) [deg]

% ---- Cell temperature model (optional) ----
panel.NOCT = 45;        % Nominal Operating Cell Temp [degC]

% ---- Sun defaults (can be overridden by signals in Simulink) ----
sun.alpha_deg  = 45;    % Sun elevation angle [deg]
sun.azimuth_deg = 180;  % Sun azimuth [deg]

% ---- Simple diffuse model toggle ----
irr.use_diffuse = true;

% Solar panel area m^2
panel.area = 10;