FROM ubuntu:22.04

#docker-composeから受け取った引数(proxyのアドレス)を環境変数にセット
ARG http_tmp
ARG https_tmp
ENV http_proxy=$http_tmp
ENV https_proxy=$https_tmp

#aptのTime Zone設定でハングアップしない様に予め指定及び設定する
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#コンテナ内で使用するパッケージをインストール
RUN apt update -y && apt upgrade -y
RUN apt install -y nano screen tmux systemd init nginx sed


#nginxのstreamに関する設定を追記
RUN echo "stream { include /workspace/*.stream.conf; }" >> /etc/nginx/nginx.conf 
