#!/bin/bash
set -euxo pipefail

# configure the motd.
# NB this was generated at http://patorjk.com/software/taag/#p=display&f=Big&t=rke2%0Aserver.
#    it could also be generated with figlet.org.
cat >/etc/motd <<'EOF'

  _       _                _        ___  
 | |     | |              | |      |__ \ 
 | | __ _| |__ ______ _ __| | _____   ) |
 | |/ _` | '_ \______| '__| |/ / _ \ / / 
 | | (_| | |_) |     | |  |   <  __// /_ 
 |_|\__,_|_.__/      |_|  |_|\_\___|____|
                    | |                  
 __      _____  _ __| | _____ _ __       
 \ \ /\ / / _ \| '__| |/ / _ \ '__|      
  \ V  V / (_) | |  |   <  __/ |         
   \_/\_/ \___/|_|  |_|\_\___|_|         
                                         
                                         
EOF
