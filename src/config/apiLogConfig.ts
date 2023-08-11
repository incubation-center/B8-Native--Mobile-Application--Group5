import { Request, Response, NextFunction } from 'express';

const logRequest = (req: Request, res: Response, next: NextFunction) => {
  const startTime = Date.now();
  res.on('finish', () => {
    const { method, url } = req;
    const { statusCode } = res;

    console.log(`[${new Date()}] ${method} ${url} ${statusCode} - ${Date.now() - startTime}ms`);
  });

  next();
};

export default logRequest;
