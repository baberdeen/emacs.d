#!/usr/bin/python
"""

:date: (>>>DATE<<<) 
:author: (>>>USER_NAME<<<)

"""
from __future__ import print_function


if __name__ == "__main__" :

    import sys
    try :
        import doctest

        def run_doctest():
            """
            Run doctest on this module.

            >>> 1
            1
            """
            doctest.testmod()

    def my_test():
        pass

    if len(sys.argv) == 2 and sys.argv[1] == "--doctest" : 
        run_doctest()
    else :
        my_test()

