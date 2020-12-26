# This is a simple node express based on alpine linux

## Prerequisite
- node version - `1.20.0`

## Implement setps
### 1. Setup simple express in local
1. npm intall -g yarn
2. yarn global add express-generator
3. express --no-view --git express-docker ## 不使用任何 View 模版
4. yarn # 安裝 package
5. node bin/www

### 2. Create .dockerignore file
Avoid to copy `node_modules` into docker container, so that we can create `.dockerignore` file.

```
node_modules
```

### 3. Create DockerFile

```
# 使用 Node 的版本 - node version => 12.20.0
FROM node:12.20.0-alpine

# Node 環境設定為 production
ENV NODE_ENV production

# Node 在容器內的位置
WORKDIR /usr/src/app

# 複製 package 設定
COPY ["package.json", "yarn.lock", "./"]

# 安全必要的套件
RUN yarn --production --silent

# 第一個 . 是我們本地位置
# 第二個 . 是 docker 裡面的專案位置
# 將我們的程式碼全部複製進去
COPY . .

# 開放對外的 port
EXPOSE 3000

# 執行專案
CMD yarn start
```

### 4. Build docker image

```
docker build -t joneshsu/alpine-express-docker:1.0.0 .
```

### 5. Run a docker container

```
docker run -d --name my-node -p 3000:3000 joneshsu/alpine-express-docker:1.0.0
```

### 6. enter localhost:3000 via your browser