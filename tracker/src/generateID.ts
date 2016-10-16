const ID_CHARS = '-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz';
let lastIDTime = 0;
let lastRandChars: Array<number> = [];

const generateID = (): string => {
  let now = new Date().getTime();
  const duplicateTime = (now === lastIDTime);
  lastIDTime = now;

  const timeStampChars = new Array(8);
  let i: number;
  for (i = 7; i >= 0; i--) {
    timeStampChars[i] = ID_CHARS.charAt(now % 64);
    now = Math.floor(now / 64);
  }
  if (now !== 0) throw new Error('We should have converted the entire timestamp.');

  let id = timeStampChars.join('');

  if (!duplicateTime) {
    for (i = 0; i < 12; i++) {
      lastRandChars[i] = Math.floor(Math.random() * 64);
    }
  } else {
    for (i = 11; i >= 0 && lastRandChars[i] === 63; i--) {
      lastRandChars[i] = 0;
    }
    lastRandChars[i]++;
  }
  for (i = 0; i < 12; i++) {
    id += ID_CHARS.charAt(lastRandChars[i]);
  }
  if(id.length != 20) throw new Error('Length should be 20.');

  return id;
}

export default generateID;
