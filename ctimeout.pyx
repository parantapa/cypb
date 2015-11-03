# encoding: utf-8
"""
Hard process timeout.

NOTE: uses SIGALRM; so use of sleep calls are not allowed.
"""

from libc.stdio cimport printf, puts
from libc.stdlib cimport _exit
from libc.signal cimport sighandler_t, SIG_DFL, SIGALRM, signal
from posix.unistd cimport alarm

cdef void timeout_handler(int signum):
    printf("ctimeout: timeout handler received signal: %d\n", signum)
    puts("ctimeout: excuting hard exit")
    _exit(100)

def set_timeout(unsigned seconds):
    """
    Setup the process to execute hard exit after given seconds"
    """

    printf("ctimeout: setting up timeout after %u seconds\n", seconds)
    signal(SIGALRM, <sighandler_t> timeout_handler)
    alarm(seconds)

def unset_timeout():
    """
    Reset the hard exit handler.
    """

    alarm(0)
    signal(SIGALRM, SIG_DFL)
