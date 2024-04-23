FROM debian:bullseye-slim

LABEL maintainer="YeapGuy <yeapguy@tailmail.eu>"
LABEL repository="https://github.com/YeapGuy/docker-activitywatch-rust"

RUN mkdir /app
WORKDIR /app

RUN apt-get -qq -y update \
  && apt-get install -qq -y --no-install-recommends ca-certificates unzip wget \
  && wget -q -O - https://api.github.com/repos/activitywatch/activitywatch/releases \
  | grep "https" \
  | grep "linux-x86_64.zip" \
  | head -1 \
  | cut -d ":" -f 2,3 \
  | tr -d '", ' \
  | wget -q -i - \
  && unzip ./activitywatch*.zip \
  && rm ./activitywatch*.zip \
  && chmod +x ./activitywatch/aw-server-rust/aw-server-rust \
  && chmod +x ./activitywatch/aw-server-rust/aw-sync \
  && apt-get purge -qq -y --auto-remove ca-certificates unzip wget

COPY wrapper-script.sh wrapper-script.sh
EXPOSE 5600
SHELL ["/bin/bash", "-c"]
CMD ["/app/wrapper-script.sh"]
