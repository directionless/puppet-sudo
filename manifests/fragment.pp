define sudo::fragment($template) {

  if $name =~ /\./ {
    fail("sudo does not allow a dot in filenames. sorry")
  }
  
  file { "/etc/sudoers.d/${name}":
    content => template("$template"),
    owner   => root,
    group   => root,
    mode    => "0440",
    require => File["/etc/sudoers.d"],
  }

  
  
}
