{
  services.home-assistant.config.zone = [
    {
      name = "Work";
      icon = "mdi:briefcase";
      latitude = "!secret work_latitude";
      longitude = "!secret work_longitude";
      radius = "300";
    }
    {
      name = "Cycling Track";
      icon = "mdi:bike";
      latitude = "!secret cycling_track_latitude";
      longitude = "!secret cycling_track_longitude";
      radius = "350";
    }
  ];
}
