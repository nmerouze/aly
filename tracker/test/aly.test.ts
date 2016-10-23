/// <reference path="../../typings/index.d.ts" />
import { expect } from "chai";
import aly, { Header } from "../src/aly";

const mockRequest = (method: string, url: string, headers: Array<Header>, params: string) => {};

describe("aly", () => {
  it('sends a request to API', () => {
    const request = (method: string, url: string, headers: Array<Header>, params: string) => {
      expect(method).to.eq("POST");
      expect(url).to.eq("http://localhost/api/events");
      expect(headers).to.deep.equal([
        {
          key: "Content-Type",
          value: "application/x-www-form-urlencoded",
        },
      ]);
      expect(params).to.eq("event=pageview");
    };

    const tracker = aly({ url: 'http://localhost', cookie: "", request });
    tracker.call(['event=pageview']);
  });

  it("parses session id from cookie", () => {
    let cookie = "_aly=abc123";
    const tracker = aly({ url: "http://localhost", cookie: cookie, request: mockRequest });
    expect(tracker.getSessionID()).to.eq("abc123");
  });

  it("generates a new session id and store in cookie", () => {
    let cookie = "";
    const tracker = aly({ url: "http://localhost", cookie: cookie, request: mockRequest });
    tracker.getSessionID();
    expect(tracker.config.cookie).to.match(/^_aly=(.{20})$/);
  });
});
