/* ---------------------------------------------------------------- *\

  file    : space_dapp.c
  author  : m. gumz <akira at fluxbox dot org>
  copyr   : copyright (c) 2006 by m. gumz

  license : MIT - license

  start   : Sun Sep 17 15:41:56 2006

\* ---------------------------------------------------------------- */
/* ---------------------------------------------------------------- *\

  about :

    simplest way for a dockapp i could come up with. use it to
    go further if you want.

    if you want to make it look like completly transparent
          you need to -DSHAPE and -lXext, otherwise not.

    compile with:

        gcc -o space_dapp space_dapp.c -DSHAPE \
            -I/usr/include/X11/ -lX11 -lXext
\* ---------------------------------------------------------------- */

/* ---------------------------------------------------------------- *\
  includes
\* ---------------------------------------------------------------- */
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <poll.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#ifdef SHAPE
#include <X11/extensions/shape.h>
#endif /* SHAPE */
/* ---------------------------------------------------------------- *\
\* ---------------------------------------------------------------- */
char dock_name[] = "space_dapp";

void usage() {
    printf("%s [width] [height]\n", dock_name);
}

int main(int argc, char* argv[]) {

    int w = -1;
    int h = -1;

    Display* dpy = NULL;
    Window dock_win = None;
    Window root_win = None;
    int screen = 0;


    {
        int i;
        for (i = 1; i < argc; i++) {
            char* arg = argv[i];
            if (strcmp(arg, "-h") == 0) {
                usage();
                return 0;
            } else if (w < 0) {
                int t = atoi(arg);
                if (t <= 0) {
                    fprintf(stderr, "error, width must be greater than 0.\n");
                    return EXIT_FAILURE;
                }
                w = t;
            } else if (h < 0) {
                int t = atoi(arg);
                if (t <= 0) {
                    fprintf(stderr, "error, height must be greater than 0.\n");
                    return EXIT_FAILURE;
                }
                h = t;
            }
        }
    }

    if (w == -1) {
        w = 1;
    }

    if (h == -1) {
        h = 1;
    }


    dpy = XOpenDisplay(NULL);
    assert(dpy != NULL);

    screen = DefaultScreen(dpy);
    root_win = RootWindow(dpy, screen);

    /* create the window */
    {
        XSizeHints size_hints;
        XWMHints   wm_hints;
        XClassHint class_hint;
        int        border_width = 1;

        size_hints.x = 0;
        size_hints.y = 0;
        size_hints.flags = USSize|USPosition;
        size_hints.width = w;
        size_hints.height = h;

        dock_win = XCreateSimpleWindow(dpy, root_win,
                                       size_hints.x, size_hints.y,
                                       size_hints.width, size_hints.height,
                                       border_width,
                                       WhitePixel(dpy, screen),
                                       BlackPixel(dpy, screen));
        assert(dock_win != None);

#ifdef SHAPE
        {
            const int bytes = ((w / 8) + 1) * h;
            char* mask = (char*)malloc(bytes);

            assert(mask != NULL);

            memset(mask, 0x00, bytes);

            {
                Pixmap pm = XCreateBitmapFromData(dpy, dock_win, mask, w, h);
                assert(pm != None);

                XShapeCombineMask(dpy, dock_win, ShapeBounding, 0, 0, pm, ShapeSet);

                XFreePixmap(dpy, pm);;
            }
        }
#endif /* SHAPE */


        XSetWMNormalHints(dpy, dock_win, &size_hints);

        class_hint.res_name = dock_name;
        class_hint.res_class = dock_name;
        XSetClassHint(dpy, dock_win, &class_hint);

        XSelectInput(dpy, 
                     dock_win,
                     ButtonPressMask|ExposureMask|ButtonReleaseMask|PointerMotionMask|StructureNotifyMask);

        wm_hints.initial_state = WithdrawnState;
        wm_hints.icon_window = None;
        wm_hints.window_group = dock_win;
        wm_hints.flags = StateHint | WindowGroupHint;
        XSetWMHints(dpy, dock_win, &wm_hints);

        XMapWindow(dpy, dock_win);
    }

    /* eventloop */
    {
        XEvent event;

        for (;;) {

            if (XPending(dpy)) {
                XNextEvent(dpy, &event);
                switch (event.type) {
                case DestroyNotify:
                    break;
                }
            }

            poll(NULL, 0, 25);
        }
    }

    XDestroyWindow(dpy, dock_win);
    XCloseDisplay(dpy);

    return EXIT_SUCCESS;
}

/* ---------------------------------------------------------------- *\
\* ---------------------------------------------------------------- */


