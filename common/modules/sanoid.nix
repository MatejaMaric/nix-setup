{ ... }:
{
  services.sanoid = {
    enable = true;
    interval = "hourly";

    templates.myDefault = {
      hourly = 30;
      daily = 30;
      monthly = 3;
      autosnap = true;
      autoprune = true;
    };

    datasets = {
      "rpool/enc/home" = {
        useTemplate = [ "myDefault" ];
      };
    };

  };
}
