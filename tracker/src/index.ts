import aly, { Header } from "./aly";

interface Config {
  url: string;
}

const request = (method: string, url: string, headers: Array<Header>, params: string) => {
  const httpRequest = new XMLHttpRequest();
  httpRequest.open(method, url, true);
  headers.forEach(header => {
    httpRequest.setRequestHeader(header.key, header.value);
  });
  httpRequest.send(params);
};

const clientAly = (config: Config) => {
  return aly({ url: config.url, cookie: document.cookie, request });
};

(<any>window).aly = clientAly;
