# 使用 Node 的版本 - node version => 12.20.0 
FROM node:12.20.0-alpine

# Node 環境設定為 production 
ENV NODE_ENV production

# Node 在容器內的位置
WORKDIR /usr/src/app

# 複製 package 設定
COPY ["package.json", "yarn.lock", "./"]

# 安全必要的套件並移動到專案的 node_modules 底下
RUN yarn --production --silent

# 第一個 . 是我們本地位置
# 第二個 . 是 docker 裡面的專案位置
# 將我們的程式碼全部複製進去
COPY . .

# 開放對外的 port
EXPOSE 3000

# 執行專案
CMD yarn start
