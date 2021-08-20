import { configureStore } from "@reduxjs/toolkit";
import { AppReducer } from "../helpers/reducers/appReducer";

export const store = configureStore({
    reducer: {
        app: AppReducer,
    },
});

