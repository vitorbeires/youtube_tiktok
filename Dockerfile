FROM node:14.15.0

RUN set -xe \
 && apt update \
 && apt install -y curl dumb-init fonts-noto-cjk xvfb xz-utils \
 && curl -sSL https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz \
    | tar xJC /usr/bin/ ffmpeg-4.4-amd64-static/ffprobe ffmpeg-4.4-amd64-static/ffmpeg --strip 1 \
 && ffmpeg -version \
 && ffprobe -version \
 && rm -rf /var/lib/apt/lists/*



RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app

RUN npm install

ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 /usr/bin/dumb-init
RUN chmod 0777 /usr/bin/dumb-init


EXPOSE $PORT
# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku			
CMD npm start && xvfb-run -s -ac -screen 0 1280x1024x24


