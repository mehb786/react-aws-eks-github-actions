FROM node:22-alpine3.19 as base
WORKDIR /app
COPY package.json package-lock.json  /app/
RUN npm install
COPY . .
RUN npm run build

FROM node:22-alpine3.19 as final
WORKDIR /app
COPY --from=base /app/build /app/build
COPY --from=base /app/node_modules/ /app/node_modules
COPY --from=base /app/package.json /app/package.json
COPY --from=base /app/. /app/
EXPOSE 3000
CMD [ "npm","start" ]
