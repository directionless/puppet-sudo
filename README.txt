I needed to use sudo in puppet, but the normal way of including a 
sudoers.erb was too limited.

This module allows other modules to define fragments that are then 
included. This allows modules to know what they need in sudo, which 
allows for more decentralization among modules.

I opted to use sudo's internal directory options, but if you need
to support something older than 1.7, you can look at puppet's 
contributed concat file
