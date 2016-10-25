import generateID from "./generateID";

export interface Header {
  key: string;
  value: string;
}

export interface Data {
  event: string;
  session_id: string;
  properties: Object;
}

interface Request {
  (method: string, url: string, headers: Array<Header>, params: Data);
}

interface Config {
  url: string;
  cookie: string;
  request: Request;
}

interface CallFunc {
  (params: Data): void;
}

interface GetSessionFunc {
  (): string;
}

interface Aly {
  call: CallFunc;
  getSessionID: GetSessionFunc;
  config: Config;
}

let alyConfig: Config;

const getSessionID = (): string => {
  let sessionID: string = alyConfig.cookie.replace(/(?:(?:^|.*;\s*)_aly\s*\=\s*([^;]*).*$)|^.*$/, "$1");
  if (sessionID === "") {
    sessionID = generateID();
    alyConfig.cookie = `_aly=${sessionID}`;
  }

  return sessionID;
}

const call = (params: Data): void => {
  const headers = [
    {
      key: "Content-Type",
      value: "application/x-www-form-urlencoded",
    },
  ];

  alyConfig.request("POST", `${alyConfig.url}/api/events`, headers, params);
};

const aly = (config: Config): Aly => {
  alyConfig = config;
  return { config, call, getSessionID };
}

export default aly;
