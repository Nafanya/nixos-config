{
  config,
  lib,
  pkgs,
  ...
}:
{

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
    };
  };

  ## TODO: bonus -- add TimeCapsule icon
  ## Couldn't make it work today, not sure new Mac support it
  #services.avahi.extraServiceFiles = {
  #  smb = ''
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
  #        <txt-record>model=MacBookPro16,4</txt-record>
  #      </service>
  #      <service>
  #        <type>_adisk._tcp</type>
  #        <port>9</port>
  #        <txt-record>dk0=adVN=time-machine,adVF=0x82</txt-record>
  #        <txt-record>sys=adVF=0x100</txt-record>
  #      </service>
  #    </service-group>
  #  '';
  #};
}
