FROM golang:alpine

ENV GO111MODULE=on \
	CGO_ENABLED=0 \
	GOOS=linux \
	GOARCH=amd64 \
	REACT_APP_DEPLOYMENT=external

WORKDIR /stuff

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .

RUN go build -o main .

EXPOSE 3000

RUN echo "= 'http://corpoback.herokuapp.com/'" >> /stuff/create_company.js
CMD ["echo", "/stuff/create_company.js"]

CMD ["/stuff/main"]
