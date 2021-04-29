#!/bin/bash

cat <<EOF > /var/www/html/index.nginx-debian.html
<html>
<body>
<h1>Hello from $(curl  -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/name")</h1>
</body>
</html>
