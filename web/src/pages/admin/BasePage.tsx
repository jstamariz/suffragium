import React from "react";
import clsx from "clsx";
import CssBaseline from "@material-ui/core/CssBaseline";
import Drawer from "@material-ui/core/Drawer";
import AppBar from "@material-ui/core/AppBar";
import Toolbar from "@material-ui/core/Toolbar";
import List from "@material-ui/core/List";
import Typography from "@material-ui/core/Typography";
import Divider from "@material-ui/core/Divider";
import IconButton from "@material-ui/core/IconButton";
import Container from "@material-ui/core/Container";
import MenuIcon from "@material-ui/icons/Menu";
import ChevronLeftIcon from "@material-ui/icons/ChevronLeft";
import { MainListItems } from "../../firebase/components/listItems";
import { DashboardStyles } from "./helpers/styles/DashboardStyles";
import { HowToVote } from "@material-ui/icons";
import { AdminRoutes } from "../../routes/AdminRoutes";
import { useEffect } from "react";

export default function BasePage() {
    const classes = DashboardStyles();
    const [open, setOpen] = React.useState(true);

    const handleDrawerOpen = () => {
        localStorage.setItem("dashBoardOpen", JSON.stringify("true"));
        setOpen(true);
    };

    const handleDrawerClose = () => {
        localStorage.setItem("dashBoardOpen", JSON.stringify("false"));
        setOpen(false);
    };

    useEffect(() => {
        setOpen(JSON.parse(localStorage.getItem("dashBoardOpen") ?? "false"));
    }, []);

    return (
        <div className={classes.root}>
            <CssBaseline />
            <AppBar
                position="absolute"
                className={clsx(classes.appBar, open && classes.appBarShift)}
            >
                <Toolbar className={classes.toolbar}>
                    <IconButton
                        edge="start"
                        color="inherit"
                        aria-label="open drawer"
                        onClick={handleDrawerOpen}
                        className={clsx(
                            classes.menuButton,
                            open && classes.menuButtonHidden
                        )}
                    >
                        <MenuIcon />
                    </IconButton>
                    <Typography
                        component="h1"
                        variant="h6"
                        color="inherit"
                        noWrap
                        className={classes.title}
                    >
                        <HowToVote /> Suffragium
                    </Typography>
                    <IconButton color="inherit"></IconButton>
                </Toolbar>
            </AppBar>
            <Drawer
                variant="permanent"
                classes={{
                    paper: clsx(
                        classes.drawerPaper,
                        !open && classes.drawerPaperClose
                    ),
                }}
                open={open}
            >
                <div className={classes.toolbarIcon}>
                    <IconButton onClick={handleDrawerClose}>
                        <ChevronLeftIcon />
                    </IconButton>
                </div>
                <Divider />
                <List>
                    <MainListItems />
                </List>
            </Drawer>
            <main className={classes.content}>
                <div className={classes.appBarSpacer} />
                <Container maxWidth="lg" className={classes.container}>
                    <AdminRoutes />
                </Container>
            </main>
        </div>
    );
}
