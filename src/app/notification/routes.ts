import express from "express";
import { authenticateToken } from "../../helper/authenticationToken";
import {
    getAllNotifications
} from "./controller";

const router = express.Router();

router.get("/", authenticateToken, getAllNotifications);
export default router;
