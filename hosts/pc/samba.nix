{ config, lib, pkgs, ... }: {

  services.samba = {
    enable = true;
    openFirewall = true;
    shares = {
      time-machine = {
        comment = "Time Machine - Time Capsule for MacOS";
        path = "/home/nikita/backups/time-machine/%U";
        "guest ok" = false;
        "read only" = "no";
        "vfs objects" = "catia fruit streams_xattr";
        "fruit:time machine" = "yes";
        "fruit:copyfile" = "yes";
        #TODO: create separate user/group
        "force group" = "users";
        "force user" = "nikita";
        "fruit:encoding" = "native";
      };

      #time-machine = {
      #  comment = "Zeitmaschine - Time Capsule for MacOS";
      #  path = "/home/nikita/backups/time-machine";
      #  "guest ok" = false;
      #  "read only" = "no";
      #  browseable = "yes";
      #  #"force group" = "users";
      #  #"force user" = "nikita";
      #  "valid users" = "nikita,natali";
      #  "write list" = "nikita,natali";
      #  "vfs objects" = "catia fruit streams_xattr";
      #  "fruit:time machine" = "yes";
      #};
      #time-machine-natali = {
      #  comment = "Zeitmaschine - Time Capsule for MacOS";
      #  path = "/home/nikita/backups/time-machine-natali";
      #  "guest ok" = false;
      #  "read only" = "no";
      #  browseable = "yes";
      #  #"force group" = "users";
      #  #"force user" = "nikita";
      #  "valid users" = "natali";
      #  "write list" = "natali";
      #  "vfs objects" = "catia fruit streams_xattr";
      #  "fruit:time machine" = "yes";
      #};
    };
  };

  #services.avahi.extraServiceFiles = {
  #  mysmb = ''
  #    <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
  #    <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
  #    <service-group>
  #      <name replace-wildcards="yes">%h</name>
  #      <service>
  #        <type>_smb._tcp</type>
  #        <port>445</port>
  #      </service>
  #      <service>
  #        <type>_device-info._tcp</type>
  #        <port>9</port>
  #        <txt-record>model=TimeCapsule8,119</txt-record>
  #      </service>
  #      <service>
  #        <type>_adisk._tcp</type>
  #        <port>9</port>
  #        <txt-record>dk0=adVN=Zeitmaschine,adVF=0x82</txt-record>
  #        <txt-record>sys=adVF=0x100</txt-record>
  #      </service>
  #    </service-group>
  #  '';
  #};

  networking.firewall.allowedTCPPorts = [
    139
    445 # smbd
  ];

  networking.firewall.allowedUDPPorts = [
    137
    138 # nmbd
  ];

}
