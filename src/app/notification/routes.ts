import express from "express";
import { authenticateToken } from "../../helper/authenticationToken";
import {
    getAllNotifications,
    getNotificationByPropertyId
} from "./controller";

const router = express.Router();

router.get("/", authenticateToken, getAllNotifications);
router.get("/:id", authenticateToken, getNotificationByPropertyId);
export default router;
