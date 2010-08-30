class sudo {

  # 1.7.0 adds in include support, so we need at least it.
  # we've backported it to hardy.
  # there's no way to say "version at least FOO" so it's kinda grotty
  package { "sudo":
    ensure  => $lsbdistcodename ? { 
                  "hardy" => "1.7.2p1+nmu1", 
                  default => "latest",
               } ,
  }
  
  file { "/etc/sudoers":
    owner   => "root",
    group   => "root",
    mode    => 440,
    content => template("sudo/sudoers.erb"),
    require => [ Package["sudo"], Group["wheel"] ],
  }

  file { "/etc/sudoers.d":
    owner   => "root",
    group   => "root",
    mode    => 750,
    ensure  => directory,
    recurse => true,
    replace => true,
    purge   => true,
    before => File["/etc/sudoers"],
  }


  # sudo prefers the last match, so sort these default rules to the top
  sudo::fragment{ "000root":
    template => "sudo/root.sudoers.erb",
  }

  sudo::fragment{"000wheel":
   template => "sudo/wheel.sudoers.erb",
  }
}

